//
//  SlideContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.5.1 SlideContainer
/// Referenced by: MasterOrSlideContainer
/// A container record that specifies a presentation slide or title master slide.
/// Let the corresponding master slide be the MainMasterContainer record (section 2.5.3) or SlideContainer record specified by slideAtom.masterIdRef.
/// Let the corresponding notes slide be the NotesContainer record (section 2.5.6) specified by slideAtom.notesIdRef.
public struct SlideContainer {
    public let rh: RecordHeader
    public let slideAtom: SlideAtom
    public let slideShowSlideInfoAtom: SlideShowSlideInfoAtom?
    public let perSlideHFContainer: PerSlideHeadersFootersContainer?
    public let rtSlideSyncInfo12: RoundTripSlideSyncInfo12Container?
    public let drawing: DrawingContainer
    public let slideSchemeColorSchemeAtom: SlideSchemeColorSchemeAtom
    public let slideNameAtom: SlideNameAtom?
    public let slideProgTagsContainer: SlideProgTagsContainer?
    public let rgRoundTripSlide: [RoundTripSlideRecord]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_Slide.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .slide else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// slideAtom (32 bytes): A SlideAtom record that specifies slide-specific information.
        self.slideAtom = try SlideAtom(dataStream: &dataStream)
        
        /// slideShowSlideInfoAtom (24 bytes): An optional SlideShowSlideInfoAtom record that specifies slide transition information.
        if try dataStream.peekRecordHeader().recType == .slideShowSlideInfoAtom {
            self.slideShowSlideInfoAtom = try SlideShowSlideInfoAtom(dataStream: &dataStream)
        } else {
            self.slideShowSlideInfoAtom = nil
        }
        
        /// perSlideHFContainer (variable): An optional PerSlideHeadersFootersContainer record that specifies header and footer information for
        /// this slide. It SHOULD<31> be preserved.
        if try dataStream.peekRecordHeader().recType == .headersFooters {
            self.perSlideHFContainer = try PerSlideHeadersFootersContainer(dataStream: &dataStream)
        } else {
            self.perSlideHFContainer = nil
        }

        /// rtSlideSyncInfo12 (variable): An optional RoundTripSlideSyncInfo12Container record that specifies round-trip information. It SHOULD<32>
        /// be ignored and SHOULD<33> be preserved.
        if try dataStream.peekRecordHeader().recType == .roundTripSlideSyncInfo12 {
            self.rtSlideSyncInfo12 = try RoundTripSlideSyncInfo12Container(dataStream: &dataStream)
        } else {
            self.rtSlideSyncInfo12 = nil
        }
        
        /// drawing (variable): A DrawingContainer (section 2.5.13) that specifies drawing information for this slide.
        self.drawing = try DrawingContainer(dataStream: &dataStream)
        
        /// slideSchemeColorSchemeAtom (40 bytes): A SlideSchemeColorSchemeAtom record that specifies the color scheme for this slide. If
        /// slideAtom.slideFlags.fMasterScheme is set, then the SlideSchemeColorSchemeAtom record contained by the corresponding master
        /// slide is used instead.
        self.slideSchemeColorSchemeAtom = try SlideSchemeColorSchemeAtom(dataStream: &dataStream)
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.slideNameAtom = nil
            self.slideProgTagsContainer = nil
            self.rgRoundTripSlide = []
            return
        }
        
        /// slideNameAtom (variable): An optional SlideNameAtom record that specifies the name of this slide. It SHOULD<34> be preserved.
        if try dataStream.peekRecordHeader().recType == .cString {
            self.slideNameAtom = try SlideNameAtom(dataStream: &dataStream)
        } else {
            self.slideNameAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.slideProgTagsContainer = nil
            self.rgRoundTripSlide = []
            return
        }
        
        /// slideProgTagsContainer (variable): An optional SlideProgTagsContainer record that specifies a list of programmable tags.
        if try dataStream.peekRecordHeader().recType == .progTags {
            self.slideProgTagsContainer = try SlideProgTagsContainer(dataStream: &dataStream)
        } else {
            self.slideProgTagsContainer = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.rgRoundTripSlide = []
            return
        }
        
        /// rgRoundTripSlide (variable): An array of RoundTripSlideRecord records that specifies round-trip information. The array continues while
        /// rh.recType of the RoundTripSlideRecord item is equal to one of the following record types: RT_RoundTripTheme12Atom,
        /// RT_RoundTripColorMapping12Atom, RT_RoundTripCompositeMasterId12Atom, RT_RoundTripSlideSyncInfo12,
        /// RT_RoundTripAnimationHashAtom12Atom, RT_RoundTripAnimationAtom12Atom, or RT_RoundTripContentMasterId12Atom.
        /// Each record type MUST NOT appear more than once.
        var rgRoundTripSlide: [RoundTripSlideRecord] = []
        while dataStream.position - startPosition < self.rh.recLen {
            let record = try dataStream.peekRecordHeader()
            guard record.recType == .roundTripTheme12Atom ||
                    record.recType == .roundTripColorMapping12Atom ||
                    record.recType == .roundTripCompositeMasterId12Atom ||
                    record.recType == .roundTripSlideSyncInfo12 ||
                    record.recType == .roundTripAnimationHashAtom12Atom ||
                    record.recType == .roundTripAnimationAtom12Atom ||
                    record.recType == .roundTripContentMasterId12Atom else {
                break
            }
            
            rgRoundTripSlide.append(try RoundTripSlideRecord(dataStream: &dataStream))
        }
        
        self.rgRoundTripSlide = rgRoundTripSlide
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
