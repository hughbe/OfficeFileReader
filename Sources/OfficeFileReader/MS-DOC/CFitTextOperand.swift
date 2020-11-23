//
//  CFitTextOperand.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.31 CFitTextOperand
/// The CFitTextOperand structure is an operand that is used by sprmCFitText to specify how text runs are formatted to fit a particular width.
public struct CFitTextOperand {
    public let cb: UInt8
    public let dxaFitText: Int32
    public let fitTextID: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// cb (1 byte): The number of bytes that this operand occupies. This value MUST be 0x08.
        self.cb = try dataStream.read()
        if self.cb != 0x08 {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// dxaFitText (4 bytes): A 32-bit signed integer value that specifies, in twips, the size of the space in which to fit the text. Text that would
        /// occupy a smaller width than specified has space added between characters. Text that would occupy a greater width than specified is
        /// compressed proportionally. A value of zero specifies that the Sprm is ignored. A value representing a width that is too large for the text
        /// run is also ignored. A negative value or a value representing a width that is too small for the text run specifies the minimum width.
        self.dxaFitText = try dataStream.read(endianess: .littleEndian)
        
        /// FitTextID (4 bytes): A 32-bit signed integer that uniquely identifies a fit text region across multiple character runs and instances of
        /// sprmCFitText. Contiguous character runs that share a common FitTextID are part of the same fit text region. If the runs are not contiguous,
        /// the FitTextID is ignored and they are not linked.
        self.fitTextID = try dataStream.read(endianess: .littleEndian)
        
        if dataStream.position - startPosition != startPosition {
            throw OfficeFileError.corrupted
        }
    }
}
