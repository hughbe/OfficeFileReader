//
//  Xstz.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.354 Xstz
/// The Xstz structure is a string. The string is prepended by its length and is null-terminated.
public struct Xstz {
    public let xst: Xst
    public let chTerm: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// xst (variable): An Xst structure that is prepended with a value which specifies the length of the string.
        self.xst = try Xst(dataStream: &dataStream)
        
        /// chTerm (2 bytes): A null-terminating character. This value MUST be zero.
        self.chTerm = try dataStream.read(endianess: .littleEndian)
        if self.chTerm != 0x0000 {
            throw OfficeFileError.corrupted
        }
    }
}
