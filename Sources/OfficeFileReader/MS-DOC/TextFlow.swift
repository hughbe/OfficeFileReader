//
//  TextFlow.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

/// [MS-DOC] 2.9.323 TextFlow
/// The TextFlow enumeration specifies the rotation settings for a block of text and for the individual East Asian characters in each line of the block.
/// A TextFlow value MUST be one of the following.
public enum TextFlow: UInt16 {
    /// grpfTFlrtb 0x0000 Specifies the standard vertical text arrangement. The text block is not rotated. Multiple lines are arranged top to bottom.
    /// The characters on a line are laid out left to right.
    case rtb = 0x0000
    
    /// grpfTFtbrl 0x0001 Specifies a 90-degree clockwise rotation of the standard vertical text block. The lines in the block are vertical and arranged
    /// right to left. The characters on a line are rotated 90 degrees in a clockwise direction and laid out top to bottom.
    case tbrl = 0x0001
    
    /// grpfTFbtlr 0x0003 Specifies a 90 degree, counter-clockwise rotation of the standard vertical text block. The lines in the block are vertical and
    /// arranged left to right. The characters on a line are rotated 90 degrees in a counter-clockwise direction and laid out bottom to top.
    case btlr = 0x0003
    
    /// grpfTFlrtbv 0x0004 Specifies the same line layout as grpfTFlrtb, however, each East Asian character is rotated 90 degrees in a counter-clockwise
    /// direction. All other text is not rotated.
    case lrtbv = 0x0004
    
    /// grpfTFtbrlv 0x0005 Specifies the same rotated line layout as grpfTFtbrl, however, each East Asian character is rotated 90-degrees in a
    /// counter-clockwise direction within the block, canceling out the rotation in grpfTFtbrl. All other text is left with the rotation found in grpfTFtbrl.
    case tbrlv = 0x0005
}
