//
//  TimeDisplayType.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.20 TimeDisplayType
/// Referenced by: TimeVariant4TimeNode
/// An atom record that specifies whether a time node is visible in the user interface.
/// Let the corresponding time node be as specified in the TimePropertyList4TimeNodeContainer record (section 2.8.18) that contains this
/// TimeDisplayType record.
public struct TimeDisplayType {
    public let rh: RecordHeader
    public let type: TimeVariantTypeEnum
    public let displayType: DisplayType
    
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
        
        /// displayType (4 bytes): A signed integer that specifies whether the corresponding time node is displayed in the user interface. It MUST be a
        /// value from the following table:
        guard let displayType = DisplayType(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.displayType = displayType
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
    
    /// displayType (4 bytes): A signed integer that specifies whether the corresponding time node is displayed in the user interface. It MUST be a
    /// value from the following table:
    public enum DisplayType: Int32 {
        /// 0x00000000 The corresponding time node is visible.
        case visible = 0x00000000

        /// 0x00000001 The corresponding time node is hidden.
        case hidden = 0x00000001
    }
}
