//
//  SLncOperand.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

/// [MS-DOC] 2.9.250 SLncOperand
/// The SLncOperand enumeration is the operand to sprmSLnc. This structure is an 8-bit unsigned integer that specifies the line numbering mode
/// for the section.
public enum SLncOperand: UInt8 {
    /// lncPerPage 0x00 Line numbers restart every page.
    case incPerPage = 0x00
    
    /// lncRestart 0x01 Line numbers restart at the beginning of the section.
    case incRestart = 0x01
    
    /// lncContinue 0x02 Line numbers continue from the preceding section, or start at 1 if this is the first section of the document.
    case incContinue = 0x02
}
