//
//  Dop2000.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.7.5 Dop2000
/// A structure that contains document and compatibility settings. These settings influence the appearance and behavior of the current document and
/// store document-level state.
public struct Dop2000 {
    public let dop97: Dop97
    public let ilvlLastBulletMain: UInt8
    public let ilvlLastNumberMain: UInt8
    public let istdClickParaType: UInt16
    public let fLADAllDone: Bool
    public let fEnvelopeVis: Bool
    public let fMaybeTentativeListInDoc: Bool
    public let fMaybeFitText: Bool
    public let empty1: UInt8
    public let fFCCAllDone: Bool
    public let fRelyOnCSS_WebOpt: Bool
    public let fRelyOnVML_WebOpt: Bool
    public let fAllowPNG_WebOpt: Bool
    public let screenSize_WebOpt: UInt8
    public let fOrganizeInFolder_WebOpt: Bool
    public let fUseLongFileNames_WebOpt: Bool
    public let iPixelsPerInch_WebOpt: UInt16
    public let fWebOptionsInit: Bool
    public let fMaybeFEL: Bool
    public let fCharLineUnits: Bool
    public let unused1: Bool
    public let copts: Copts
    public let verCompatPre10: CompatPre10
    public let fNoMargPgvwSaved: Bool
    public let unused2: Bool
    public let unused3: Bool
    public let unused4: Bool
    public let fBulletProofed: Bool
    public let empty2: Bool
    public let fSaveUim: Bool
    public let fFilterPrivacy: Bool
    public let empty3: Bool
    public let fSeenRepairs: Bool
    public let fHasXML: Bool
    public let unused5: Bool
    public let fValidateXML: Bool
    public let fSaveInvalidXML: Bool
    public let fShowXMLErrors: Bool
    public let fAlwaysMergeEmptyNamespace: Bool
    
    public init(dataStream: inout DataStream) throws {
        /// dop97 (500 bytes): A Dop97 that specifies document and compatibility settings.
        self.dop97 = try Dop97(dataStream: &dataStream)
        
        /// ilvlLastBulletMain (1 byte): SHOULD<180> specify the last bullet level applied via the toolbar before saving. MUST be between 0 and 9.
        /// Default is 0.
        let ilvlLastBulletMain: UInt8 = try dataStream.read()
        if ilvlLastBulletMain > 0x09 {
            throw OfficeFileError.corrupted
        }
        
        self.ilvlLastBulletMain = ilvlLastBulletMain
        
        /// ilvlLastNumberMain (1 byte): SHOULD<181> specify the last list numbering level applied via the toolbar before saving. MUST be between 0 and 9.
        /// Default is 0.
        let ilvlLastNumberMain: UInt8 = try dataStream.read()
        if ilvlLastNumberMain > 0x09 {
            throw OfficeFileError.corrupted
        }
        
        self.ilvlLastNumberMain = ilvlLastNumberMain
        
        /// istdClickParaType (2 bytes): Specifies the ISTD of the paragraph style to use for paragraphs that are automatically created by the click and type
        /// feature to place the cursor where the user clicked. Default value is 0 (Normal paragraph style).
        self.istdClickParaType = try dataStream.read(endianess: .littleEndian)
        
        var flags1: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fLADAllDone (1 bit): Specifies whether language auto-detection has run to completion for the document. Default is 0.
        self.fLADAllDone = flags1.readBit()
        
        /// B - fEnvelopeVis (1 bit): Specifies whether to show the E-Mail message header as specified in [ECMA-376] Part 4, Section 2.15.1.80
        /// showEnvelope. Default is 0.
        self.fEnvelopeVis = flags1.readBit()
        
        /// C - fMaybeTentativeListInDoc (1 bit): Specifies whether the document potentially contains tentative lists<182>. Default is 0. See LVLF.fTentative.
        self.fMaybeTentativeListInDoc = flags1.readBit()
        
        /// D - fMaybeFitText (1 bit): If this is 0, then there MUST NOT be any fit text (see sprmCFitText) in the document. Default is 0.
        self.fMaybeFitText = flags1.readBit()
        
        /// empty1 (4 bits): MUST be zero, and MUST be ignored.
        self.empty1 = UInt8(flags1.readBits(count: 4))
        
        /// E - fFCCAllDone (1 bit): Specifies whether the format consistency checker has run to completion for the document. Default is 0.
        self.fFCCAllDone = flags1.readBit()
        
        /// F - fRelyOnCSS_WebOpt (1 bit): Specifies whether to rely on CSS for font face formatting when saving as a Web page as specified in
        /// [ECMA-376] Part 4, Section 2.15.2.11 doNotRelyOnCSS, where the meaning is the opposite of fRelyOnCSS_WebOpt. The default is 1.
        self.fRelyOnCSS_WebOpt = flags1.readBit()
        
        /// G - fRelyOnVML_WebOpt (1 bit): Specifies whether to use VML when saving as a Web page as specified in [ECMA-376] Part 4, Section
        /// 2.15.2.34 relyOnVML. The default is 0.
        self.fRelyOnVML_WebOpt = flags1.readBit()
        
        /// H - fAllowPNG_WebOpt (1 bit): Specifies whether to allow Portable Network Graphics (PNG) format as a graphic format when saving as a
        /// Web page as specified in [ECMA-376] Part 4, Section 2.15.2.1 allowPNG. Default value is 0.
        self.fAllowPNG_WebOpt = flags1.readBit()
        
        /// I - screenSize_WebOpt (4 bits): Specifies what the target screen size for the Web page is as specified in [ECMA-376] Part 4, Section 2.15.2.41
        /// targetScreenSz, where screenSize_WebOpt value maps to ST_TargetScreenSz types as follows
        /// Value ST_TargetScreenSz string
        /// 0 544x376
        /// 1 640x480
        /// 2 720x512
        /// 3 (default) 800x600
        /// 4 1024x768
        /// 5 1152x882
        /// 6 1152x900
        /// 7 1280x1024
        /// 8 1600x1200
        /// 9 1800x1440
        /// 10 1920x1200
        self.screenSize_WebOpt = UInt8(flags1.readBits(count: 4))
        
        var flags2: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// J - fOrganizeInFolder_WebOpt (1 bit): Specifies whether to place supporting files in a subdirectory when saving as a Web page as specified in
        /// [ECMA-376] Part 4, Section 2.15.2.10 doNotOrganizeInFolder, where the meaning is the opposite of fOrganizeInFolder_WebOpt. The default
        /// is 1.
        self.fOrganizeInFolder_WebOpt = flags2.readBit()
        
        /// K - fUseLongFileNames_WebOpt (1 bit): Specifies whether to use file names longer than 8.3 characters when saving as a Web page as specified
        /// in [ECMA-376] Part 4, Section 2.15.2.13 doNotUseLongFileNames, where the meaning is the opposite of fUseLongFileNames_WebOpt.
        /// The default is 1.
        self.fUseLongFileNames_WebOpt = flags2.readBit()
        
        /// iPixelsPerInch_WebOpt (10 bits): Specifies the pixels per inch for graphics/images when saving as a Web page as specified in [ECMA-376]
        /// Part 4, Section 2.15.2.33 pixelsPerInch. If fWebOptionsInit is 1 then this MUST be between 19 and 480; otherwise, this is ignored. The default
        /// is 96.
        self.iPixelsPerInch_WebOpt = flags2.readBits(count: 10)
        
        /// L - fWebOptionsInit (1 bit): Specifies whether fRelyOnCSS_WebOpt, fRelyOnVML_WebOpt, fAllowPNG_WebOpt, screenSize_WebOpt,
        /// fOrganizeInFolder_WebOpt, fUseLongFileNames_WebOpt and iPixelsPerInch_WebOpt contain valid data. When fWebOptionsInit is set to 0, the
        /// value of all those fields MUST be ignored. The default is 0.
        self.fWebOptionsInit = flags2.readBit()
        
        /// M - fMaybeFEL (1 bit): If this is 0, then there MUST NOT be any Warichu, Tatenakayoko, Ruby, Kumimoji or EncloseText in the document.
        /// Enclose Text is a layout feature that uses EQ fields ([ECMA-376] part 4, section 2.16.5.22) to enclose characters in circles or other characters.
        /// The default is 0.
        self.fMaybeFEL = flags2.readBit()
        
        /// N - fCharLineUnits (1 bit): If this is 0, then there MUST NOT be any character unit indents (sprmPDxcLeft, sprmPDxcLeft1, sprmPDxcRight) or
        /// line units (sprmPDylBefore, sprmPDylAfter) in use. The default is 0.
        self.fCharLineUnits = flags2.readBit()
        
        /// O - unused1 (1 bit): Undefined and MUST be ignored.
        self.unused1 = flags2.readBit()
        
        /// copts (32 bytes): A copts that specifies compatibility options. Components of Copts.copts80 MUST be equal to components of Dop97.copts80.
        self.copts = try Copts(dataStream: &dataStream)
        
        /// verCompatPre10 (16 bits): A bit field that specifies the desired feature set to use for the document. This overrides DopBase.fWord97Compat.
        /// Values are composed from the following table:
        self.verCompatPre10 = CompatPre10(rawValue: try dataStream.read(endianess: .littleEndian))
        
        var flags3: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// P - fNoMargPgvwSaved (1 bit): Specifies whether to suppress the display of the header and footer area when in print layout view so that the
        /// main text area of one page is displayed adjacent to the main text area of the next page as specified in [ECMA-376] Part 4, Section 2.15.1.34
        /// doNotDisplayPageBoundaries. Default is 0.
        self.fNoMargPgvwSaved = flags3.readBit()
        
        /// Q - unused2 (1 bit): Undefined and MUST be ignored.
        self.unused2 = flags3.readBit()
        
        /// R - unused3 (1 bit): Undefined and MUST be ignored.
        self.unused3 = flags3.readBit()
        
        /// S - unused4 (1 bit): Undefined and MUST be ignored.
        self.unused4 = flags3.readBit()
        
        /// T - fBulletProofed (1 bit): Specifies that this document was produced by the Open and Repair feature. Default is 0.
        self.fBulletProofed = flags3.readBit()
        
        /// U - empty2 (1 bit): MUST be zero, and MUST be ignored.
        self.empty2 = flags3.readBit()
        
        /// V - fSaveUim (1 bit): Specifies whether to save UIM data in the document. Default is 1.
        self.fSaveUim = flags3.readBit()
        
        /// W - fFilterPrivacy (1 bit): Specifies whether to remove personal information from the document properties on save as specified in [ECMA-376]
        /// Part 4, Section 2.15.1.68 removePersonalInformation. Default is 0.
        self.fFilterPrivacy = flags3.readBit()
        
        /// X - empty3 (1 bit): MUST be zero, and MUST be ignored.
        self.empty3 = flags3.readBit()
        
        /// Y - fSeenRepairs (1 bit): Specifies whether the user has seen any repairs made by the Open and Repair feature. Default is 0.
        self.fSeenRepairs = flags3.readBit()
        
        /// Z - fHasXML (1 bit): Specifies whether the document has any form of structured document tags in it. Default is 0.
        self.fHasXML = flags3.readBit()
        
        /// a - unused5 (1 bit): Undefined and MUST be ignored.
        self.unused5 = flags3.readBit()
        
        /// b - fValidateXML (1 bit): Specifies whether to validate custom XML markup against any attached schemas as specified in [ECMA-376] Part 4,
        /// Section 2.15.1.42 doNotValidateAgainstSchema, where the meaning is the opposite of fValidateXML. Default is 1.
        self.fValidateXML = flags3.readBit()
        
        /// c - fSaveInvalidXML (1 bit): Specifies whether to allow saving the document as an XML file when the custom XML markup is invalid with respect
        /// to the attached schemas as specified in [ECMA376] Part 4, Section 2.15.1.74 saveInvalidXml. Default is 0.
        self.fSaveInvalidXML = flags3.readBit()
        
        /// d - fShowXMLErrors (1 bit): Specifies whether to show a visual indicator for invalid custom XML markup as specified in [ECMA-376] Part 4,
        /// Section 2.15.1.33 doNotDemarcateInvalidXml, where the meaning is the opposite of fShowXMLErrors.
        self.fShowXMLErrors = flags3.readBit()
        
        /// e - fAlwaysMergeEmptyNamespace (1 bit): Specifies whether to consider custom XML elements with no namespace as valid on open as specified
        /// in [ECMA-376] Part 4, Section 2.15.1.3 alwaysMergeEmptyNamespace. Default is 0.
        self.fAlwaysMergeEmptyNamespace = flags3.readBit()
    }
    
    /// verCompatPre10 (16 bits): A bit field that specifies the desired feature set to use for the document. This overrides DopBase.fWord97Compat. Values
    /// are composed from the following table:
    /// All other bits are undefined and MUST be ignored.
    public struct CompatPre10: OptionSet {
        public let rawValue: UInt16
        
        public init(rawValue: UInt16) {
            self.rawValue = rawValue
        }
        
        /// 0x0000 (default) No Restrictions on feature use
        public static let noRestrictions = CompatPre10([])
        
        /// 0x0004 Use only features available in Microsoft Word for Windows 95.
        public static let useOnlyFeaturesInWord95 = CompatPre10(rawValue: 0x0004)
        
        /// 0x0008 Use only features available in Microsoft Word 97.
        public static let useOnlyFeaturesInWord97 = CompatPre10(rawValue: 0x0008)
        
        /// 0x0040 Use only features available in the East Asian release of Word for Windows 95.
        public static let useOnlyFeaturesInEastAsianWord95 = CompatPre10(rawValue: 0x0008)
        
        /// 0x0800 Use only features available in Microsoft Office Word 2003.
        public static let useOnlyFeaturesInWord2003 = CompatPre10(rawValue: 0x0800)
        
        public static let all: CompatPre10 = [.noRestrictions, .useOnlyFeaturesInWord95, .useOnlyFeaturesInWord97, .useOnlyFeaturesInEastAsianWord95, .useOnlyFeaturesInWord2003]
    }
}
