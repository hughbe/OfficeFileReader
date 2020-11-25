//
//  PROJECTLCID.swift
//
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.3.4.2.1.2 PROJECTLCID Record
/// Specifies the VBA project’s LCID.
public struct PROJECTLCID {
    public let id: UInt16
    public let size: UInt32
    public let lcid: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// Id (2 bytes): An unsigned integer that specifies the identifier for this record. MUST be 0x0002.
        self.id = try dataStream.read(endianess: .littleEndian)
        guard self.id == 0x0002 else {
            throw OfficeFileError.corrupted
        }
        
        /// Size (4 bytes): An unsigned integer that specifies the size of Lcid. MUST be 0x00000004.
        self.size = try dataStream.read(endianess: .littleEndian)
        guard self.size == 0x00000004 else {
            throw OfficeFileError.corrupted
        }
        
        /// Lcid (4 bytes): An unsigned integer that specifies the LCID value for the VBA project. MUST be 0x00000409.
        self.lcid = try dataStream.read(endianess: .littleEndian)
        guard self.lcid == 0x00000409 else {
            throw OfficeFileError.corrupted
        }
    }
}
