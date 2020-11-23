//
//  Prc.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.209 Prc
/// The Prc structure specifies a set of properties for document content that is referenced by a Pcd structure.
public struct Prc {
    public let clxt: UInt8
    public let data: PrcData
    
    public init(dataStream: inout DataStream) throws {
        /// clxt (1 byte): This value MUST be 0x01.
        self.clxt = try dataStream.read(endianess: .littleEndian)
        if self.clxt != 0x01 {
            throw OfficeFileError.corrupted
        }
        
        /// data (variable): A PrcData that specifies a set of properties.
        self.data = try PrcData(dataStream: &dataStream)
    }
}
