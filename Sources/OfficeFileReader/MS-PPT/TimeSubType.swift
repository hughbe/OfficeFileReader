//
//  TimeSubType.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.22 TimeSubType
/// Referenced by: TimeVariant4TimeNode
/// An atom record that specifies the type of subordinate time node.
/// Let the corresponding subordinate time node be specified by the SubEffectContainer record (section 2.8.16) that contains this TimeSubType record.
/// Let the corresponding master time node be specified by the ExtTimeNodeContainer record (section 2.8.15) that contains the corresponding
/// subordinate time node.
public struct TimeSubType {
    public let rh: RecordHeader
    public let type: TimeVariantTypeEnum
    public let subType: Int32
    
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
        
        /// subType (4 bytes): A signed integer that specifies the type of the corresponding subordinate time node. It MUST be 0x00000001, specifying
        /// that the corresponding subordinate time node position is relative to the corresponding master time node.
        self.subType = try dataStream.read(endianess: .littleEndian)
        guard self.subType == 0x00000001 else {
            throw OfficeFileError.corrupted
        }
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
