//
//  FieldMapInfo.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.85 FieldMapInfo
/// The FieldMapInfo structure specifies information about how fields from a mail merge data source are mapped to standard mail merge address
/// fields, which are defined for ODSOPropertyBase.OdsoProp when ODSOPropertyBase.id is equal to 0x0016.
public struct FieldMapInfo {
    public let countMarker: UInt16
    public let cbCount: UInt16
    public let cFields: UInt32
    public let fieldMapListSizeMarker: UInt16
    public let cbFieldMapList: UInt16
    public let cbFieldMapListOverflow: UInt32?
    public let fieldMappings: [FieldMapBase]
    
    public init(dataStream: inout DataStream) throws {
        /// countMarker (2 bytes): An unsigned integer that specifies that the count of FieldMappings follows. This value MUST be zero.
        self.countMarker = try dataStream.read(endianess: .littleEndian)
        if self.countMarker != 0 {
            throw OfficeFileError.corrupted
        }
        
        /// cbCount (2 bytes): An unsigned integer that specifies the size, in bytes, of the following mapped field count. This value MUST be 0x0004.
        self.cbCount = try dataStream.read(endianess: .littleEndian)
        if self.cbCount != 0x0004 {
            throw OfficeFileError.corrupted
        }
        
        /// cFields (4 bytes): An unsigned integer that specifies the number of elements in the FieldMappings array. This value MUST be 30.
        self.cFields = try dataStream.read(endianess: .littleEndian)
        if self.cFields != 30 {
            throw OfficeFileError.corrupted
        }
        
        /// FieldMapListSizeMarker (2 bytes): An unsigned integer that specifies that the size of the FieldMappings array that follows. This value
        /// MUST be 0x0001.
        self.fieldMapListSizeMarker = try dataStream.read(endianess: .littleEndian)
        if self.fieldMapListSizeMarker != 0x0001 {
            throw OfficeFileError.corrupted
        }
        
        /// cbFieldMapList (2 bytes): An unsigned integer that specifies the size, in bytes, of the FieldMappings array. If the size is greater than
        /// 0xFFFE, this value MUST be 0xFFFF.
        self.cbFieldMapList = try dataStream.read(endianess: .littleEndian)
        
        /// cbFieldMapListOverflow (4 bytes): An unsigned integer that specifies the size in bytes of the FieldMappings array. This value is only
        /// present if cbFieldMapList is set to 0xFFFF.
        if self.cbFieldMapList == 0xFFFF {
            self.cbFieldMapListOverflow = try dataStream.read(endianess: .littleEndian)
        } else {
            self.cbFieldMapListOverflow = nil
        }
        
        let startPosition = dataStream.position
        
        /// FieldMappings (variable): An array of FieldMapBase. Each FieldMapBase element in this array maps a column in the mail merge
        /// data source to a corresponding standard mail merge address field. There are 30 standard mail merge address fields, which are
        /// defined for ODSOPropertyBase.OdsoProp when ODSOPropertyBase.id is equal to 0x0016.
        var fieldMappings: [FieldMapBase] = []
        fieldMappings.reserveCapacity(Int(self.cFields))
        for _ in 0..<self.cFields {
            fieldMappings.append(try FieldMapBase(dataStream: &dataStream))
        }
        
        self.fieldMappings = fieldMappings
        
        if self.cbFieldMapList != 0xFFFF {
            if dataStream.position - startPosition != self.cbFieldMapList {
                throw OfficeFileError.corrupted
            }
        } else {
            if dataStream.position - startPosition != self.cbFieldMapListOverflow! {
                throw OfficeFileError.corrupted
            }
        }
    }
}
