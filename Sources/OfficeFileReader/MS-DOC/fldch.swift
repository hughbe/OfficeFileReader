//
//  fldch.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.89 fldch
/// The fldch structure determines the type of the field character.
public struct fldch {
    public let ch: UInt8
    public let reserved: UInt8
    
    public init(dataStream: inout DataStream) throws {
        let rawValue: UInt8 = try dataStream.read()

        /// ch (5 bits): An unsigned integer whose value MUST be either 0x13, 0x14, or 0x15. This value controls the interpretation of the grffld
        /// member of the containing Fld.
        let ch = rawValue & 0b11111
        if ch != 0x13 && ch != 0x14 && ch != 0x15 {
            throw OfficeFileError.corrupted
        }
        
        self.ch = ch
        
        /// A - reserved (3 bits): Three reserved bits, which an application MUST ignore.
        self.reserved = (rawValue >> 5) & 0b111
    }
}
