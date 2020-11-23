//
//  Afd.swift
//
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9 Basic Types
/// [MS-DOC] 2.9.2 Afd
/// The AFD structure is an array of indices into the author list that specifies whose revisions and comments were being hidden when this
/// document was last saved.
public struct Afd {
    public let iMac: Int32
    public let authorArray: [UInt16]
    
    public init(dataStream: inout DataStream) throws {
        /// iMac (4 bytes): A signed integer that specifies the number of elements in AuthorArray. This value MUST be a non-negative number.
        self.iMac = try dataStream.read(endianess: .littleEndian)
        if self.iMac < 0 {
            throw OfficeFileError.corrupted
        }
        
        /// AuthorArray (variable): An array of 16-bit integers that specifies the indexes in SttbfRMark of authors whose revisions and comments
        /// were being hidden from view when this document was last saved.
        var authorArray: [UInt16] = []
        authorArray.reserveCapacity(Int(self.iMac))
        for _ in 0..<self.iMac {
            authorArray.append(try dataStream.read(endianess: .littleEndian))
        }
        
        self.authorArray = authorArray
    }
}
