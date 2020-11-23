//
//  CSSAOperand.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.46 CSSAOperand
/// The CSSAOperand structure is an operand that is used by several Table SPRMs to specify a table cell margin or cell spacing.
public struct CSSAOperand {
    public let cb: UInt8
    public let cssa: CSSA
    
    public init(dataStream: inout DataStream) throws {
        /// cb (1 byte): An unsigned integer value that specifies the size of this operand in bytes, not including cb. The cb MUST be 6.
        self.cb = try dataStream.read()
        if self.cb != 6 {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// cssa (6 bytes): A CSSA that specifies the cell margin or cell spacing to apply.
        self.cssa = try CSSA(dataStream: &dataStream)
        
        if dataStream.position - startPosition != self.cb {
            throw OfficeFileError.corrupted
        }
    }
}
