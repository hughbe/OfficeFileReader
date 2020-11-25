//
//  PROJECTVERSION.swift
//
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.3.4.2.1.10 PROJECTVERSION Record
/// Specifies the version of the VBA project.
public struct PROJECTVERSION {
    public let id: UInt16
    public let reserved: UInt32
    public let versionMajor : UInt32
    public let versionMinor : UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// Id (2 bytes): An unsigned integer that specifies the identifier for this record. MUST be 0x0009.
        self.id = try dataStream.read(endianess: .littleEndian)
        guard self.id == 0x0009 else {
            throw OfficeFileError.corrupted
        }
        
        /// Reserved (4 bytes):  MUST be 0x00000004. MUST be ignored.
        self.reserved = try dataStream.read(endianess: .littleEndian)
        
        /// VersionMajor (4 bytes): An unsigned integer specifying the major version of the VBA project.
        self.versionMajor = try dataStream.read(endianess: .littleEndian)
        
        /// VersionMinor (2 bytes): An unsigned integer specifying the minor version of the VBA project.
        self.versionMinor = try dataStream.read(endianess: .littleEndian)
    }
}
