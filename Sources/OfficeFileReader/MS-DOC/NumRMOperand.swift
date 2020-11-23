//
//  NumRMOperand.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.160 NumRMOperand
/// The NumRMOperand structure is the operand for the sprmPNumRM value that contains information about a numbering revision mark.
public struct NumRMOperand {
    public let cb: UInt8
    public let numRM: NumRM
    
    public init(dataStream: inout DataStream) throws {
        /// cb (1 byte): An unsigned integer that specifies the size, in bytes, of the NumRM structure. This value MUST be 128.
        self.cb = try dataStream.read()
        if self.cb != 128 {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// numRM (128 bytes): A NumRM that specifies the properties of the numbering revision mark.
        self.numRM = try NumRM(dataStream: &dataStream)
        
        if dataStream.position - startPosition != self.cb {
            throw OfficeFileError.corrupted
        }
    }
}
