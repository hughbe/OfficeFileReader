//
//  ColorStruct.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.12.1 ColorStruct
/// Referenced by: SchemeListElementColorSchemeAtom, SlideSchemeColorSchemeAtom
/// A structure that specifies a color in the sRGB color space as specified in [IEC-RGB].
public struct ColorStruct {
    public let red: UInt8
    public let green: UInt8
    public let blue: UInt8
    public let unused: UInt8
    
    public init(dataStream: inout DataStream) throws {
        /// red (1 byte): An unsigned integer that specifies the red component of this color.
        self.red = try dataStream.read()
        
        /// green (1 byte): An unsigned integer that specifies the green component of this color.
        self.green = try dataStream.read()
        
        /// blue (1 byte): An unsigned integer that specifies the blue component of this color.
        self.blue = try dataStream.read()
        
        /// unused (1 byte): Undefined and MUST be ignored.
        self.unused = try dataStream.read()
    }
}
