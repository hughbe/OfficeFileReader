//
//  TimeEffectType.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.24 TimeEffectType
/// Referenced by: TimeVariant4TimeNode
/// An atom record that specifies the type of animation effect.
/// Let the corresponding time node be as specified in the TimePropertyList4TimeNodeContainer record (section 2.8.18) that contains this
/// TimeEffectType record.
public struct TimeEffectType {
    public let rh: RecordHeader
    public let type: TimeVariantTypeEnum
    public let effectType: EffectType
    
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
        
        /// effectType (4 bytes): A signed integer that specifies the type of animation effect of the corresponding time node. It MUST be a value from the
        /// following table.
        guard let effectType = EffectType(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.effectType = effectType
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
    
    /// effectType (4 bytes): A signed integer that specifies the type of animation effect of the corresponding time node. It MUST be a value from the
    /// following table.
    public enum EffectType: Int32 {
        /// 0x00000001 Entrance.
        case entrance = 0x00000001

        /// 0x00000002 Exit.
        case exit = 0x00000002
        
        /// 0x00000003 Emphasis.
        case emphasis = 0x00000003
        
        /// 0x00000004 Motion path.
        case motionPath = 0x00000004
        
        /// 0x00000005 Action verb.
        case actionVerb = 0x00000005
        
        /// 0x00000006 Media command.
        case mediaCommand = 0x00000006
    }
}
