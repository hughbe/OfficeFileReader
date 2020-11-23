//
//  SHDOperand.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.249 SHDOperand
/// The SDHOperand structure is an operand that is used by several Sprm structures to specify the background shading to be applied.
public struct SHDOperand {
    public let cb: UInt8
    public let shd: Shd
    
    public init(dataStream: inout DataStream) throws {
        /// cb (1 byte): An unsigned integer that specifies the size of this operand in bytes, not including cb. This value MUST be 10.
        self.cb = try dataStream.read()
        if self.cb != 10 {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// shd (10 bytes): A Shd structure that specifies the background shading that is applied.
        self.shd = try Shd(dataStream: &dataStream)
        
        if dataStream.position - startPosition != self.cb {
            throw OfficeFileError.corrupted
        }
    }
}
