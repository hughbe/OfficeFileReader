//
//  DefTableShdOperand.swift
//
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.53 DefTableShdOperand
/// The DefTableShdOperand structure is an operand that is used by several Table Sprms to specify each style of background shading that is applied
/// to each of the cells in a single row.
public struct DefTableShdOperand {
    public let cb: UInt8
    public let rgShd: [Shd]
    
    public init(dataStream: inout DataStream) throws {
        /// cb (1 byte): An unsigned integer that specifies the size in bytes of this operand, not including cb. The cb value MUST be a multiple of
        /// 10, the size of Shd, and MUST NOT exceed 220.
        let cb: UInt8 = try dataStream.read()
        if (cb % 10) != 0 || cb > 220 {
            throw OfficeFileError.corrupted
        }
        
        self.cb = cb
        
        /// rgShd (variable): An array of Shd. The number of elements is equal to cb / 10 and MUST NOT exceed 22. Each Shd structure is applied
        /// sequentially to each cell in the row. The first cell rgShd applies to is either 1, 23, or 45, depending on which Table Sprm is applying this
        /// operand. rgShd only contains elements necessary to define all shaded cells in the row. Non-shaded cells that follow the last shaded cell
        /// in the row are omitted from the array. Non-shaded cells that precede the last shaded cell in the row are set to ShdAuto or ShdNil,
        /// depending on which Table Sprm is applying this operand.
        let startPosition = dataStream.position
        let count = cb / 10
        var rgShd: [Shd] = []
        rgShd.reserveCapacity(Int(count))
        for _ in 0..<count {
            rgShd.append(try Shd(dataStream: &dataStream))
        }
        
        self.rgShd = rgShd
        
        if dataStream.position - startPosition != self.cb {
            throw OfficeFileError.corrupted
        }
    }
}
