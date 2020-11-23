//
//  TabLC.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

/// [MS-DOC] 2.9.301 TabLC
/// The TabLC enumeration is a 3-bit unsigned integer that specifies the characters that are used to fill in the space which is created by a tab that
/// ends at a custom tab stop. This MUST be one of the following values.
public enum TabLC: UInt8 {
    /// tlcNone 0x0 No leader.
    case none = 0x0
    
    /// tlcDot 0x1 Dot leader.
    case dot = 0x1
    
    /// tlcHyphen 0x2 Dashed leader.
    case hyphem = 0x2
    
    /// tlcUnderscore 0x3 Underscore leader.
    case underscore = 0x3
    
    /// tlcHeavy 0x4 Same as tlcUnderscore.
    case heavy = 0x4
    
    /// tlcMiddleDot 0x5 Centered dot leader.
    case middleDot = 0x5
    
    /// tlcDefault 0x7 Same as tlcNone.
    case `default` = 0x7
}
