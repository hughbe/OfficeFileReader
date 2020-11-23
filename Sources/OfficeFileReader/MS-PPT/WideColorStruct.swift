//
//  WideColorStruct.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.12.3WideColorStruct
/// Referenced by: RecolorEntry, RecolorEntryBrush, RecolorEntryColor, RecolorInfoAtom
/// A structure that specifies a color in the sRGB color space as specified in [IEC-RGB].
public struct WideColorStruct {
    public let red: UInt16
    public let green: UInt16
    public let blue: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// red (2 bytes): An unsigned integer that specifies the red component of this color.
        self.red = try dataStream.read(endianess: .littleEndian)
        
        /// green (2 bytes): An unsigned integer that specifies the green component of this color.
        self.green = try dataStream.read(endianess: .littleEndian)
        
        /// blue (2 bytes): An unsigned integer that specifies the blue component of this color.
        self.blue = try dataStream.read(endianess: .littleEndian)
    }
}
