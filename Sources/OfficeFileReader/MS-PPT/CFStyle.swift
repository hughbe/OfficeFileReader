//
//  CFStyle.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.16 CFStyle
/// Referenced by: TextCFException
/// A structure that specifies character-level text formatting.
public struct CFStyle {
    public let bold: Bool
    public let italic: Bool
    public let underline: Bool
    public let unused1: Bool
    public let shadow: Bool
    public let fehint: Bool
    public let unused2: Bool
    public let kumi: Bool
    public let unused3: Bool
    public let emboss: Bool
    public let pp9rt: UInt8
    public let unused4: UInt8
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - bold (1 bit): A bit that specifies whether the characters are bold.
        self.bold = flags.readBit()
        
        /// B - italic (1 bit): A bit that specifies whether the characters are italicized.
        self.italic = flags.readBit()
        
        /// C - underline (1 bit): A bit that specifies whether the characters are underlined.
        self.underline = flags.readBit()
        
        /// D - unused1 (1 bit): Undefined and MUST be ignored.
        self.unused1 = flags.readBit()
        
        /// E - shadow (1 bit): A bit that specifies whether the characters have a shadow effect.
        self.shadow = flags.readBit()
        
        /// F - fehint (1 bit): A bit that specifies whether characters originated from double-byte input.
        self.fehint = flags.readBit()
        
        /// G - unused2 (1 bit): Undefined and MUST be ignored.
        self.unused2 = flags.readBit()
        
        /// H - kumi (1 bit): A bit that specifies whether Kumimoji are used for vertical text.
        self.kumi = flags.readBit()
        
        /// I - unused3 (1 bit): Undefined and MUST be ignored.
        self.unused3 = flags.readBit()
        
        /// J - emboss (1 bit): A bit that specifies whether the characters are embossed.
        self.emboss = flags.readBit()
        
        /// pp9rt (4 bits): An unsigned integer that specifies the run grouping of additional text properties in StyleTextProp9Atom record.
        self.pp9rt = UInt8(flags.readBits(count: 4))
        
        /// K - unused4 (2 bits): Undefined and MUST be ignored.
        self.unused4 = UInt8(flags.readRemainingBits())
    }
}
