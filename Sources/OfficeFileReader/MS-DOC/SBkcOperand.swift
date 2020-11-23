//
//  SBkcOperand.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

/// [MS-DOC] 2.9.235 SBkcOperand
/// The SBkcOperand structure is the operand to sprmSBkc. This structure is an 8-bit unsigned integer that specifies the type of the section break that is being
/// described.
public enum SBkcOperand: UInt8 {
    /// bkcContinuous 0x00 A continuous section break. The next section starts on the next line.
    case continuous = 0x00
    
    /// bkcNewColumn 0x01 A new column section break. The next section starts in the next column.
    case newColumn = 0x01
    
    /// bkcNewPage 0x02 A new page section break. The next section starts on the next page.
    case newPage = 0x02
    
    /// bkcEvenPage 0x03 An even page section break. The next section starts on an even page.
    case venPage = 0x03
    
    /// bkcOddPage 0x04 An odd page section break. The next section starts on an odd page.
    case oddPage = 0x4
}
