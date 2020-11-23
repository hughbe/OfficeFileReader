//
//  CellRangeNoWrap.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.28 CellRangeNoWrap
/// The CellRangeNoWrap structure is an operand that is used by sprmTFCellNoWrap. This operand specifies a set of cells in a table row and the
/// preferred line wrapping layout of each.
public struct CellRangeNoWrap {
    public let cb: UInt8
    public let itc: ItcFirstLim
    public let bArg: Bool8
    
    public init(dataStream: inout DataStream) throws {
        /// cb (1 byte): An unsigned integer that specifies the size in bytes of the remainder of this structure. MUST be 3.
        self.cb = try dataStream.read()
        if self.cb != 3 {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// itc (2 bytes): A ItcFirstLim structure that specifies a cell range to which fNoWrap applies.
        self.itc = try ItcFirstLim(dataStream: &dataStream)
        
        /// fNoWrap (1 byte): A Bool8. When set, the preferred layout of the contents of each cell is a single line. This preference is ignored when
        /// the preferred width of the cell is set to ftsDxa.
        self.bArg = try dataStream.read()
        
        if dataStream.position - startPosition != self.cb {
            throw OfficeFileError.corrupted
        }
    }
}
