//
//  TimeColorDirection.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.40 TimeColorDirection
/// Referenced by: TimeVariant4Behavior
/// An atom record that specifies the interpolation direction of a color animation.
/// Let the corresponding time node be as specified in the TimePropertyList4TimeBehavior record that contains this TimeColorDirection record.
public struct TimeColorDirection {
    public let rh: RecordHeader
    public let type: TimeVariantTypeEnum
    public let colorDirection: ColorDirection
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recType MUST be RT_TimeVariant.
        /// rh.recLen MUST be 0x00000005.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .timeVariant else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000005 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// type (1 byte): A TimeVariantTypeEnum enumeration that specifies the data type of this record. It MUST be TL_TVT_Int.
        guard let type = TimeVariantTypeEnum(rawValue: try dataStream.read()) else {
            throw OfficeFileError.corrupted
        }
        guard type == .int else {
            throw OfficeFileError.corrupted
        }
        
        self.type = type
        
        /// colorDirection (4 bytes): A signed integer that specifies the interpolation direction of the color animation of the corresponding time node.
        /// It MUST be a value from the following table.
        guard let colorDirection = ColorDirection(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.colorDirection = colorDirection
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
    
    /// colorDirection (4 bytes): A signed integer that specifies the interpolation direction of the color animation of the corresponding time node.
    /// It MUST be a value from the following table.
    public enum ColorDirection: Int32 {
        /// 0x00000000 Use clockwise direction for the hue component in HSL color space.
        case clockwiseHueComponent = 0x00000000
        
        /// 0x00000001 Use counterclockwise direction for the hue component in HSL color space.
        case counterclockwiseHueComponent = 0x00000001
    }
}
