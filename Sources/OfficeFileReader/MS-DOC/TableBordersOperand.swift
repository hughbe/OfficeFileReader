//
//  TableBordersOperand.swift
//
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.302 TableBordersOperand
/// The TableBordersOperand structure specifies a set of borders for a table row.
public struct TableBordersOperand {
    public let cb: UInt8
    public let brcTop: Brc
    public let brcLeft: Brc
    public let brcBottom: Brc
    public let brcRight: Brc
    public let brcHorizontalInside: Brc
    public let brcVerticalInside: Brc
    
    public init(dataStream: inout DataStream) throws {
        /// cb (1 byte): An unsigned integer that specifies the size of this operand, not including this byte. This value MUST be 0x18.
        self.cb = try dataStream.read()
        if self.cb != 0x30 {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// brcTop (8 bytes): A Brc structure that specifies the top border of the row, if it is the first row in the table.
        self.brcTop = try Brc(dataStream: &dataStream)
        
        /// brcLeft (8 bytes): A Brc structure that specifies the logical left border of the row.
        self.brcLeft = try Brc(dataStream: &dataStream)
        
        /// brcBottom (8 bytes): A Brc structure that specifies the bottom border of the row, if it is the last row in the table.
        self.brcBottom = try Brc(dataStream: &dataStream)
        
        /// brcRight (8 bytes): A Brc structure that specifies the logical right border of the row.
        self.brcRight = try Brc(dataStream: &dataStream)
        
        /// brcHorizontalInside (8 bytes): A Brc structure that specifies the horizontal border between the row and the preceding and succeeding rows.
        self.brcHorizontalInside = try Brc(dataStream: &dataStream)
        
        /// brcVerticalInside (8 bytes): A Brc structure that specifies the vertical border between the cells in the row.
        self.brcVerticalInside = try Brc(dataStream: &dataStream)
        
        if dataStream.position - startPosition < self.cb {
            throw OfficeFileError.corrupted
        }
    }
}
