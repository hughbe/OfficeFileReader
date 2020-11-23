//
//  FieldMapDataItem.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.84 FieldMapDataItem
/// The FieldMapDataItem structure contains information about a mail merge field mapping. All FieldMapDataItems that apply to a particular field
/// mapping are grouped together. When a FieldMapTerminator is encountered, there is no further data about this field mapping, and any subsequent
/// FieldMapDataItem structures are associated with subsequent field mappings.
public struct FieldMapDataItem {
    public let fieldMapDataId: UInt16
    public let cbFieldMapData: UInt16
    public let data: Data
    
    public init(dataStream: inout DataStream) throws {
        /// FieldMapDataId (2 bytes): An unsigned integer that specifies the type of this FieldMapDataItem. This value MUST be 0x0001,
        /// 0x0002, 0x0003, or 0x0004.
        let fieldMapDataId: UInt16 = try dataStream.read(endianess: .littleEndian)
        if fieldMapDataId != 0x0001 &&
            fieldMapDataId != 0x0002 &&
            fieldMapDataId != 0x0003 &&
            fieldMapDataId != 0x0004 {
            throw OfficeFileError.corrupted
        }
        
        self.fieldMapDataId = fieldMapDataId
        
        /// cbFieldMapData (2 bytes): An unsigned integer that specifies the size, in bytes, of the following Data element.
        self.cbFieldMapData = try dataStream.read(endianess: .littleEndian)
        
        let startPosition = dataStream.position
        
        /// Data (variable): Contains the actual data for this FieldMapDataItem. The meaning of the data depends on the preceding
        /// FieldMapDataId and is specified as follows.
        /// FieldMapDataId Data
        /// 0x0001 An unsigned integer that specifies the mail merge field is being mapped to a data source column. This value
        /// MUST be 0x00000001.
        /// 0x0002 A Unicode string that specifies the name of the data source column to which this merge field is being mapped.
        /// The string is not null-terminated.
        /// 0x0003 A Unicode string that specifies the name of the standard mail merge field to which the data source column is
        /// being mapped. The string is not null-terminated. This string MUST be ignored.
        /// 0x0004 An unsigned integer that specifies the zero-based index of the data source column to which this merge field is
        /// being mapped. If the value is 0xFFFFFFFF, this FieldMapDataItem MUST be ignored.
        if fieldMapDataId == 0x0001 {
            let data: UInt32 = try dataStream.read(endianess: .littleEndian)
            if data != 0x00000001 {
                throw OfficeFileError.corrupted
            }

            self.data = .mailMergeFieldIsBeingMappedToDataSourceColumn(data: data)
        } else if fieldMapDataId == 0x0002 {
            let data = try dataStream.readString(count: Int(self.cbFieldMapData), encoding: .utf16LittleEndian)!
            self.data = .nameOfDataSourceColumnBeingMapped(data: data)
        } else if fieldMapDataId == 0x0003 {
            let data = try dataStream.readString(count: Int(self.cbFieldMapData), encoding: .utf16LittleEndian)!
            self.data = .nameOfStandardMailMergeFieldDataSourceColumnIsBeingMapped(data: data)
        } else if fieldMapDataId == 0x0004 {
            let data: UInt32 = try dataStream.read(endianess: .littleEndian)
            self.data = .dataSourceColumnIndex(data: data)
        } else {
            throw OfficeFileError.corrupted
        }
        
        if dataStream.position - startPosition != self.cbFieldMapData {
            throw OfficeFileError.corrupted
        }
    }
    
    /// Data (variable): Contains the actual data for this FieldMapDataItem. The meaning of the data depends on the preceding
    /// FieldMapDataId and is specified as follows.
    public enum Data {
        /// 0x0001 An unsigned integer that specifies the mail merge field is being mapped to a data source column. This value
        /// MUST be 0x00000001.
        case mailMergeFieldIsBeingMappedToDataSourceColumn(data: UInt32)

        /// 0x0002 A Unicode string that specifies the name of the data source column to which this merge field is being mapped.
        /// The string is not null-terminated.
        case nameOfDataSourceColumnBeingMapped(data: String)
        
        /// 0x0003 A Unicode string that specifies the name of the standard mail merge field to which the data source column is
        /// being mapped. The string is not null-terminated. This string MUST be ignored.
        case nameOfStandardMailMergeFieldDataSourceColumnIsBeingMapped(data: String)
        
        /// 0x0004 An unsigned integer that specifies the zero-based index of the data source column to which this merge field is
        /// being mapped. If the value is 0xFFFFFFFF, this FieldMapDataItem MUST be ignored.
        case dataSourceColumnIndex(data: UInt32)
    }
}
