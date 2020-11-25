//
//  REFERENCEREGISTERED.swift
//
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.3.4.2.2.5 REFERENCEREGISTERED Record
/// Specifies a reference to an Automation type library.
public struct REFERENCEREGISTERED {
    public let id: UInt16
    public let size: UInt32
    public let sizeOfLibid: UInt32
    public let libid: String
    public let reserved1: UInt32
    public let reserved2: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// Id (2 bytes): An unsigned integer that specifies the identifier for this record. MUST be 0x000D.
        self.id = try dataStream.read(endianess: .littleEndian)
        guard self.id == 0x000D else {
            throw OfficeFileError.corrupted
        }
        
        /// Size (4 bytes): An unsigned integer that specifies the total size in bytes of SizeOfLibid, Libid, Reserved1, and Reserved2. MUST be
        /// ignored on read.
        self.size = try dataStream.read(endianess: .littleEndian)
        
        /// SizeOfLibid (4 bytes): An unsigned integer that specifies the size in bytes of Libid.
        self.sizeOfLibid = try dataStream.read(endianess: .littleEndian)
        
        /// Libid (variable): An array of SizeOfLibid bytes that specifies an Automation type library’s identifier. MUST contain MBCS characters
        /// encoded using the code page specified in PROJECTCODEPAGE (section 2.3.4.2.1.4). MUST NOT contain null characters. MUST conform
        /// to the ABNF grammar in LibidReference (section 2.1.1.8).
        self.libid = try dataStream.readString(count: Int(self.sizeOfLibid), encoding: .ascii)!
        
        /// Reserved1 (4 bytes): MUST be 0x00000000. MUST be ignored.
        self.reserved1 = try dataStream.read(endianess: .littleEndian)
        
        /// Reserved2 (2 bytes): MUST be 0x0000. MUST be ignored.
        self.reserved2 = try dataStream.read(endianess: .littleEndian)
    }
}
