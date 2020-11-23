//
//  Xst.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.353 Xst
/// The Xst structure is a string. The string is prepended by its length and is not null-terminated.
public struct Xst {
    public let cch: UInt16
    public let rgtchar: String
    
    public init(dataStream: inout DataStream) throws {
        /// cch (2 bytes): An unsigned integer that specifies the number of characters that are contained in the rgtchar array.
        self.cch = try dataStream.read(endianess: .littleEndian)
        
        /// rgtchar (variable): An array of 16-bit Unicode characters that make up a string.
        self.rgtchar = try dataStream.readString(count: Int(self.cch) * 2, encoding: .utf16LittleEndian)!
    }
}
