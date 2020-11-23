//
//  TableSel.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.307 TableSel
/// The TableSel structure is used by Selsf to specify the range of cells in a table cell block selection. Selsf.fTable MUST be 1. If Selsf.fBlock is zero, the selection
/// is one or more table rows; otherwise, the selection is a range of cells. If Selsf.fBlock is 1 and the selection includes rows with differing cell counts, the
/// TableSel is interpreted based on the first row in the selection.
public struct TableSel {
    public let itcFirst: Int16
    public let itcLim: Int16
    
    public init(dataStream: inout DataStream) throws {
        /// itcFirst (2 bytes): An integer that specifies the first cell that is included in the selection. Cell indices are zero-based. itcFirst MUST be at least zero,
        /// SHOULD NOT<253> exceed the number of cells in the row, and MUST NOT exceed 63. If itcFirst is greater than or equal to the number of cells in
        /// the row, the selection begins at the end of row mark. If Selsf.fBlock is zero, itcFirst MUST be zero.
        self.itcFirst = try dataStream.read(endianess: .littleEndian)
        if self.itcFirst < 0 {
            throw OfficeFileError.corrupted
        }
        
        /// itcLim (2 bytes): An integer that specifies the cell at which the selection ends, exclusive. Cell indices are zero-based. If the selection includes the
        /// last cell in the row, the itcLim value is the number of cells in the row. If the selection includes the end of row mark, itcLim is equal to the number of
        /// cells in the row incremented by 1. The itcLim value SHOULD<254> be greater than the itcFirst value and MUST NOT exceed 64. If Selsf.fBlock is
        /// zero, then itcLim MUST be 64. If the itcLim value is 64, the entire Selsf MAY<255> be ignored.
        self.itcLim = try dataStream.read(endianess: .littleEndian)
    }
}
