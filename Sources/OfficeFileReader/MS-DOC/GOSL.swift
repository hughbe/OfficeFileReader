//
//  GOSL.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.108 GOSL
/// The GOSL structure specifies the option set for a grammar checker implementing the CGAPI interface, as well as information to identify the
/// corresponding grammar checker.
public struct GOSL {
    public let gos: UInt16
    public let lid: LID
    public let ver: UInt16
    public let geid: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// gos (2 bytes): An unsigned integer that specifies a CGAPI option set. gos is implementation-specific to the grammar checker identified
        /// by lid, ver, and ceid. By default, the value is 0x0001.
        self.gos = try dataStream.read(endianess: .littleEndian)
        
        /// lid (2 bytes): A LID that specifies the language of the associated grammar checker.
        self.lid = try dataStream.read(endianess: .littleEndian)
        
        /// ver (2 bytes): An unsigned integer that is the version number of the associated grammar checker, as it is specified through CGAPI.
        self.ver = try dataStream.read(endianess: .littleEndian)
        
        /// geid (2 bytes): An unsigned integer that is the company identifier of the associated grammar checker, as it is specified through CGAPI.
        self.geid = try dataStream.read(endianess: .littleEndian)
    }
}
