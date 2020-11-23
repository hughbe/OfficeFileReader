//
//  TextAlignmentEnum.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-PPT] 2.13.27 TextAlignmentEnum
/// Referenced by: TextPFException
/// An enumeration that specifies paragraph alignments.
public enum TextAlignmentEnum: UInt16 {
    /// Tx_ALIGNLeft 0x0000 For horizontal text, left aligned. For vertical text, top aligned.
    case left = 0x0000
    
    /// Tx_ALIGNCenter 0x0001 For horizontal text, centered. For vertical text, middle aligned.
    case center = 0x0001
    
    /// Tx_ALIGNRight 0x0002 For horizontal text, right aligned. For vertical text, bottom aligned.
    case right = 0x0002
    
    /// Tx_ALIGNJustify 0x0003 For horizontal text, flush left and right. For vertical text, flush top and bottom.
    case justify = 0x0003
    
    /// Tx_ALIGNDistributed 0x0004 Distribute space between characters.
    case distributed = 0x0004
    
    /// Tx_ALIGNThaiDistributed 0x0005 Thai distribution justification.
    case thaiDistributed = 0x0005
    
    /// Tx_ALIGNJustifyLow 0x0006 Kashida justify low.
    case justifyLow = 0x0006
}
