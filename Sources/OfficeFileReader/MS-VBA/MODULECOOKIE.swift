//
//  MODULECOOKIE.swift
//
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.3.4.2.3.2.7 MODULECOOKIE Record
/// Specifies ignored data.
public struct MODULECOOKIE {
    public let id: UInt16
    public let size: UInt32
    public let cookie: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// Id (2 bytes): An unsigned integer that specifies the identifier for this record. MUST be 0x002C.
        self.id = try dataStream.read(endianess: .littleEndian)
        guard self.id == 0x002C else {
            throw OfficeFileError.corrupted
        }
        
        /// Size (4 bytes): An unsigned integer that specifies the size of Cookie. MUST be 0x00000002.
        self.size = try dataStream.read(endianess: .littleEndian)
        guard self.size == 0x00000002 else {
            throw OfficeFileError.corrupted
        }
        
        /// Cookie (2 bytes): MUST be ignored on read. MUST be 0xFFFF on write.
        self.cookie = try dataStream.read(endianess: .littleEndian)
    }
}
