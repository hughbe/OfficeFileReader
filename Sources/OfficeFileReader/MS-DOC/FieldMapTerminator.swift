//
//  FieldMapTerminator.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.86 FieldMapTerminator
/// The FieldMapTerminator structure marks the end of the FieldMapDataItem structures that apply to an element of the FieldMap field of a FieldMapBase.
public struct FieldMapTerminator {
    public let fieldMapDataId: UInt16
    public let cbFieldMapData: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// FieldMapDataId (2 bytes): An unsigned integer that specifies there is no further data to read for the current FieldMap. This value
        /// MUST be zero.
        self.fieldMapDataId = try dataStream.read(endianess: .littleEndian)
        if self.fieldMapDataId != 0 {
            throw OfficeFileError.corrupted
        }
        
        /// CbFieldMapData (2 bytes): This value MUST be zero.
        self.cbFieldMapData = try dataStream.read(endianess: .littleEndian)
        if self.cbFieldMapData != 0 {
            throw OfficeFileError.corrupted
        }
    }
}
