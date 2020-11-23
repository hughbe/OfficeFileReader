//
//  RGBQuad.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.1.3 RGBQuad
/// Referenced by: TBCBitmap
/// Specifies the pixel color values in a TBCBitmap (section 2.3.1.1)
public struct RGBQuad {
    public let blue: UInt8
    public let green: UInt8
    public let red: UInt8
    public let reserved: UInt8
    
    public init(dataStream: inout DataStream) throws {
        /// blue (1 byte): An unsigned integer that specifies the relative intensity of blue.
        self.blue = try dataStream.read()
        
        /// green (1 byte): An unsigned integer that specifies the relative intensity of green.
        self.green = try dataStream.read()
        
        /// red (1 byte): An unsigned integer that specifies the relative intensity of red.
        self.red = try dataStream.read()
        
        /// reserved (1 byte): Undefined and MUST be ignored.
        self.reserved = try dataStream.read()
    }
}
