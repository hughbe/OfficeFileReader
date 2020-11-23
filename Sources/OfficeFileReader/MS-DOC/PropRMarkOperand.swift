//
//  PropRMarkOperand.swift
//
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.218 PropRMarkOperand
/// The PropRMarkOperand structure is the operand to several Sprm structures that specify the properties of property revision marks.
public struct PropRMarkOperand {
    public let cb: UInt8
    public let proprmark: PropRMark
    
    public init(dataStream: inout DataStream) throws {
        /// cb (1 byte): An unsigned 8-bit integer that specifies the size, in bytes, of this SPPOperand structure, excluding the cb member.
        self.cb = try dataStream.read()
        
        let startPosition = dataStream.position
        
        /// proprmark (7 bytes): A PropRMark structure that holds the properties of the property revision mark that is being specified. 
        self.proprmark = try PropRMark(dataStream: &dataStream)
        
        if dataStream.position - startPosition != self.cb {
            throw OfficeFileError.corrupted
        }
    }
}
