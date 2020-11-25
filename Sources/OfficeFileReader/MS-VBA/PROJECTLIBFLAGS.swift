//
//  PROJECTLIBFLAGS.swift
//
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.3.4.2.1.9 PROJECTLIBFLAGS Record
/// Specifies the LIBFLAGS for the VBA project’s Automation type library as specified in [MS-OAUT] section 2.2.20.
public struct PROJECTLIBFLAGS {
    public let id: UInt16
    public let size: UInt32
    public let projectLibFlags : UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// Id (2 bytes): An unsigned integer that specifies the identifier for this record. MUST be 0x0008.
        self.id = try dataStream.read(endianess: .littleEndian)
        guard self.id == 0x0008 else {
            throw OfficeFileError.corrupted
        }
        
        /// Size (4 bytes): An unsigned integer that specifies the size of ProjectLibFlags. MUST be 0x00000004.
        self.size = try dataStream.read(endianess: .littleEndian)
        guard self.size == 0x00000004 else {
            throw OfficeFileError.corrupted
        }
        
        /// ProjectLibFlags (4 bytes): An unsigned integer that specifies LIBFLAGS for the VBA project’s Automation type library as specified
        /// in [MS-OAUT] section 2.2.20. MUST be 0x00000000.
        self.projectLibFlags = try dataStream.read(endianess: .littleEndian)
        guard self.projectLibFlags == 0x00000000 else {
            throw OfficeFileError.corrupted
        }
    }
}
