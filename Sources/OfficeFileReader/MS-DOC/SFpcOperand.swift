//
//  SFpcOperand.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

/// [MS-DOC] 2.9.246 SFpcOperand
/// The SFpcOperant enumeration provides an 8-bit unsigned integer that specifies the positioning of the section footnote. SFpcOperand is the operand to
/// sprmSFpc.
public enum SFpcOperand: UInt8 {
    /// fpcBottomPage 0x01 Footnotes are positioned at the bottom of the page.
    case bottomPage = 0x01
    
    /// fpcBeneathText 0x02 Footnotes are positioned beneath the text on the page.
    case beneathText = 0x02
}
