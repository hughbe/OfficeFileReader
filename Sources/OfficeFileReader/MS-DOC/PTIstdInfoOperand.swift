//
//  PTIstdInfoOperand.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.221 PTIstdInfoOperand
/// The PTIstdInfoOperand structure is the operand for sprmPTIstdInfo, and MUST be ignored.
public struct PTIstdInfoOperand {
    public let cb: UInt8
    public let reserved: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        /// cb (1 byte): An unsigned integer value that specifies the size, in bytes, of this PTIstdInfoOperand, excluding the cb member. This value MUST be 16.
        self.cb = try dataStream.read()
        if self.cb != 16 {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// reserved (16 bytes): This value is undefined and MUST be ignored.
        self.reserved = try dataStream.readBytes(count: 16)

        if dataStream.position - startPosition != self.cb {
            throw OfficeFileError.corrupted
        }
    }
}
