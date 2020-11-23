//
//  CAPI.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.24 CAPI
/// The CAPI structure contains information about a caption.
public struct CAPI {
    public let iLocation: Location
    public let fChapNum: Bool
    public let iHeading: HeadingStyle
    public let unused1: UInt8
    public let fNoLabel: Bool
    public let nfc: MSONFC
    public let xchSeparator: Separator
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)

        /// A - iLocation (2 bits): An unsigned integer that specifies the insert location for the caption. This MUST be one of the following values.
        let iLocationRaw = UInt8(flags.readBits(count: 2))
        guard let iLocation = Location(rawValue: iLocationRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.iLocation = iLocation
        
        /// B - fChapNum (1 bit): A bit that specifies whether or not to include a chapter number in the caption.
        self.fChapNum = flags.readBit()
        
        /// C - iHeading (4 bits): An unsigned integer that specifies which heading style marks the beginning of a new chapter for the purpose of
        /// chapter numbering in this caption. This value MUST be one of the following.
        /// If fChapNum is zero, this field MUST be ignored.
        let iHeadingRaw = UInt8(flags.readBits(count: 5))
        guard let iHeading = HeadingStyle(rawValue: iHeadingRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.iHeading = iHeading
        
        /// unused1 (8 bits): This field is undefined and MUST be ignored.
        self.unused1 = UInt8(flags.readBits(count: 8))
        
        /// D - fNoLabel (1 bit): A bit that specifies whether or not to include the label in the caption. This bit MAY<206> be ignored.
        self.fNoLabel = flags.readBit()
        
        /// nfc (2 bytes): An MSONFC, as specified in [MS-OSHARED] section 2.2.1.3, that specifies the formatting of the caption number.
        let nfcRaw: UInt16 = try dataStream.read(endianess: .littleEndian)
        guard let nfc = MSONFC(rawValue: UInt8(nfcRaw)) else {
            throw OfficeFileError.corrupted
        }
        
        self.nfc = nfc
        
        /// xchSeparator (2 bytes): A Unicode character that specifies the character that separates the chapter number and caption number of
        /// the caption. This value MUST be one of the following.
        /// If fChapNum is zero, this value MUST be ignored.
        let xchSeparatorRaw: UInt16 = try dataStream.read(endianess: .littleEndian)
        guard let xchSeparator = Separator(rawValue: xchSeparatorRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.xchSeparator = xchSeparator
    }
    
    /// A - iLocation (2 bits): An unsigned integer that specifies the insert location for the caption. This MUST be one of the following values.
    public enum Location: UInt8 {
        /// 0x0 Insert the caption below the selected item.
        case belowSelectedItem = 0x0
        
        /// 0x1 Insert the caption above the selected item.
        case aboveSelectedItem = 0x1
    }
    
    /// C - iHeading (4 bits): An unsigned integer that specifies which heading style marks the beginning of a new chapter for the purpose of
    /// chapter numbering in this caption. This value MUST be one of the following.
    /// If fChapNum is zero, this field MUST be ignored.
    public enum HeadingStyle: UInt8 {
        case ignored = 0
        
        /// 0x1 Heading 1 marks the beginning of a new chapter.
        case heading1 = 0x1
        
        /// 0x2 Heading 2 marks the beginning of a new chapter.
        case heading2 = 0x2
        
        /// 0x3 Heading 3 marks the beginning of a new chapter.
        case heading3 = 0x3
        
        /// 0x4 Heading 4 marks the beginning of a new chapter.
        case heading4 = 0x4
        
        /// 0x5 Heading 5 marks the beginning of a new chapter.
        case heading5 = 0x5
        
        /// 0x6 Heading 6 marks the beginning of a new chapter.
        case heading6 = 0x6
        
        /// 0x7 Heading 7 marks the beginning of a new chapter.
        case heading7 = 0x7
        
        /// 0x8 Heading 8 marks the beginning of a new chapter.
        case heading8 = 0x8
        
        /// 0x9 Heading 9 marks the beginning of a new chapter.
        case heading9 = 0x9
    }
    
    /// xchSeparator (2 bytes): A Unicode character that specifies the character that separates the chapter number and caption number of the caption.
    /// This value MUST be one of the following.
    /// If fChapNum is zero, this value MUST be ignored.
    public enum Separator: UInt16 {
        case ignored = 0x0000
        
        /// 0x001E A hyphen (-) separates the chapter number and caption number.
        case hyphen = 0x001E
        
        /// 0x002E A period (.) separates the chapter number and the caption number.
        case period = 0x002E
        
        /// 0x003A A colon (:) separates the chapter number and the caption number.
        case colon = 0x003A
        
        /// 0x2013 An en-dash (–) separates the chapter number and the caption number.
        case enDash = 0x2013
        
        /// 0x2014 An em-dash (—) separates the chapter number and the caption number.
        case emDash = 0x2014
    }
}
