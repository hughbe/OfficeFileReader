//
//  _VBA_PROJECT.swift
//  
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.3.4.1 _VBA_PROJECT Stream: Version Dependent Project Information
/// The _VBA_PROJECT stream contains the version-dependent description of a VBA project.
/// The first seven bytes of the stream are version-independent and therefore can be read by any version.
public struct _VBA_PROJECT {
    public let reserved1: UInt16
    public let version: UInt16
    public let reserved2: UInt8
    public let reserved3: UInt16
    public let performanceCache: [UInt8]
    
    public init(dataStream: inout DataStream, count: Int) throws {
        guard count >= 7 else {
            throw OfficeFileError.corrupted
        }
        
        /// Reserved1 (2 bytes): MUST be 0x61CC. MUST be ignored.
        self.reserved1 = try dataStream.read(endianess: .littleEndian)
        
        /// Version (2 bytes): An unsigned integer that specifies the version of VBA used to create the VBA project. MUST be ignored on read. MUST
        /// be 0xFFFF on write.
        self.version = try dataStream.read(endianess: .littleEndian)
        
        /// Reserved2 (1 byte): MUST be 0x00. MUST be ignored.
        self.reserved2 = try dataStream.read()
        
        /// Reserved3 (2 bytes): Undefined. MUST be ignored.
        self.reserved3 = try dataStream.read(endianess: .littleEndian)
        
        /// PerformanceCache (variable): An array of bytes that forms an implementation-specific and version-dependent performance cache for the
        /// VBA project. The length of PerformanceCache MUST be seven bytes less than the size of _VBA_PROJECT Stream (section 2.3.4.1). MUST
        /// be ignored on read. MUST NOT be present on write.
        self.performanceCache = try dataStream.readBytes(count: count - 7)
    }
}
