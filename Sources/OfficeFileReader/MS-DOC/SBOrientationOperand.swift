//
//  SBOrientationOperand.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

/// [MS-DOC] 2.9.236 SBOrientationOperand
/// The SBOrientationOperand structure is the operand to sprmSBOrientation. This structure is an 8-bit unsigned integer that specifies page orientation.
public enum SBOrientationOperand: UInt8 {
    /// dmOrientPortrait 0x01 Portrait orientation.
    case portrait = 0x01
    
    /// dmOrientLandscape 0x02 Landscape orientation.
    case landscape = 0x02
}
