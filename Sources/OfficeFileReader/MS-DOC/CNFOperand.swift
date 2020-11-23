//
//  CNFOperand.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.41 CNFOperand
/// The CNFOperand structure provides conditional formatting for a table style.
public struct CNFOperand {
    public let cb: UInt8
    public let cnfc: Condition
    public let grpprl: [Prl]
    
    public init(dataStream: inout DataStream) throws {
        /// cb (1 byte): An unsigned integer that specifies the size, in bytes, of this CNFOperand, excluding the cb member.
        self.cb = try dataStream.read()
        
        let startPosition = dataStream.position
        
        /// cnfc (2 bytes): A signed integer that specifies the condition for which the formatting in grpprl applies.
        /// The value of cnfc MUST be one of these values.
        let cnfcRaw: Int16 = try dataStream.read(endianess: .littleEndian)
        guard let cnfc = Condition(rawValue: cnfcRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.cnfc = cnfc
        
        /// grpprl (variable): An array of Prl. Specifies the formatting to apply (on top of the non-conditional formatting specified in the table style)
        /// when the condition is satisfied (see section 2.4.6 Applying Properties).
        var grpprl: [Prl] = []
        while dataStream.position  - startPosition < self.cb {
            grpprl.append(try Prl(dataStream: &dataStream))
        }
        
        self.grpprl = grpprl
        
        if dataStream.position - startPosition != self.cb {
            throw OfficeFileError.corrupted
        }
    }
    
    /// cnfc (2 bytes): A signed integer that specifies the condition for which the formatting in grpprl applies.
    /// The value of cnfc MUST be one of these values.
    public enum Condition: Int16 {
        /// 0x0001 Header row.
        case headerRow = 0x0001
        
        /// 0x0002 Footer row.
        case footerRow = 0x0002
        
        /// 0x0004 First column.
        case firstColumn = 0x0004
        
        /// 0x0008 Last column.
        case lastColumn = 0x0008
        
        /// 0x0010 Banded columns.
        case bandedColumns = 0x0010
        
        /// 0x0020 Even column banding.
        case evenColumnBanding = 0x0020
        
        /// 0x0040 Banded rows.
        case bandedRows = 0x0040
        
        /// 0x0080 Even row banding.
        case evenRowBanding = 0x0080
        
        /// 0x0100 Top right cell.
        case topRightCell = 0x0100
        
        /// 0x0200 Top left cell.
        case topLeftCell = 0x0200
        
        /// 0x0400 Bottom right cell.
        case bottomRightCell = 0x0400
        
        /// 0x0800 Bottom left cell.
        case bottomLeftCell = 0x0800
    }
}
