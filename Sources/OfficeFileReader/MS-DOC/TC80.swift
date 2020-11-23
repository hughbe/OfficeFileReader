//
//  TC80.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.313 TC80
/// The TC80 structure specifies the border and other formatting for a single cell in a table.
public struct TC80 {
    public let tcgrf: TCGRF
    public let wWidth: Int16
    public let brcTop: Brc80MayBeNil
    public let brcLeft: Brc80MayBeNil
    public let brcBottom: Brc80MayBeNil
    public let brcRight: Brc80MayBeNil
    
    public init() {
        self.tcgrf = TCGRF()
        self.wWidth = 0
        self.brcTop = .none
        self.brcLeft = .none
        self.brcBottom = .none
        self.brcRight = .none
    }
    
    public init(dataStream: inout DataStream) throws {
        /// tcgrf (2 bytes): A TCGRF that specifies table cell formatting.
        self.tcgrf = try TCGRF(dataStream: &dataStream)
        
        /// wWidth (2 bytes): An integer that specifies the preferred width of the cell. The width includes cell margins, but does not include cell
        /// spacing. This value MUST be a non-negative number. The unit of measurement depends on tcgrf.ftsWidth. If tcgrf.ftsWidth is set to
        /// ftsPercent, the value is a fraction of the width of the entire table.
        self.wWidth = try dataStream.read(endianess: .littleEndian)
        if self.wWidth < 0 {
            throw OfficeFileError.corrupted
        }
        
        /// brcTop (4 bytes): A Brc80MayBeNil structure that specifies the border to be used on the top side of the table cell.
        self.brcTop = try Brc80MayBeNil(dataStream: &dataStream)
        
        /// brcLeft (4 bytes): A Brc80MayBeNil structure that specifies the border to be used on the logical left side of the table cell.
        self.brcLeft = try Brc80MayBeNil(dataStream: &dataStream)
        
        /// brcBottom (4 bytes): A Brc80MayBeNil that specifies the border to be used on the bottom side of the table cell.
        self.brcBottom = try Brc80MayBeNil(dataStream: &dataStream)
        
        /// brcRight (4 bytes): A Brc80MayBeNil that specifies the border to be used on the logical right side of the table cell.
        self.brcRight = try Brc80MayBeNil(dataStream: &dataStream)
    }
}
