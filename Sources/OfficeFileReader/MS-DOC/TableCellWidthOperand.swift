//
//  TableCellWidthOperand.swift
//
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.306 TableCellWidthOperand
/// The TableCellWidthOperand structure is an operand that is used by the sprmTCellWidth value to specify the width of one or more table cells.
public struct TableCellWidthOperand {
    public let cb: UInt8
    public let itc: ItcFirstLim
    public let ftsWWidth: FtsWWidth_TablePart
    
    public init(dataStream: inout DataStream) throws {
        /// cb (1 byte): An unsigned integer that specifies the size, in bytes, of the remainder of this structure. This value MUST be 5.
        self.cb = try dataStream.read()
        if self.cb != 5 {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// itc (2 bytes): An ItcFirstLim that specifies the cells to which this TableCellWidthOperand structure applies.
        self.itc = try ItcFirstLim(dataStream: &dataStream)
        
        /// FtsWWidth (3 bytes): An FtsWWidth_TablePart that specifies the width of cells itc.itcFirst through itc.itcLim – 1.
        self.ftsWWidth = try FtsWWidth_TablePart(dataStream: &dataStream)
        
        if dataStream.position - startPosition < self.cb {
            throw OfficeFileError.corrupted
        }
    }
}
