//
//  MODULEPRIVATE.swift
//
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.3.4.2.3.2.10 MODULEPRIVATE Record
/// Specifies that the containing MODULE Record (section 2.3.4.2.3.2) is only usable from within the current VBA project.
public struct MODULEPRIVATE {
    public let id: UInt16
    public let reserved: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// Id (2 bytes): An unsigned integer that specifies the identifier for this record. MUST be 0x0028.
        self.id = try dataStream.read(endianess: .littleEndian)
        guard self.id == 0x0028 else {
            throw OfficeFileError.corrupted
        }
        
        /// Reserved (4 bytes): MUST be 0x00000000. MUST be ignored.
        self.reserved = try dataStream.read(endianess: .littleEndian)
    }
}
