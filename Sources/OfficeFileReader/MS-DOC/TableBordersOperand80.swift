//
//  TableBordersOperand80.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.303 TableBordersOperand80
/// The TableBordersOperand80 structure is an operand that specifies the borders which are applied to a row of table cells.
public struct TableBordersOperand80 {
    public let cb: UInt8
    public let brcTop: Brc80MayBeNil
    public let brcLeft: Brc80MayBeNil
    public let brcBottom: Brc80MayBeNil
    public let brcRight: Brc80MayBeNil
    public let brcHorizontalInside: Brc80MayBeNil
    public let brcVerticalInside: Brc80MayBeNil
    
    public init(dataStream: inout DataStream) throws {
        /// cb (1 byte): An unsigned integer that specifies the size of this operand, not including this byte. This value MUST be 0x18.
        self.cb = try dataStream.read()
        if self.cb != 0x18 {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// brcTop (4 bytes): A Brc80MayBeNil structure that specifies the top border of the row, if it is the first row in the table.
        self.brcTop = try Brc80MayBeNil(dataStream: &dataStream)
        
        /// brcLeft (4 bytes): A Brc80MayBeNil structure that specifies the logical left border of the row.
        self.brcLeft = try Brc80MayBeNil(dataStream: &dataStream)
        
        /// brcBottom (4 bytes): A Brc80MayBeNil structure that specifies the bottom border of the row, if it is the last row in the table.
        self.brcBottom = try Brc80MayBeNil(dataStream: &dataStream)
        
        /// brcRight (4 bytes): A Brc80MayBeNil structure that specifies the logical right border of the row.
        self.brcRight = try Brc80MayBeNil(dataStream: &dataStream)
        
        /// brcHorizontalInside (4 bytes): A Brc80MayBeNil structure that specifies the horizontal border between cells in this table row and those in the
        /// preceding or succeeding table rows.
        self.brcHorizontalInside = try Brc80MayBeNil(dataStream: &dataStream)
        
        /// brcVerticalInside (4 bytes): A Brc80MayBeNil structure that specifies the vertical border between neighboring cells of this table row.
        self.brcVerticalInside = try Brc80MayBeNil(dataStream: &dataStream)
        
        if dataStream.position - startPosition < self.cb {
            throw OfficeFileError.corrupted
        }
    }
}
