//
//  DefTableShd80Operand.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.52 DefTableShd80Operand
/// The DefTableSdh800Operand structure is an operand that is used by several Table Sprms to specify each style of background shading that is
/// applied to each of the cells in a single row.
public struct DefTableShd80Operand {
    public let cb: UInt8
    public let rgShd80: [Shd80]
    
    public init(dataStream: inout DataStream) throws {
        /// cb (1 byte): An unsigned integer that specifies the size in bytes of this operand, not including cb. cb MUST be a multiple of 2
        /// (the size of Shd80).
        self.cb = try dataStream.read()
        if (self.cb % 2) != 0 {
            throw OfficeFileError.corrupted
        }
        
        /// rgShd80 (variable): An array of Shd80. The number of elements is equal to cb divided by 2 and MUST NOT exceed the number of cells
        /// in the row. Each Shd80 structure is applied sequentially to each cell in the row, beginning with the first cell.
        let startPosition = dataStream.position
        let count = cb / 2
        var rgShd80: [Shd80] = []
        rgShd80.reserveCapacity(Int(count))
        for _ in 0..<count {
            rgShd80.append(try Shd80(dataStream: &dataStream))
        }
        
        self.rgShd80 = rgShd80
        
        if dataStream.position - startPosition != self.cb {
            throw OfficeFileError.corrupted
        }
    }
}
