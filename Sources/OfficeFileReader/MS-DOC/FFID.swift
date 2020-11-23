//
//  FFID.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.80 FFID
/// The FFID structure specifies the font family and character pitch for a font.
public struct FFID {
    public let prq: CharacterPitch
    public let fTrueType: Bool
    public let unused1: Bool
    public let ff: FontFamily
    public let unused2: Bool
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt8> = try dataStream.readBits(endianess: .littleEndian)
        
        /// prq (2 bits): A 2-bit field that specifies character pitch. This MUST contain one of the following values.
        let prqRaw = flags.readBits(count: 2)
        guard let prq = CharacterPitch(rawValue: prqRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.prq = prq
        
        /// A - fTrueType (1 bit): A bit that specifies whether the font is a TrueType font.
        self.fTrueType = flags.readBit()
        
        /// B - unused1 (1 bit): This bit is undefined and MUST be ignored.
        self.unused1 = flags.readBit()
        
        /// ff (3 bits): A bit field that specifies the font family type as described in [MSDN-FONTS]. This field MUST contain one of the following values.
        let ffRaw = flags.readBits(count: 3)
        guard let ff = FontFamily(rawValue: ffRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.ff = ff
        
        /// C - unused2 (1 bit): This field MUST be zero and MUST be ignored.
        self.unused2 = flags.readBit()
    }
    
    /// prq (2 bits): A 2-bit field that specifies character pitch. This MUST contain one of the following values.
    public enum CharacterPitch: UInt8 {
        /// 0x00 Default pitch.
        case `default` = 0x00
        
        /// 0x01 Fixed pitch.
        case fixed = 0x01
        
        /// 0x02 Variable pitch.
        case variable = 0x02
    }
    
    /// ff (3 bits): A bit field that specifies the font family type as described in [MSDN-FONTS]. This field MUST contain one of the following values.
    public enum FontFamily: UInt8 {
        /// 0x00 Font family is unspecified for this font.
        case unspecified = 0x00
        
        /// 0x01 Roman (Serif).
        case romanSerif = 0x01
        
        /// 0x02 Swiss (Sans-serif).
        case swissSansSerif = 0x02
        
        /// 0x03 Modern (Monospace).
        case modernMonospace = 0x03
        
        /// 0x04 Script (Cursive).
        case scriptCursive = 0x04
        
        /// 0x05 Decorative (Fantasy).
        case decorativeFantasy = 0x05
    }
}
