//
//  Dop2002.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.7.6 Dop2002
/// A structure that contains document and compatibility settings. These settings influence the appearance and behavior of the current document and store
/// document-level state.
public struct Dop2002 {
    public let dop2000: Dop2000
    public let unused: UInt32
    public let fDoNotEmbedSystemFont: Bool
    public let fWordCompat: Bool
    public let fLiveRecover: Bool
    public let fEmbedFactoids: Bool
    public let fFactoidXML: Bool
    public let fFactoidAllDone: Bool
    public let fFolioPrint: Bool
    public let fReverseFolio: Bool
    public let iTextLineEnding: TextLineEnding
    public let fHideFcc: Bool
    public let fAcetateShowMarkup: Bool
    public let fAcetateShowAtn: Bool
    public let fAcetateShowInsDel: Bool
    public let fAcetateShowProps: Bool
    public let istdTableDflt: UInt16
    public let verCompat: VersionCompat
    public let grfFmtFilter: UInt16
    public let iFolioPages: UInt16
    public let cpgText: UInt32
    public let cpMinRMText: CP
    public let cpMinRMFtn: CP
    public let cpMinRMHdd: CP
    public let cpMinRMAtn: CP
    public let cpMinRMEdn: CP
    public let cpMinRmTxbx: CP
    public let cpMinRmHdrTxbx: CP
    public let rsidRoot: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// dop2000 (544 bytes): A Dop2000 that specifies document and compatibility settings.
        self.dop2000 = try Dop2000(dataStream: &dataStream)
        
        /// unused (4 bytes): Undefined and MUST be ignored.
        self.unused = try dataStream.read(endianess: .littleEndian)
        
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fDoNotEmbedSystemFont (1 bit): Specifies whether common system fonts are not to be embedded as specified in [ECMA-376] Part 4,
        /// Section 2.8.2.7 embedSystemFonts, where the meaning is the opposite of fDoNotEmbedSystemFont and the embedTrueTypeFonts element
        /// refers to DopBase.fEmbedFonts. Default is 1.
        self.fDoNotEmbedSystemFont = flags.readBit()
        
        /// B - fWordCompat (1 bit): Specifies that features not compatible with the settings specified in verCompat will be disabled or removed when saving.
        /// Default is 0.
        self.fWordCompat = flags.readBit()
        
        /// C - fLiveRecover (1 bit): Specifies that this file is a recovered document from after a crash. Default is 0.
        self.fLiveRecover = flags.readBit()
        
        /// D - fEmbedFactoids (1 bit): Specifies whether smart tags are to remain in the document when saving. Smart tags are to be removed when
        /// fEmbedFactoids is set to 0. See [ECMA-376] Part 4, Section 2.15.1.35 doNotEmbedSmartTags, where the meaning is the opposite of
        /// fEmbedFactoids. Default is 1.
        self.fEmbedFactoids = flags.readBit()
        
        /// E - fFactoidXML (1 bit): Specifies whether to save smart tag data as an XML-based property bag at the head of the HTML page when saving
        /// as HTML as specified in [ECMA-376] Part 4, Section 2.15.2.36 saveSmartTagsAsXml. Default is 0.
        self.fFactoidXML = flags.readBit()
        
        /// F - fFactoidAllDone (1 bit): Specifies whether the document has been completely scanned for all possible smart tag creations. Default is 0.
        self.fFactoidAllDone = flags.readBit()
        
        /// G - fFolioPrint (1 bit): Specifies whether to use book fold printing as specified in [ECMA-376] Part 4, Section 2.15.1 11 bookFoldPrinting.
        /// Default is 0.
        self.fFolioPrint = flags.readBit()
        
        /// H - fReverseFolio (1 bit): Specifies whether to use reverse book fold printing as specified in [ECMA376] Part 4, Section 2.15.1.13
        /// bookFoldRevPrinting. If this is 1 then fFolioPrint MUST be 1. Default is 0.
        self.fReverseFolio = flags.readBit()
        
        /// I - iTextLineEnding (3 bits): Specifies what to end a line of text with when saving as a text file via automation. It MUST be one of the values in
        /// the following table:
        let iTextLineEndingRaw = UInt8(flags.readBits(count: 3))
        guard let iTextLineEnding = TextLineEnding(rawValue: iTextLineEndingRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.iTextLineEnding = iTextLineEnding
        
        /// J  - fHideFcc (1 bit): Specifies whether to refrain from showing a visual cue around ranges flagged by the format consistency checker as suspect.
        /// Default is 0.
        self.fHideFcc = flags.readBit()
        
        /// K - fAcetateShowMarkup (1 bit): Specifies whether to visually indicate any additional nonprinting area used to display annotations when the
        /// annotations in this document are displayed. Default is 1.
        self.fAcetateShowMarkup = flags.readBit()
        
        /// L - fAcetateShowAtn (1 bit): Specifies if comments are included when the contents of this document are displayed. Default is 1.
        self.fAcetateShowAtn = flags.readBit()
        
        /// M - fAcetateShowInsDel (1 bit): Specifies if revisions to content are included when the contents of this document are displayed. Default is 1.
        self.fAcetateShowInsDel = flags.readBit()
        
        /// N - fAcetateShowProps (1 bit): Specifies whether property revision marks are included when the contents of this document are displayed.
        /// Default is 1.
        self.fAcetateShowProps = flags.readBit()
        
        /// istdTableDflt (16 bits): An istd that specifies the default table style for newly inserted tables.
        self.istdTableDflt = try dataStream.read(endianess: .littleEndian)
        
        /// verCompat (16 bits): A bit field that specifies the desired feature set to use for the document. This overrides DopBase.fWord97Compat and
        /// Dop2000.verCompatPre10. The bit values are as follows:
        self.verCompat = VersionCompat(rawValue: try dataStream.read(endianess: .littleEndian))
        
        /// grfFmtFilter (2 bytes): Specifies the suggested filtering for the list of document styles as specified in [ECMA-376] Part 4, Section 2.15.1.86
        /// stylePaneFormatFilter. Default is 0x5024.
        self.grfFmtFilter = try dataStream.read(endianess: .littleEndian)
        
        /// iFolioPages (2 bytes): Specifies the number of pages per booklet as specified in [ECMA-376] Part 4, Section 2.15.1.12 bookFoldPrintingSheets,
        /// where bookFoldPrinting refers to fFolioPrint and bookFoldRevPrinting refers to fReverseFolio. Default is 0.
        self.iFolioPages = try dataStream.read(endianess: .littleEndian)
        
        /// cpgText (4 bytes): Specifies the code page to use when saving as encoded text. Default is the current Windows ANSI code page for the system.
        self.cpgText = try dataStream.read(endianess: .littleEndian)
        
        /// cpMinRMText (4 bytes): A CP in the main document before which there are no revisions. Default is 0.
        self.cpMinRMText = try dataStream.read(endianess: .littleEndian)
        
        /// cpMinRMFtn (4 bytes): A CP in the footnote document before which there are no revisions. Default is 0.
        self.cpMinRMFtn = try dataStream.read(endianess: .littleEndian)
        
        /// cpMinRMHdd (4 bytes): A CP in the header document before which there are no revisions. Default is 0.
        self.cpMinRMHdd = try dataStream.read(endianess: .littleEndian)
        
        /// cpMinRMAtn (4 bytes): A CP in the comment document before which there are no revisions. Default is 0.
        self.cpMinRMAtn = try dataStream.read(endianess: .littleEndian)
        
        /// cpMinRMEdn (4 bytes): A CP in the endnote document before which there are no revisions. Default is 0.
        self.cpMinRMEdn = try dataStream.read(endianess: .littleEndian)
        
        /// cpMinRmTxbx (4 bytes): A CP in the textbox document for the main document before which there are no revisions. Default is 0.
        self.cpMinRmTxbx = try dataStream.read(endianess: .littleEndian)
        
        /// cpMinRmHdrTxbx (4 bytes): A CP in the header textbox document before which there are no revisions. Default is 0.
        self.cpMinRmHdrTxbx = try dataStream.read(endianess: .littleEndian)
        
        /// rsidRoot (4 bytes): Specifies the original document revision save ID as specified in [ECMA-376] Part 4, Section 2.15.1.71 rsidRoot.
        /// By default the rsidRoot is not that of the currently running session.
        self.rsidRoot = try dataStream.read(endianess: .littleEndian)
    }
    
    /// I - iTextLineEnding (3 bits): Specifies what to end a line of text with when saving as a text file via automation. It MUST be one of the values in the
    /// following table:
    public enum TextLineEnding: UInt8 {
        /// 0 (default) Carriage return (0x0D) followed by line feed (0x0A).
        case carriageReturnFollowedByLineFeed = 0
        
        /// 1 Carriage return (0x0D).
        case carriageReturn = 1
        
        /// 2 Line feed (0x0A).
        case lineFeed = 2
        
        /// 3 Line feed (0x0A) followed by carriage return (0x0D).
        case lineFeedFollowedByCarriageReturn = 3
        
        /// 4 If the code page supports it, Line Separator (U+2028) or Paragraph Separator (U+2029) otherwise behave as follows:
        ///  If the codepage is CP_JAPANEUC, CP_CHINAEUC, CP_KOREAEUC or CP_TAIWANEUC treat as if the value were 2.
        ///  If the code page is greater than or equal to 10000 and less than 20000, then treat as if the value where 1.
        ///  If neither of those apply, then treat as if the value were 0.
        case codePageDependent = 4
    }
    
    /// verCompat (16 bits): A bit field that specifies the desired feature set to use for the document. This overrides DopBase.fWord97Compat and
    /// Dop2000.verCompatPre10. The bit values are as follows:
    /// Default is 0.
    public struct VersionCompat: OptionSet {
        public let rawValue: UInt16
        
        public init(rawValue: UInt16) {
            self.rawValue = rawValue
        }
        
        /// 0x0000 No restrictions on feature use
        public static let noRestrictions = VersionCompat([])
        
        /// 0x0001 Use features supported by Microsoft® Internet Explorer® 4.0.
        public static let useFeaturesSupportedByInternetExplorer4 = VersionCompat(rawValue: 0x0001)
        
        /// 0x0002 Use features supported by Microsoft® Internet Explorer® 5.0.
        public static let useFeaturesSupportedByInternetExplorer5 = VersionCompat(rawValue: 0x0002)
        
        /// 0x0004 Use features supported by Word for Windows 95.
        public static let useFeaturesSupportedByWord95 = VersionCompat(rawValue: 0x0004)
        
        /// 0x0008 Use features supported by Word 97.
        public static let useFeaturesSupportedByWord97 = VersionCompat(rawValue: 0x0008)
        
        /// 0x0010 Use features supported by the Word HTML format.
        public static let useFeaturesSupportedByWordHtml = VersionCompat(rawValue: 0x0010)
        
        /// 0x0020 Use features supported by the Word RTF format.
        public static let useFeaturesSupportedByWordRtf = VersionCompat(rawValue: 0x0020)
        
        /// 0x0040 Use features supported by East Asian versions of Word for Windows 95.
        public static let useFeaturesSupportedByEastAsianWord95 = VersionCompat(rawValue: 0x0040)
        
        /// 0x0080 Use features supported by plain text e-mail messages.
        public static let useFeaturesSupportedByPlainTextEmailMessages = VersionCompat(rawValue: 0x0080)
        
        /// 0x0100 Use features supported by Internet Explorer 6.0.
        public static let useFeaturesSupportedByInternetExplorer6 = VersionCompat(rawValue: 0x0100)
        
        /// 0x0200 Use features supported by the Word XML format.
        public static let useFeaturesSupportedByWordXml = VersionCompat(rawValue: 0x0200)
        
        /// 0x0400 Use features supported by RTF e-mail messages.
        public static let useFeaturesSupportedByRtfEmailMessages = VersionCompat(rawValue: 0x0400)
        
        /// 0x0800 Do not use features introduced in Microsoft Office Word 2007.
        public static let doNotUseFeaturedIntroducedInOffice2007 = VersionCompat(rawValue: 0x0800)
        
        /// 0x1000 Use features supported by plain text.
        public static let useFeaturesSupportedByPlainText = VersionCompat(rawValue: 0x1000)
        
        static let all: VersionCompat = [
            .noRestrictions,
            .useFeaturesSupportedByInternetExplorer4,
            .useFeaturesSupportedByInternetExplorer5,
            .useFeaturesSupportedByWord95,
            .useFeaturesSupportedByWord97,
            .useFeaturesSupportedByWordHtml,
            .useFeaturesSupportedByWordRtf,
            .useFeaturesSupportedByEastAsianWord95,
            .useFeaturesSupportedByPlainTextEmailMessages,
            .useFeaturesSupportedByInternetExplorer6,
            .useFeaturesSupportedByWordXml,
            .useFeaturesSupportedByRtfEmailMessages,
            .doNotUseFeaturedIntroducedInOffice2007,
            .useFeaturesSupportedByPlainText
        ]
    }
}
