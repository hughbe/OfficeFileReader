//
//  SPPOperand.swift
//
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.257 SPPOperand
/// The SPPOperand structure specifies a potential change in the current style as specified by an istd value. A given istd is affected only if it is within the
/// istdFirst and istdLast bounds (inclusive). If the istd is affected, the new istd is rgIstdPermute[istd – istdFirst].
public struct SPPOperand {
    public let cb: UInt8
    public let fLong: UInt8
    public let istdFirst: UInt16
    public let istdLast: UInt16
    public let rgIstdPermute: [UInt16]
    
    public init(dataStream: inout DataStream) throws {
        /// cb (1 byte): An unsigned 8-bit integer that specifies the size, in bytes, of this SPPOperand structure, excluding the cb member.
        self.cb = try dataStream.read()
        
        let startPosition = dataStream.position
        
        /// fLong (1 byte): This value MUST be 0 and MUST be ignored.
        self.fLong = try dataStream.read()
        
        /// istdFirst (2 bytes): An unsigned 16-bit integer that specifies the first istd to which this change applies.
        self.istdFirst = try dataStream.read(endianess: .littleEndian)
        
        /// istdLast (2 bytes): An unsigned 16-bit integer that specifies the last istd to which this change applies. This value MUST be greater than or equal
        /// to istdFirst.
        self.istdLast = try dataStream.read(endianess: .littleEndian)
        if self.istdLast < self.istdFirst {
            throw OfficeFileError.corrupted
        }
        
        /// rgIstdPermute (variable): An array of unsigned 16-bit integers that specifies an array of remapped istd values. The count of elements MUST be
        /// equal to istdLast – istdFirst + 1.
        var rgIstdPermute: [UInt16] = []
        let count = self.istdLast - istdFirst + 1
        rgIstdPermute.reserveCapacity(Int(count))
        for _ in 0..<count {
            rgIstdPermute.append(try dataStream.read(endianess: .littleEndian))
        }
        
        self.rgIstdPermute = rgIstdPermute
        
        if dataStream.position - startPosition != self.cb {
            throw OfficeFileError.corrupted
        }
    }
}
