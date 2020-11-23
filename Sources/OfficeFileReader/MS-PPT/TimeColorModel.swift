//
//  TimeColorModel.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.39 TimeColorModel
/// Referenced by: TimeVariant4Behavior
/// An atom record that specifies the color model used by a color animation.
/// Let the corresponding time node be as specified in the TimePropertyList4TimeBehavior record that contains this TimeColorModel record.
public struct TimeColorModel {
    public let rh: RecordHeader
    public let type: TimeVariantTypeEnum
    public let colorModel: ColorModel
    
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
        
        /// colorModel (4 bytes): A signed integer that specifies the color model used by the color animation of the corresponding time node. It MUST
        /// be a value from the following table.
        guard let colorModel = ColorModel(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.colorModel = colorModel
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
    
    /// colorModel (4 bytes): A signed integer that specifies the color model used by the color animation of the corresponding time node. It MUST
    /// be a value from the following table.
    public enum ColorModel: Int32 {
        /// 0x00000000 Use red, green, and blue color components in redgreen-blue (RGB) color space.
        case rgb = 0x00000000
        
        /// 0x00000001 Use hue, saturation, and luminance color components in HSL color space.
        case hsl = 0x00000001
        
        /// 0x00000002 Use index to color scheme.
        case index = 0x00000002
    }
}
