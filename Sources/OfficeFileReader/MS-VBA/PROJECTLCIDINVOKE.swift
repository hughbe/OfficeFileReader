//
//  PROJECTLCIDINVOKE.swift
//
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.3.4.2.1.3 PROJECTLCIDINVOKE Record
/// Specifies an LCID value used for Invoke calls on an Automation server as specified in [MS-OAUT] section 3.1.4.4.
public struct PROJECTLCIDINVOKE {
    public let id: UInt16
    public let size: UInt32
    public let lcidInvoke: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// Id (2 bytes): An unsigned integer that specifies the identifier for this record. MUST be 0x0014.
        self.id = try dataStream.read(endianess: .littleEndian)
        guard self.id == 0x0014 else {
            throw OfficeFileError.corrupted
        }
        
        /// Size (4 bytes): An unsigned integer that specifies the size of LcidInvoke. MUST be 0x00000004.
        self.size = try dataStream.read(endianess: .littleEndian)
        guard self.size == 0x00000004 else {
            throw OfficeFileError.corrupted
        }
        
        /// LcidInvoke (4 bytes): An unsigned integer that specifies the LCID value used for Invoke calls. MUST be 0x00000409.
        self.lcidInvoke = try dataStream.read(endianess: .littleEndian)
        guard self.lcidInvoke == 0x00000409 else {
            throw OfficeFileError.corrupted
        }
    }
}
