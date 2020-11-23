//
//  EndElementMarkerEntry.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.2.5.2 EndElementMarkerEntry
/// Referenced by: DocSigSerializedCertStore, VBASigSerializedCertStore
/// Specifies a special entry in a serialized digital certificate store that marks the end of the store.
public struct EndElementMarkerEntry {
    public let id: UInt32
    public let marker: UInt64
    
    public init(dataStream: inout DataStream) throws {
        /// id (4 bytes): An unsigned integer. MUST be 0x00000000.
        self.id = try dataStream.read(endianess: .littleEndian)
        if self.id != 0x00000000 {
            throw OfficeFileError.corrupted
        }
        
        /// marker (8 bytes): A sentinel value 8 bytes in length, the value of which MUST be 0x0000000000000000.
        self.marker = try dataStream.read(endianess: .littleEndian)
        if self.marker != 0x0000000000000000 {
            throw OfficeFileError.corrupted
        }
    }
}
