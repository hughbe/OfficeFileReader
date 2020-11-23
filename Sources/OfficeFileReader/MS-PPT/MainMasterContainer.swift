//
//  MainMasterContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.5.3 MainMasterContainer
/// Referenced by: MasterOrSlideContainer
/// A container record that specifies a main master slide.
public struct MainMasterContainer {
    public let rh: RecordHeader
    public let slideAtom: SlideAtom
    public let rgSchemeListElementColorScheme: [SchemeListElementColorSchemeAtom]
    public let rgTextMasterStyle: [TextMasterStyleAtom]
    public let roundTripOArtTextStyles12Atom: RoundTripOArtTextStyles12Atom?
    public let slideShowSlideInfoAtom: SlideShowSlideInfoAtom?
    public let perSlideHeadersFootersContainer: PerSlideHeadersFootersContainer?
    public let drawing: DrawingContainer
    public let slideSchemeColorSchemeAtom: SlideSchemeColorSchemeAtom
    public let slideNameAtom: SlideNameAtom?
    public let slideProgTagsContainer: SlideProgTagsContainer?
    public let rgRoundTripMainMaster: [RoundTripMainMasterRecord]
    public let templateNameAtom: TemplateNameAtom?
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_MainMaster.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .mainMaster else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// slideAtom (32 bytes): A SlideAtom record that specifies slide-specific information.
        self.slideAtom = try SlideAtom(dataStream: &dataStream)
        
        /// rgSchemeListElementColorScheme (variable): An array of SchemeListElementColorSchemeAtom record that specifies a list of color
        /// schemes. The array continues while the rh.recType field of each SchemeListElementColorSchemeAtom item is equal to RT_ColorSchemeAtom.
        var rgSchemeListElementColorScheme: [SchemeListElementColorSchemeAtom] = []
        while dataStream.position - startPosition < self.rh.recLen {
            guard try dataStream.peekRecordHeader().recType == .colorSchemeAtom else {
                break
            }
             
            rgSchemeListElementColorScheme.append(try SchemeListElementColorSchemeAtom(dataStream: &dataStream))
        }
        
        self.rgSchemeListElementColorScheme = rgSchemeListElementColorScheme
        
        /// rgTextMasterStyle (variable): An array of TextMasterStyleAtom record that specifies text formatting for this main master slide. It MUST
        /// contain at least one item with rh.recInstance equal to 0x000 (title placeholder) and at least one item with rh.recInstance equal to 0x001
        /// (body placeholder). If this MainMasterContainer record is referenced by the first MasterPersistAtom record (section 2.4.14.2) contained
        /// within the MasterListWithTextContainer record (section 2.4.14.1), this array MUST also contain at least one item with rh.recInstance equal
        /// to 0x002 (notes placeholder). The array continues while the rh.recType field of each TextMasterStyleAtom item is equal to
        /// RT_TextMasterStyleAtom.
        var rgTextMasterStyle: [TextMasterStyleAtom] = []
        while dataStream.position - startPosition < self.rh.recLen {
            guard try dataStream.peekRecordHeader().recType == .textMasterStyleAtom else {
                break
            }
            
            rgTextMasterStyle.append(try TextMasterStyleAtom(dataStream: &dataStream))
        }
        
        self.rgTextMasterStyle = rgTextMasterStyle
        
        /// roundTripOArtTextStyles12Atom (variable): An optional RoundTripOArtTextStyles12Atom record that specifies round-trip information.
        /// It SHOULD<49> be ignored and SHOULD<50> be preserved.
        if try dataStream.peekRecordHeader().recType == .roundTripOArtTextStyles12Atom {
            self.roundTripOArtTextStyles12Atom = try RoundTripOArtTextStyles12Atom(dataStream: &dataStream)
        } else {
            self.roundTripOArtTextStyles12Atom = nil
        }
        
        /// slideShowSlideInfoAtom (24 bytes): An optional SlideShowSlideInfoAtom record that specifies slide show information for this main
        /// master slide.
        if try dataStream.peekRecordHeader().recType == .slideShowSlideInfoAtom {
            self.slideShowSlideInfoAtom = try SlideShowSlideInfoAtom(dataStream: &dataStream)
        } else {
            self.slideShowSlideInfoAtom = nil
        }
        
        /// perSlideHeadersFootersContainer (variable): An optional PerSlideHeadersFootersContainer record that specifies header and footer
        /// information for this main master slide. It SHOULD<51> be preserved.
        if try dataStream.peekRecordHeader().recType == .headersFooters {
            self.perSlideHeadersFootersContainer = try PerSlideHeadersFootersContainer(dataStream: &dataStream)
        } else {
            self.perSlideHeadersFootersContainer = nil
        }
        
        /// drawing (variable): A DrawingContainer record (section 2.5.13) that specifies drawing information for this main master slide.
        self.drawing = try DrawingContainer(dataStream: &dataStream)
        
        /// slideSchemeColorSchemeAtom (40 bytes): A SlideSchemeColorSchemeAtom record that specifies the color scheme for this main master
        /// slide.
        self.slideSchemeColorSchemeAtom = try SlideSchemeColorSchemeAtom(dataStream: &dataStream)

        if dataStream.position - startPosition == self.rh.recLen {
            self.slideNameAtom = nil
            self.slideProgTagsContainer = nil
            self.rgRoundTripMainMaster = []
            self.templateNameAtom = nil
            return
        }
        
        /// slideNameAtom (variable): An optional SlideNameAtom record that specifies the name of this main master slide. It SHOULD<52> be
        /// preserved.
        let nextAtom1 = try dataStream.peekRecordHeader()
        if nextAtom1.recType == .cString && nextAtom1.recInstance == 0x003 {
            self.slideNameAtom = try SlideNameAtom(dataStream: &dataStream)
        } else {
            self.slideNameAtom = nil
        }

        if dataStream.position - startPosition == self.rh.recLen {
            self.slideProgTagsContainer = nil
            self.rgRoundTripMainMaster = []
            self.templateNameAtom = nil
            return
        }
        
        /// slideProgTagsContainer (variable): An optional SlideProgTagsContainer record that specifies a list of programmable tags.
        if try dataStream.peekRecordHeader().recType == .progTags {
            self.slideProgTagsContainer = try SlideProgTagsContainer(dataStream: &dataStream)
        } else {
            self.slideProgTagsContainer = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.rgRoundTripMainMaster = []
            self.templateNameAtom = nil
            return
        }
        
        /// rgRoundTripMainMaster (variable): An array of RoundTripMainMasterRecord records that specifies additional data for this main master slide.
        /// The array continues while rh.recType of the RoundTripMainMasterRecord item is equal to one of the following record types:
        /// RT_RoundTripOriginalMainMasterId12Atom, RT_RoundTripTheme12Atom, RT_RoundTripColorMapping12Atom,
        /// RT_RoundTripContentMasterInfo12Atom, RT_RoundTripOArtTextStyles12Atom, RT_RoundTripAnimationHashAtom12Atom,
        /// RT_RoundTripAnimationAtom12Atom, or RT_RoundTripCompositeMasterId12Atom. Each record type MUST NOT appear more than once,
        /// except for the RT_RoundTripContentMasterInfo12Atom record type.
        var rgRoundTripMainMaster: [RoundTripMainMasterRecord] = []
        while dataStream.position - startPosition < self.rh.recLen {
            let record = try dataStream.peekRecordHeader()
            guard record.recType == .roundTripOriginalMainMasterId12Atom ||
                    record.recType == .roundTripTheme12Atom ||
                    record.recType == .roundTripColorMapping12Atom ||
                    record.recType == .roundTripContentMasterInfo12Atom ||
                    record.recType == .roundTripOArtTextStyles12Atom ||
                    record.recType == .roundTripAnimationHashAtom12Atom ||
                    record.recType == .roundTripAnimationAtom12Atom ||
                    record.recType == .roundTripCompositeMasterId12Atom else {
                break
            }
            
            rgRoundTripMainMaster.append(try RoundTripMainMasterRecord(dataStream: &dataStream))
        }
        
        self.rgRoundTripMainMaster = rgRoundTripMainMaster
        
        /// templateNameAtom (variable): An optional TemplateNameAtom record that specifies the design name of this main master slide.
        let nextAtom2 = try dataStream.peekRecordHeader()
        if nextAtom2.recType == .cString && nextAtom2.recInstance == 0x002 {
            self.templateNameAtom = try TemplateNameAtom(dataStream: &dataStream)
        } else {
            self.templateNameAtom = nil
        }
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
