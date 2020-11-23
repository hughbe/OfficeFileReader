//
//  BrcOperand.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.21 BrcOperand
/// The BrcOperand structure is the operand to several SPRMs that control borders.
public struct BrcOperand {
    public let cb: UInt8
    public let brc: Brc
    
    public init(dataStream: inout DataStream) throws {
        /// cb (1 byte): An unsigned integer value that specifies the size of this BrcOperand, not including this byte. The cb MUST be 8.
        self.cb = try dataStream.read()
        if self.cb != 8 {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// brc (8 bytes): A BRC that specifies the border to be applied.
        self.brc = try Brc(dataStream: &dataStream)
        
        if dataStream.position - startPosition != self.cb {
            throw OfficeFileError.corrupted
        }
    }
}
