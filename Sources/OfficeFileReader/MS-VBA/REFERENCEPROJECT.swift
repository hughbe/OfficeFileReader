//
//  REFERENCEPROJECT.swift
//
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.3.4.2.2.6 REFERENCEPROJECT Record
/// Specifies a reference to an external VBA project
public struct REFERENCEPROJECT {
    public let id: UInt16
    public let size: UInt32
    public let sizeOfLibidAbsolute: UInt32
    public let libidAbsolute: String
    public let sizeOfLibidRelative: UInt32
    public let libidRelative: String
    public let majorVersion: UInt32
    public let minorVersion: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// Id (2 bytes): An unsigned integer that specifies the identifier for this record. MUST be 0x000E.
        self.id = try dataStream.read(endianess: .littleEndian)
        guard self.id == 0x000E else {
            throw OfficeFileError.corrupted
        }
        
        /// Size (4 bytes): An unsigned integer that specifies the total size in bytes of SizeOfLibidAbsolute, LibidAbsolute, SizeOfLibidRelative.
        /// LibidRelative, MajorVersion, and MinorVersion. MUST be ignored on read.
        self.size = try dataStream.read(endianess: .littleEndian)
        
        /// SizeOfLibidAbsolute (4 bytes): An unsigned integer that specifies the size in bytes of LibidAbsolute.
        self.sizeOfLibidAbsolute = try dataStream.read(endianess: .littleEndian)
        
        /// LibidAbsolute (variable): An array of SizeOfLibidAbsolute bytes that specifies the referenced VBA project’s identifier with an absolute path,
        /// <ProjectPath>. MUST contain MBCS characters encoded using the code page specified in PROJECTCODEPAGE (section 2.3.4.2.1.4).
        /// MUST NOT contain null characters. MUST conform to the ABNF grammar ProjectReference (section 2.1.1.12).
        self.libidAbsolute = try dataStream.readString(count: Int(self.sizeOfLibidAbsolute), encoding: .ascii)!
        
        /// SizeOfLibidRelative (4 bytes): An unsigned integer that specifies the size in bytes of LibidRelative.
        self.sizeOfLibidRelative = try dataStream.read(endianess: .littleEndian)
        
        /// LibidRelative (variable): An array of SizeOfLibidRelative bytes that specifies the referenced VBA project’s identifier with a relative path,
        /// <ProjectPath>, that is relative to the current VBA project. MUST contain MBCS characters encoded using the code page specified in
        /// PROJECTCODEPAGE (section 2.3.4.2.1.4). MUST NOT contain null characters. MUST conform to the ABNF grammar ProjectReference
        /// (section 2.1.1.12).
        self.libidRelative = try dataStream.readString(count: Int(self.sizeOfLibidRelative), encoding: .ascii)!
        
        /// MajorVersion (4 bytes): An unsigned integer that specifies the major version of the referenced VBA project. On write MUST be the
        /// PROJECTVERSION.VersionMajor (section 2.3.4.2.1.10) of the referenced VBA project.
        self.majorVersion = try dataStream.read(endianess: .littleEndian)
        
        /// MinorVersion (2 bytes): An unsigned integer that specifies the minor version of the external VBA project. On write MUST be the
        /// PROJECTVERSION.VersionMinor (section 2.3.4.2.1.10) of the referenced VBA project.
        self.minorVersion = try dataStream.read(endianess: .littleEndian)
    }
}
