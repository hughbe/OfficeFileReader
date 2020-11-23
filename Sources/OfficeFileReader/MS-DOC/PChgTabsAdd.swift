//
//  PChgTabsAdd.swift
//
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.179 PChgTabsAdd
/// The PChgTabsAdd structure specifies the locations and properties of custom tab stops.
public struct PChgTabsAdd {
    public let cTabs: UInt8
    public let rgdxaAdd: [XAS]
    public let rgtbdAdd: [TBD]
    
    public init(dataStream: inout DataStream) throws {
        /// cTabs (1 byte): An unsigned integer that specifies the number of records in rgdxaAdd and rgtbdAdd. This value MUST be less than or equal to 64.
        self.cTabs = try dataStream.read()
        if self.cTabs > 64 {
            throw OfficeFileError.corrupted
        }
        
        /// rgdxaAdd (variable): An array of XAS integer values. The number of records is specified by cTabs. The values in this array MUST be in ascending
        /// order. Each XAS value specifies a location at which to add a custom tab stop.
        var rgdxaAdd: [XAS] = []
        rgdxaAdd.reserveCapacity(Int(self.cTabs))
        for _ in 0..<self.cTabs {
            rgdxaAdd.append(try XAS(dataStream: &dataStream))
        }
        
        self.rgdxaAdd = rgdxaAdd
        
        /// rgtbdAdd (variable): An array of TBD structures. The number of records is specified by cTabs. Each TBD specifies the alignment and leader
        /// attributes of the custom tab stop at the location that is specified at the corresponding index in rgdxaAdd.
        var rgtbdAdd: [TBD] = []
        rgtbdAdd.reserveCapacity(Int(self.cTabs))
        for _ in 0..<self.cTabs {
            rgtbdAdd.append(try TBD(dataStream: &dataStream))
        }
        
        self.rgtbdAdd = rgtbdAdd
    }
}
