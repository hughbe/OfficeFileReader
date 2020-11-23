//
//  ColorIndexStruct.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.12.2 ColorIndexStruct
/// Referenced by: AnimationInfoAtom, SlideShowDocInfoAtom, TextCFException, TextPFException
/// A structure that specifies an index in the color scheme, or a color in the sRGB color space as specified in [IEC-RGB]. Color schemes are specified
/// by the SlideSchemeColorSchemeAtom record.
public struct ColorIndexStruct {
    public let red: UInt8
    public let green: UInt8
    public let blue: UInt8
    public let index: Index
    
    public init(dataStream: inout DataStream) throws {
        /// red (1 byte): An unsigned integer that specifies the red component of this color.
        self.red = try dataStream.read()
        
        /// green (1 byte): An unsigned integer that specifies the green component of this color.
        self.green = try dataStream.read()
        
        /// blue (1 byte): An unsigned integer that specifies the blue component of this color.
        self.blue = try dataStream.read()
        
        /// index (1 byte): An unsigned integer that specifies the index in the color scheme. It MUST be a value from the following table.
        let indexRaw: UInt8 = try dataStream.read()
        guard let index = Index(rawValue: indexRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.index = index
    }
    
    /// index (1 byte): An unsigned integer that specifies the index in the color scheme. It MUST be a value from the following table.
    public enum Index: UInt8 {
        /// 0x00 Background color
        case backgroundColor = 0x00
        
        /// 0x01 Text color
        case textColor = 0x01
        
        /// 0x02 Shadow color
        case shadowColor = 0x02
        
        /// 0x03 Title text color
        case titleTextColor = 0x03
        
        /// 0x04 Fill color
        case fillColor = 0x04
        
        /// 0x05 Accent 1 color
        case accent1Color = 0x05
        
        /// 0x06 Accent 2 color
        case accent2Color = 0x06
        
        /// 0x07 Accent 3 color
        case accent3Color = 0x07
        
        /// 0xFE Color is an sRGB value specified by red, green, and blue fields.
        case srgbColor = 0xFE
        
        /// 0xFF Color is undefined.
        case undefinedColor = 0xFF
    }
}
