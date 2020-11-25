//
//  PROJECTSYSKIND.swift
//  
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.3.4.2.1.1 PROJECTSYSKIND Record
/// Specifies the platform for which the VBA project is created.
public struct PROJECTSYSKIND {
    public let id: UInt16
    public let size: UInt32
    public let sysKind: SysKind
    
    public init(dataStream: inout DataStream) throws {
        /// Id (2 bytes): An unsigned integer that specifies the identifier for this record. MUST be 0x0001.
        self.id = try dataStream.read(endianess: .littleEndian)
        guard self.id == 0x0001 else {
            throw OfficeFileError.corrupted
        }
        
        /// Size (4 bytes): An unsigned integer that specifies the size of SysKind. MUST be 0x00000004.
        self.size = try dataStream.read(endianess: .littleEndian)
        guard self.size == 0x00000004 else {
            throw OfficeFileError.corrupted
        }
        
        /// SysKind (4 bytes): An unsigned integer that specifies the platform for which the VBA project is created. MUST have one of the following
        /// values:
        guard let sysKind = SysKind(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }

        self.sysKind = sysKind
    }
    
    /// SysKind (4 bytes): An unsigned integer that specifies the platform for which the VBA project is created. MUST have one of the following values:
    public enum SysKind: UInt32 {
        /// 0x00000000 For 16-bit Windows Platforms.
        case win16 = 0x00000000
        
        /// 0x00000001 For 32-bit Windows Platforms.
        case win32 = 0x00000001
        
        /// 0x00000002 For Macintosh Platforms.
        case mac = 0x00000002
        
        /// 0x00000003 For 64-bit Windows Platforms.
        case win64 = 0x00000003
    }
}
