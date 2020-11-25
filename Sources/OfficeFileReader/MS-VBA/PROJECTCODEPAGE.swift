//
//  PROJECTCODEPAGE.swift
//
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.3.4.2.1.4 PROJECTCODEPAGE Record
/// Specifies the VBA project’s code page.
public struct PROJECTCODEPAGE {
    public let id: UInt16
    public let size: UInt32
    public let codePage : UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// Id (2 bytes): An unsigned integer that specifies the identifier for this record. MUST be 0x0003.
        self.id = try dataStream.read(endianess: .littleEndian)
        guard self.id == 0x0003 else {
            throw OfficeFileError.corrupted
        }
        
        /// Size (4 bytes): An unsigned integer that specifies the size of CodePage. MUST be 0x00000002.
        self.size = try dataStream.read(endianess: .littleEndian)
        guard self.size == 0x00000002 else {
            throw OfficeFileError.corrupted
        }
        
        /// CodePage (2 bytes): An unsigned integer that specifies the code page for the VBA project.
        self.codePage = try dataStream.read(endianess: .littleEndian)
    }
}
