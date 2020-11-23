//
//  TimeModifierAtom.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.77 TimeModifierAtom
/// Referenced by: ExtTimeNodeContainer, SubEffectContainer
/// An atom record that specifies the type of data to be modified and the new data value.
public struct TimeModifierAtom {
    public let rh: RecordHeader
    public let type: DataType
    public let value: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recType MUST be RT_TimeModifier.
        /// rh.recLen MUST be 0x00000008.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .timeModifier else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000008 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// type (4 bytes): An unsigned integer that specifies the type of data to be modified. It MUST be a value from the following table.
        guard let type = DataType(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.type = type
        
        /// value (4 bytes): An unsigned integer that specifies the new value.
        self.value = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }

    /// type (4 bytes): An unsigned integer that specifies the type of data to be modified. It MUST be a value from the following table.
    public enum DataType: UInt32 {
        /// 0x00000000 Repeat count.
        case repeatCount = 0x00000000
        
        /// 0x00000001 Repeat duration.
        case repeatDuration = 0x00000001
        
        /// 0x00000002 Speed.
        case speed = 0x00000002
        
        /// 0x00000003 Accelerate.
        case accelerate = 0x00000003
        
        /// 0x00000004 Decelerate.
        case decelerate = 0x00000004
        
        /// 0x00000005 Automatic reverse.
        case automaticReverse = 0x00000005
    }
}
