//
//  Vjc.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

/// [MS-DOC] 2.9.344 Vjc
/// The Vjc enumeration provides an 8-bit unsigned integer that specifies the vertical alignment of text.
public enum Vjc: UInt8 {
    /// vjcTop 0x00 Top
    case top = 0x00
    
    /// vjcCenter 0x01 Centered
    case center = 0x01
    
    /// vjcBoth 0x02 Justified
    case both = 0x02
    
    /// vjcBottom 0x03 Bottom
    case bottom = 0x03
}
