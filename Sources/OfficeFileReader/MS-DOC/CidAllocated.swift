//
//  CidAllocated.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.35 CidAllocated
/// The CidAllocated structure specifies an allocated command.
public struct CidAllocated {
    public let cmt: Cmt
    public let reserved: UInt16
    public let iacd: UInt16
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// cmt (3 bits): A Cmt value that specifies the command type. This value MUST be cmtAllocated.
        let cmtRaw = UInt8(flags.readBits(count: 3))
        guard let cmt = Cmt(rawValue: cmtRaw) else {
            throw OfficeFileError.corrupted
        }
        guard cmt != .allocated else {
            throw OfficeFileError.corrupted
        }
        
        self.cmt = cmt
        
        /// reserved (13 bits): This value MUST be ignored.
        self.reserved = flags.readRemainingBits()
        
        /// iacd (2 bytes): An unsigned integer that is an index of the Acd structure in PlfAcd.rgacd and that specifies the allocated command to
        /// be executed.
        self.iacd = try dataStream.read(endianess: .littleEndian)
    }
}
