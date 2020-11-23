//
//  FieldMapBase.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.83 FieldMapBase
/// The FieldMapBase structure contains a FieldMap which is followed by a marker that specifies where the FieldMap ends (FieldMapLast).
/// A FieldMapBase MUST correspond with one of 30 standard mail merge address fields, which are defined for ODSOPropertyBase.OdsoProp
/// when ODSOPropertyBase.id is equal to 0x0016.
public struct FieldMapBase {
    public let fieldMap: [FieldMapDataItem]
    public let fieldMapLast: FieldMapTerminator
    
    public init(dataStream: inout DataStream) throws {
        /// FieldMap (variable): An array of FieldMapDataItem. Data that specifies the mapping between one of 30 standard mail merge address
        /// fields and a column in the data source.
        var fieldMap: [FieldMapDataItem] = []
        while try dataStream.peek(endianess: .littleEndian) as UInt32 != 0x0000 {
            fieldMap.append(try FieldMapDataItem(dataStream: &dataStream))
        }
        
        self.fieldMap = fieldMap
        
        /// FieldMapLast (4 bytes): Contains a FieldMapTerminator that specifies that there is no further data to read for the current FieldMap.
        self.fieldMapLast = try FieldMapTerminator(dataStream: &dataStream)
    }
}
