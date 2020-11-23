//
//  Dop97.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.7.4 Dop97
/// The Dop97 structure contains document and compatibility settings. These settings influence the appearance and behavior of the current document
/// and store the document-level state.
public struct Dop97 {
    public let dop95: Dop95
    public let adt: DocumentClassification
    public let doptypography: DopTypography
    public let dogrid: Dogrid
    public let unused1: Bool
    public let lvlDop: OutlineLevel
    public let fGramAllDone: Bool
    public let fGramAllClean: Bool
    public let fSubsetFonts: Bool
    public let unused2: Bool
    public let fHtmlDoc: Bool
    public let fDiskLvcInvalid: Bool
    public let fSnapBorder: Bool
    public let fIncludeHeader: Bool
    public let fIncludeFooter: Bool
    public let unused3: Bool
    public let unused4: Bool
    public let unused5: UInt16
    public let asumyi: Asumyi
    public let cChWS: UInt32
    public let cChWSWithSubdocs: UInt32
    public let grfDocEvents: DocumentEvents
    public let fVirusPrompted: Bool
    public let fVirusLoadSafe: Bool
    public let keyVirusSession30: UInt32
    public let space: [UInt8]
    public let cpMaxListCacheMainDoc: UInt32
    public let ilfoLastBulletMain: UInt16
    public let ilfoLastNumberMain: UInt16
    public let cDBC: UInt32
    public let cDBCWithSubdocs: UInt32
    public let reserved3a: UInt32
    public let nfcFtnRef: MSONFC
    public let nfcEdnRef: MSONFC
    public let hpsZoomFontPag: UInt16
    public let dywDispPag: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// dop95 (88 bytes): A Dop95 that specifies document and compatibility settings.
        self.dop95 = try Dop95(dataStream: &dataStream)
        
        /// adt (2 bytes): Specifies the document classification as specified in [ECMA-376] Part 4, Section 2.15.1.29 documentType; the values are
        /// mapped as follows
        let adtRaw: UInt16 = try dataStream.read(endianess: .littleEndian)
        guard let adt = DocumentClassification(rawValue: adtRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.adt = adt
        
        /// doptypography (310 bytes): A DopTypography that specifies typography settings.
        self.doptypography = try DopTypography(dataStream: &dataStream)
        
        /// dogrid (10 bytes): A Dogrid that specifies the draw object grid settings.
        self.dogrid = try Dogrid(dataStream: &dataStream)
        
        var flags1: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - unused1 (1 bit): This bit is undefined and MUST be ignored.
        self.unused1 = flags1.readBit()
        
        /// lvlDop (4 bits): This value SHOULD<174> specify which outline levels were showing in outline view at the time of the last save operation.
        /// This MUST be a value between 0 and 9, inclusive, or this value MUST be 15.
        let lvlDopRaw: UInt8 = UInt8(flags1.readBits(count: 4))
        guard let lvlDop = OutlineLevel(rawValue: lvlDopRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.lvlDop = lvlDop
        
        /// B - fGramAllDone (1 bit): Specifies whether the grammar of all content in this document was checked.
        self.fGramAllDone = flags1.readBit()
        
        /// C - fGramAllClean (1 bit): Specifies whether all content in this document can be considered grammatically correct.
        self.fGramAllClean = flags1.readBit()
        
        /// D - fSubsetFonts (1 bit): Specifies whether to subset fonts when embedding as specified in [ECMA376] Part 4, Section 2.8.2.15
        /// saveSubsetFonts, where embedTrueTypeFonts refers to DopBase.fEmbedFonts.
        self.fSubsetFonts = flags1.readBit()
        
        /// E - unused2 (1 bit): This value is undefined and MUST be ignored.
        self.unused2 = flags1.readBit()
        
        /// F - fHtmlDoc (1 bit): This value SHOULD<175> be 0.
        self.fHtmlDoc = flags1.readBit()
        
        /// G - fDiskLvcInvalid (1 bit): This bit MAY<176> specify whether the saved ListNum field cache contains valid information. The ListNum field
        /// cache is specified by FibRgFcLcb97.fcPlcfBteLvc.
        self.fDiskLvcInvalid = flags1.readBit()
        
        /// H - fSnapBorder (1 bit): Specifies whether to align paragraph and table borders with the page border, as specified in [ECMA-376] Part 4,
        /// Section 2.15.1.2 alignBordersAndEdges.
        self.fSnapBorder = flags1.readBit()
        
        /// I - fIncludeHeader (1 bit): Specifies whether to draw the page border so that it includes the header area.
        self.fIncludeHeader = flags1.readBit()
        
        /// J - fIncludeFooter (1 bit): Specifies whether to draw the page border so that it includes the footer area.
        self.fIncludeFooter = flags1.readBit()
        
        /// K - unused3 (1 bit): This value is undefined and MUST be ignored.
        self.unused3 = flags1.readBit()
        
        /// L - unused4 (1 bit): This value is undefined and MUST be ignored.
        self.unused4 = flags1.readBit()
        
        /// unused5 (2 bytes): This value is undefined and MUST be ignored.
        self.unused5 = try dataStream.read(endianess: .littleEndian)
        
        /// asumyi (12 bytes): An Asumyi that specifies the AutoSummary settings.
        self.asumyi = try Asumyi(dataStream: &dataStream)
        
        /// cChWS (4 bytes): Specifies the last calculated or estimated count of characters in the main document depending on the values of fExactCWords
        /// and fIncludeSubdocsInStats. The count of characters includes whitespace.
        self.cChWS = try dataStream.read(endianess: .littleEndian)
        
        /// cChWSWithSubdocs (4 bytes): Specifies the last calculated or estimated count of characters in the main document, footnotes, endnotes, and
        /// text boxes that are anchored in the main document, depending on fExactCWords and fIncludeSubdocsInStats. The count of characters includes
        /// whitespace.
        self.cChWSWithSubdocs = try dataStream.read(endianess: .littleEndian)
        
        /// grfDocEvents (4 bytes): A bit field that specifies which document events are fired. The individual bits and their meanings are as follows.
        self.grfDocEvents = DocumentEvents(rawValue: try dataStream.read(endianess: .littleEndian))
        
        var flags2: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)

        /// M - fVirusPrompted (1 bit): Specifies whether the macro security prompt is shown in this session for this document.
        self.fVirusPrompted = flags2.readBit()
        
        /// N - fVirusLoadSafe (1 bit): Specifies whether to disable macros for this session.
        self.fVirusLoadSafe = flags2.readBit()
        
        /// KeyVirusSession30 (30 bits): A random value to match against the current session key. If they match, this is the same session.
        self.keyVirusSession30 = flags2.readRemainingBits()
        
        /// space (30 bytes): This value is undefined and MUST be ignored.
        var space: [UInt8] = []
        space.reserveCapacity(30)
        for _ in 0..<30 {
            space.append(try dataStream.read())
        }

        self.space = space
        
        /// cpMaxListCacheMainDoc (4 bytes): This value MAY<177> specify the maximum CP value for which the ListNum field cache contains valid
        /// information. The ListNum field cache is specified by FibRgFcLcb97.fcPlcfBteLvc.
        self.cpMaxListCacheMainDoc = try dataStream.read(endianess: .littleEndian)
        
        /// ilfoLastBulletMain (2 bytes): Specifies the index of the last LFOstructure that was used for bullets in the document before the save operation.
        /// This value MUST be between 0 and a number that is one less than the number of entries in FibRgFcLcb97.fcPlfLfo, unless there are 0 entries, in
        /// which case this value MUST be 0.
        self.ilfoLastBulletMain = try dataStream.read(endianess: .littleEndian)
        
        /// ilfoLastNumberMain (2 bytes): Specifies the index of the last LFO structure that was used for list numbering in the document before the save
        /// operation. This value MUST be between 0 and a number that is one less than the number of entries in FibRgFcLcb97.fcPlfLfo, unless there are 0
        /// entries, in which case this value MUST be 0.
        self.ilfoLastNumberMain = try dataStream.read(endianess: .littleEndian)
        
        /// cDBC (4 bytes): Specifies the last calculated or estimated count of double-byte characters in the main document, depending on the values of
        /// DopBase.fExactCWords and DopBase.fIncludeSubdocsInStats. The count of characters includes whitespace.
        self.cDBC = try dataStream.read(endianess: .littleEndian)
        
        /// cDBCWithSubdocs (4 bytes): Specifies the last calculated or estimated count of double-byte characters in the main document, footnotes,
        /// endnotes, and text boxes anchored in the main document depending on DopBase.fExactCWords and DopBase.fIncludeSubdocsInStats. The
        /// character count includes whitespace.
        self.cDBCWithSubdocs = try dataStream.read(endianess: .littleEndian)
        
        /// reserved3a (4 bytes): This value is undefined and MUST be ignored.
        self.reserved3a = try dataStream.read(endianess: .littleEndian)
        
        /// nfcFtnRef (2 bytes): An MSONFC (as specified in [MS-OSHARED] section 2.2.1.3) that, for those documents that have an nFib which is less
        /// than or equal to 0x00D9, specifies the numbering format code to use for footnotes in the document.
        let nfcFtnRefRaw: UInt16 = try dataStream.read(endianess: .littleEndian)
        guard let nfcFtnRef = MSONFC(rawValue: UInt8(nfcFtnRefRaw)) else {
            throw OfficeFileError.corrupted
        }

        self.nfcFtnRef = nfcFtnRef
        
        /// nfcEdnRef (2 bytes): An MSONFC (as specified in [MS-OSHARED] section 2.2.1.3) that, for those documents that have an nFib which is less
        /// than or equal to 0x00D9, specifies the numbering format code to use for endnotes in the document.
        let nfcEdnRefRaw: UInt16 = try dataStream.read(endianess: .littleEndian)
        guard let nfcEdnRef = MSONFC(rawValue: UInt8(nfcEdnRefRaw)) else {
            throw OfficeFileError.corrupted
        }

        self.nfcEdnRef = nfcEdnRef
        
        /// hpsZoomFontPag (2 bytes): Specifies the size, in half points, of the maximum font size to be enlarged in the view "online layout" at the time
        /// the document was last paginated. This value SHOULD<178> be ignored.
        self.hpsZoomFontPag = try dataStream.read(endianess: .littleEndian)
        
        /// dywDispPag (2 bytes): Height of the screen, in pixels, at the time that the document was last paginated. This value SHOULD<179> be ignored.
        self.dywDispPag = try dataStream.read(endianess: .littleEndian)
    }
    
    /// adt (2 bytes): Specifies the document classification as specified in [ECMA-376] Part 4, Section 2.15.1.29 documentType; the values are mapped
    /// as follows
    public enum DocumentClassification: UInt16 {
        /// 0x0000 notSpecified
        case notSpecified = 0x0000

        /// 0x0001 letter
        case letter = 0x0001
        
        /// 0x0002 eMail
        case eMail = 0x0002
    }
    
    /// lvlDop (4 bits): This value SHOULD<174> specify which outline levels were showing in outline view at the time of the last save operation.
    /// This MUST be a value between 0 and 9, inclusive, or this value MUST be 15.
    public enum OutlineLevel: UInt8{
        /// 0x0 Heading 1
        case heading1 = 0x0
        
        /// 0x1 Headings 1 and 2
        case heading1And2 = 0x1
        
        /// 0x2 Headings 1, 2 and 3
        case heading12And3 = 0x2
        
        /// 0x3 Headings 1, 2, 3 and 4
        case heading123And4 = 0x3
        
        /// 0x4 Headings 1, 2, 3, 4 and 5
        case heading1234And5 = 0x4
        
        /// 0x5 Headings 1, 2, 3, 4, 5 and 6
        case heading12345And6 = 0x5
        
        /// 0x6 Headings 1, 2, 3, 4, 5, 6 and 7
        case heading123456And7 = 0x6
        
        /// 0x7 Headings 1, 2, 3, 4, 5, 6, 7 and 8
        case heading1234567And8 = 0x7
        
        /// 0x8 Headings 1, 2, 3, 4, 5 , 6, 7, 8 and 9
        case heading12345678And9 = 0x8
        
        /// 0x9 All levels
        case allLevel1 = 0x9
        
        /// 0xF All levels
        case allLevels2 = 0xF
    }
    
    /// grfDocEvents (4 bytes): A bit field that specifies which document events are fired. The individual bits and their meanings are as follows.
    /// All other bits MUST be set to 0.
    public struct DocumentEvents: OptionSet {
        public let rawValue: UInt32
        
        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
        
        /// 0x00000001 New
        public static let new = DocumentEvents(rawValue: 0x00000001)
        
        /// 0x00000002 Open
        public static let open = DocumentEvents(rawValue: 0x00000002)

        /// 0x00000004 Close
        public static let close = DocumentEvents(rawValue: 0x00000004)
        
        /// 0x00000008 Sync
        public static let sync = DocumentEvents(rawValue: 0x00000008)
        
        /// 0x00000010 XMLAfterInsert
        public static let xmlAfterInsert = DocumentEvents(rawValue: 0x00000010)
        
        /// 0x00000020 XMLBeforeDelete
        public static let xmlBeforeDelete = DocumentEvents(rawValue: 0x00000020)
        
        /// 0x00000100 BBAfterInsert
        public static let bbAfterInsert = DocumentEvents(rawValue: 0x00000100)
        
        /// 0x00000200 BBBeforeDelete
        public static let bbBeforeDelete = DocumentEvents(rawValue: 0x00000200)
        
        /// 0x00000400 BBOnExit
        public static let bbOnExit = DocumentEvents(rawValue: 0x00000400)
        
        /// 0x00000800 BBOnEnter
        public static let bbOnEnter = DocumentEvents(rawValue: 0x00000800)
        
        /// 0x00001000 StoreUpdate
        public static let storeUpdate = DocumentEvents(rawValue: 0x00001000)
        
        /// 0x00002000 BBContentUpdate
        public static let bbContentUpdate = DocumentEvents(rawValue: 0x00002000)
        
        /// 0x00004000 LegoAfterInsert
        public static let legoAfterInsert = DocumentEvents(rawValue: 0x00004000)

        public static let all: DocumentEvents = [.new, .open, .close, .sync, .xmlAfterInsert, .xmlBeforeDelete, .bbAfterInsert, .bbBeforeDelete, .bbOnExit, .bbOnEnter, .storeUpdate, .bbContentUpdate, .legoAfterInsert]
    }
}
