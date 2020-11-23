//
//  VertMergeOperand.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.343 VertMergeOperand
/// The VertMergeOperand structure is an operand that specifies the merge behavior of a cell in a table row with the equivalent cells in the rows
/// immediately above or below it.
public struct VertMergeOperand {
    public let cb: UInt8
    public let itc: UInt8
    public let vertMergeFlags: VerticalMergeFlag
    
    public init(dataStream: inout DataStream) throws {
        /// cb (1 byte): An integer value that specifies the byte count of the remainder of this structure. This value MUST be 2.
        self.cb = try dataStream.read()
        
        /// itc (1 byte): An integer that specifies the index of a cell in the table row. The first cell has an index of zero. All cells in the row are
        /// counted, even if they are vertically merged with cells above or below them. This value MUST be a valid index of a cell in the table row.
        self.itc = try dataStream.read()
        
        /// vertMergeFlags (1 byte): A value from the VerticalMergeFlag enumeration that specifies whether this cell is vertically merged with the
        /// cells above or below it.
        let vertMergeFlagsRaw: UInt8 = try dataStream.read()
        guard let vertMergeFlags = VerticalMergeFlag(rawValue: vertMergeFlagsRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.vertMergeFlags = vertMergeFlags
    }
}
