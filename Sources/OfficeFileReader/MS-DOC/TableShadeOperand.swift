//
//  TableShadeOperand.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.308 TableShadeOperand
/// The TableShadeOperand structure specifies a range of cells in a table row and the background shading to apply to those cells.
public struct TableShadeOperand {
    public let cb: UInt8
    public let itc: ItcFirstLim
    public let sh: Shd
    
    public init(dataStream: inout DataStream) throws {
        /// cb (1 byte): Specifies the byte count of the remainder of this structure. The value MUST be 12.
        self.cb = try dataStream.read()
        if self.cb != 12 {
            throw OfficeFileError.corrupted
        }
        
        /// itc (2 bytes): An ItcFirstLim that specifies a cell range in the table row.
        self.itc = try ItcFirstLim(dataStream: &dataStream)
        
        /// shd (10 bytes): A Shd structure that specifies the background shading that is applied.
        self.sh = try Shd(dataStream: &dataStream)
    }
}
