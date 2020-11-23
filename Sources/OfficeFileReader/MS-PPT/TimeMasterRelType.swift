//
//  TimeMasterRelType.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.21 TimeMasterRelType
/// Referenced by: TimeVariant4TimeNode
/// An atom record that specifies how a subordinate time node plays back relative to its master time node.
/// Let the corresponding subordinate time node be specified by the SubEffectContainer record (section 2.8.16) that contains this TimeMasterRelType
/// record.
/// Let the corresponding master time node be specified by the ExtTimeNodeContainer record (section 2.8.15) that contains the corresponding
/// subordinate time node.
public struct TimeMasterRelType {
    public let rh: RecordHeader
    public let type: TimeVariantTypeEnum
    public let masterRel: MasterRel
    
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
        
        /// masterRel (4 bytes): A signed integer that specifies how the corresponding subordinate time node plays back relative to the corresponding
        /// master time node. It MUST be a value from the following table.
        guard let masterRel = MasterRel(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.masterRel = masterRel
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
    
    /// masterRel (4 bytes): A signed integer that specifies how the corresponding subordinate time node plays back relative to the corresponding
    /// master time node. It MUST be a value from the following table.
    public enum MasterRel: Int32 {
        /// 0x00000000 Do not start the corresponding subordinate time node.
        case doNotStartCorrespondingSubordinateTimeNode = 0x00000000
        
        /// 0x00000002 Start the corresponding subordinate time node when the corresponding master time node starts.
        case startCorrespondingSubordinateTimeNodeWhenCorrespondingMasterTimeNodeStarts = 0x00000002
    }
}
