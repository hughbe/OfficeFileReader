//
//  HandoutContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.5.8 HandoutContainer
/// A container record that specifies the handout master slide.
public struct HandoutContainer {
    public let rh: RecordHeader
    public let drawing: DrawingContainer
    public let slideSchemeColorSchemeAtom: SlideSchemeColorSchemeAtom
    public let slideNameAtom: SlideNameAtom?
    public let slideProgTagsContainer: SlideProgTagsContainer?
    public let rgHandoutRoundTripAtom: [HandoutRoundTripAtom]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_Handout.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .handout else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// drawing (variable): A DrawingContainer record (section 2.5.13) that specifies the arrangement of content on the handout master slide.
        self.drawing = try DrawingContainer(dataStream: &dataStream)
        
        /// slideSchemeColorSchemeAtom (40 bytes): A SlideSchemeColorSchemeAtom record that specifies the color scheme for the handout
        /// master slide.
        self.slideSchemeColorSchemeAtom = try SlideSchemeColorSchemeAtom(dataStream: &dataStream)
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.slideNameAtom = nil
            self.slideProgTagsContainer = nil
            self.rgHandoutRoundTripAtom = []
            return
        }
        
        /// slideNameAtom (variable): An optional SlideNameAtom record that specifies the name for the handout master slide. It SHOULD<76> be
        /// preserved.
        if try dataStream.peekRecordHeader().recType == .cString {
            self.slideNameAtom = try SlideNameAtom(dataStream: &dataStream)
        } else {
            self.slideNameAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.slideProgTagsContainer = nil
            self.rgHandoutRoundTripAtom = []
            return
        }
        
        /// slideProgTagsContainer (variable): An optional SlideProgTagsContainer record that specifies a list of programmable tags.
        if try dataStream.peekRecordHeader().recType == .progTags {
            self.slideProgTagsContainer = try SlideProgTagsContainer(dataStream: &dataStream)
        } else {
            self.slideProgTagsContainer = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.rgHandoutRoundTripAtom = []
            return
        }
        
        /// rgHandoutRoundTripAtom (variable): An array of HandoutRoundTripAtom records that specifies round-trip information. The array continues
        /// while rh.recType of the HandoutRoundTripAtom item is equal to one of the following record types: RT_RoundTripTheme12Atom or
        /// RT_RoundTripColorMapping12Atom. Each record type MUST NOT appear more than once.
        var rgHandoutRoundTripAtom: [HandoutRoundTripAtom] = []
        while dataStream.position - startPosition < self.rh.recLen {
            let record = try dataStream.peekRecordHeader()
            guard record.recType == .roundTripTheme12Atom ||
                    record.recType == .roundTripColorMapping12Atom else {
                break
            }
            
            rgHandoutRoundTripAtom.append(try HandoutRoundTripAtom(dataStream: &dataStream))
        }
        
        self.rgHandoutRoundTripAtom = rgHandoutRoundTripAtom
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
