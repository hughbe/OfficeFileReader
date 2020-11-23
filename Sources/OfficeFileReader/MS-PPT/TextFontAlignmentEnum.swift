//
//  TextFontAlignmentEnum.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

/// [MS-PPT] 2.13.31 TextFontAlignmentEnum
/// Referenced by: TextPFException
/// An enumeration that specifies font alignment.
public enum TextFontAlignmentEnum: UInt16 {
    /// Tx_ALIGNFONTRoman 0x0000 Place characters on font baseline.
    case roman = 0x0000
    
    /// Tx_ALIGNFONTHanging 0x0001 Characters hang from top of line height
    case hanging = 0x0001
    
    /// Tx_ALIGNFONTCenter 0x0002 Characters centered within line height.
    case center = 0x0002
    
    /// Tx_ALIGNFONTUpholdFixed 0x0003 Characters are anchored to the very bottom of a single line. This is different than Tx_ALIGNFONTRoman
    /// because of letters such as "g", "q", and "y".
    case upholdFixed = 0x0003
}
