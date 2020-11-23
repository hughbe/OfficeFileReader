//
//  TimeOverride.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.41 TimeOverride
/// Referenced by: TimeVariant4Behavior
/// An atom record that specifies how an animation behavior overrides the values of the properties being animated on an object.
/// Let the corresponding time node be as specified in the TimePropertyList4TimeBehavior record that contains this TimeOverride record.
public struct TimeOverride {
    public let rh: RecordHeader
    public let type: TimeVariantTypeEnum
    public let override: UInt32
    
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
        
        /// override (4 bytes): A TimeVariantInt record that specifies how to override the values of the properties of the target object being animated
        /// by the animation behavior of the corresponding time node. It MUST be 0x00000001 that specifies the animated properties of the
        /// sub-elements contained inside the target object are cleared and inherited from the target object before the
        self.override = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
