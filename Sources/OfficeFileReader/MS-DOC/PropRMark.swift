//
//  PropRMark.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.217 PropRMark
/// The PropRMark structure specifies information about a property revision mark
public struct PropRMark {
    public let fPropRMark: UInt8
    public let ibstshort: Int16
    public let dttm: DTTM
    
    public init(dataStream: inout DataStream) throws {
        /// fPropRMark (1 byte): An unsigned integer that specifies if there is a property revision. This value is 1 if there is a property revision; otherwise,
        /// if there is no property revision, this value is 0.
        self.fPropRMark = try dataStream.read()
        
        /// ibstshort (2 bytes): A signed integer value that specifies the index into the SttbfRMark string table at which the name of the author of the revision
        /// is specified.
        self.ibstshort = try dataStream.read(endianess: .littleEndian)
        
        /// dttm (4 bytes): A DTTM structure that specifies the date and time at which the property revision was made.
        self.dttm = try DTTM(dataStream: &dataStream)
    }
}
