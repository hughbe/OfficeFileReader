//
//  PlaceholderSize.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

/// [MS-PPT] 2.13.22 PlaceholderSize
/// Referenced by: PlaceholderAtom
/// An enumeration that specifies the preferred size of a placeholder shape. The size is relative to the size of the master body text placeholder shape.
public enum PlaceholderSize: UInt8 {
    /// PS_Full 0x00 The full size of the master body text placeholder shape.
    case full = 0x00
    
    /// PS_Half 0x01 Half of the size of the master body text placeholder shape.
    case half = 0x01
    
    /// PS_Quarter 0x02 A quarter of the size of the master body text placeholder shape.
    case quarter = 0x02
}
