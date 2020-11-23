//
//  PropertySetSystemIdentifier.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.3.1.1 PropertySetSystemIdentifier
/// Specifies an operating system type and version for a property set.
public struct PropertySetSystemIdentifier {
    public let osMajorVersion: UInt8
    public let osMinorVersion: UInt8
    public let osType: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// OSMajorVersion (1 byte): An unsigned integer specifying the major version number of the operating system that wrote the property set.
        self.osMajorVersion = try dataStream.read()
        
        /// OSMinorVersion (1 byte): An unsigned integer specifying the minor version number of the operating system that wrote the property set.
        self.osMinorVersion = try dataStream.read()
        
        /// OSType (2 bytes): An unsigned integer that MUST be 0x0002.
        self.osType = try dataStream.read(endianess: .littleEndian)
        if self.osType != 0x0002 {
            throw OfficeFileError.corrupted
        }
    }
}
