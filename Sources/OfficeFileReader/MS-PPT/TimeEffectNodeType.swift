//
//  TimeEffectNodeType.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.28 TimeEffectNodeType
/// Referenced by: TimeVariant4TimeNode
/// An atom record that specifies the role of a time node in the timing structure.
/// Let the corresponding time node be as specified in the TimePropertyList4TimeNodeContainer record (section 2.8.18) that contains this
/// TimeEffectNodeType record.
public struct TimeEffectNodeType {
    public let rh: RecordHeader
    public let type: TimeVariantTypeEnum
    public let effectNodeType: EffectNodeType
    
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
        
        /// effectNodeType (4 bytes): A signed integer that specifies the role of the corresponding time node. It MUST be a value from the following table.
        guard let effectNodeType = EffectNodeType(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.effectNodeType = effectNodeType
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
    
    /// effectNodeType (4 bytes): A signed integer that specifies the role of the corresponding time node. It MUST be a value from the following table.
    public enum EffectNodeType: Int32 {
        /// 0x00000001 Click effect node.
        case clickEffect = 0x00000001
        
        /// 0x00000002 With previous node.
        case withPrevious = 0x00000002
        
        /// 0x00000003 After previous node.
        case afterPrevious = 0x00000003
        
        /// 0x00000004 Main sequence node.
        case mainSequence = 0x00000004
        
        /// 0x00000005 Interactive sequence node.
        case interactiveSequence = 0x00000005
        
        /// 0x00000006 Click parallel node.
        case clickParallel = 0x00000006
        
        /// 0x00000007 With group node.
        case withGroup = 0x00000007
        
        /// 0x00000008 After group node.
        case afterGroup = 0x00000008
        
        /// 0x00000009 Timing root node.
        case timingRoot = 0x00000009
        
    }
}
