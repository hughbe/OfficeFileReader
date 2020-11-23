//
//  HSLColorBy.swift
//
//
//  Created by Hugh Bellamy on 22/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.57 HSLColorBy
/// Referenced by: TimeAnimateColorBy
/// A structure that specifies the offset values during an animation of the hue, saturation, and luminance color components in HSL color space. These
/// offset values are added to the starting value for each color component at specified time intervals until the animation is complete.
public struct HSLColorBy {
    public let model: UInt32
    public let hue: Int32
    public let saturation: Int32
    public let luminance: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// model (4 bytes): An unsigned integer that specifies this color is defined within the HSL color space. It MUST be 0x00000001.
        self.model = try dataStream.read(endianess: .littleEndian)
        guard self.model == 0x00000001 else {
            throw OfficeFileError.corrupted
        }
        
        /// hue (4 bytes): A signed integer that specifies the offset value of the hue color component. It MUST be greater than or equal to -255
        /// and less than or equal to 255.
        let hue: Int32 = try dataStream.read(endianess: .littleEndian)
        guard hue >= -255 && hue <= -255 else {
            throw OfficeFileError.corrupted
        }
        
        self.hue = hue
        
        /// saturation (4 bytes): A signed integer that specifies the offset value of the saturation color component. It MUST be greater than or equal
        /// to -255 and less than or equal to 255.
        let saturation: Int32 = try dataStream.read(endianess: .littleEndian)
        guard saturation >= -255 && saturation <= -255 else {
            throw OfficeFileError.corrupted
        }
        
        self.saturation = saturation
        
        /// luminance (4 bytes): A signed integer that specifies the offset value of the luminance color component. It MUST be greater than or equal
        /// to -255 and less than or equal to 255.
        let luminance: Int32 = try dataStream.read(endianess: .littleEndian)
        guard luminance >= -255 && luminance <= -255 else {
            throw OfficeFileError.corrupted
        }
        
        self.luminance = luminance
    }
}
