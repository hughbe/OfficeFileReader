//
//  RGBColorBy.swift
//  
//
//  Created by Hugh Bellamy on 22/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.56 RGBColorBy
/// Referenced by: TimeAnimateColorBy
/// A structure that specifies the offset values during an animation of the red, green, and blue color components in RGB color space. These offset
/// values are added to the starting value for each color component at specified time intervals until the animation is complete.
public struct RGBColorBy {
    public let model: UInt32
    public let red: Int32
    public let green: Int32
    public let blue: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// model (4 bytes): An unsigned integer that specifies this color is defined within the RGB color space. It MUST be 0x00000000.
        self.model = try dataStream.read(endianess: .littleEndian)
        guard self.model == 0x00000000 else {
            throw OfficeFileError.corrupted
        }
        
        /// red (4 bytes): A signed integer that specifies the offset value of the red color component. It MUST be greater than or equal to -255 and
        /// less than or equal to 255.
        let red: Int32 = try dataStream.read(endianess: .littleEndian)
        guard red >= -255 && red <= 255 else {
            throw OfficeFileError.corrupted
        }
        
        self.red = red
        
        /// green (4 bytes): A signed integer that specifies the offset value of the green color component. It MUST be greater than or equal to -255
        /// and less than or equal to 255.
        let green: Int32 = try dataStream.read(endianess: .littleEndian)
        guard green >= -255 && green <= 255 else {
            throw OfficeFileError.corrupted
        }
        
        self.green = green
        
        /// blue (4 bytes): A signed integer that specifies the offset value of the blue color component. It MUST be greater than or equal to -255 and
        /// less than or equal to 255.
        let blue: Int32 = try dataStream.read(endianess: .littleEndian)
        guard blue >= -255 && blue <= 255 else {
            throw OfficeFileError.corrupted
        }
        
        self.blue = blue
    }
}
