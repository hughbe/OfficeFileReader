//
//  RGBColor.swift
//
//
//  Created by Hugh Bellamy on 22/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.59 RGBColor
/// Referenced by: TimeAnimateColor
/// A structure that specifies the values of the red, green, and blue components of a color in the RGB color space.
public struct RGBColor {
    public let model: UInt32
    public let red: UInt32
    public let green: UInt32
    public let blue: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// model (4 bytes): An unsigned integer that specifies this color is defined within the RGB color space. It MUST be 0x00000000.
        self.model = try dataStream.read(endianess: .littleEndian)
        guard self.model == 0x00000000 else {
            throw OfficeFileError.corrupted
        }
        
        /// red (4 bytes): An unsigned integer that specifies the value of the red color component. It MUST be less than or equal to 255.
        self.red = try dataStream.read(endianess: .littleEndian)
        guard self.red <= 255 else {
            throw OfficeFileError.corrupted
        }
        
        /// green (4 bytes): An unsigned integer that specifies the value of the green color component. It MUST be less than or equal to 255.
        self.green = try dataStream.read(endianess: .littleEndian)
        guard self.green <= 255 else {
            throw OfficeFileError.corrupted
        }
        
        /// blue (4 bytes): An unsigned integer that specifies the value of the blue color component. It MUST be less than or equal to 255.
        self.blue = try dataStream.read(endianess: .littleEndian)
        guard self.blue <= 255 else {
            throw OfficeFileError.corrupted
        }
    }
}
