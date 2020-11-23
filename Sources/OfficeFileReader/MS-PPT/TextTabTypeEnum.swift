//
//  TextTabTypeEnum.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

/// [MS-PPT] 2.13.32 TextTabTypeEnum
/// Referenced by: TabStop
/// An enumeration that specifies alignment types of tab stops.
public enum TextTabTypeEnum: UInt16 {
    /// Tx_TABLeft 0x0000 Left-aligned tab stop.
    case left = 0x0000
    
    /// Tx_TABCenter 0x0001 Center-aligned tab stop.
    case center = 0x0001
    
    /// Tx_TABRight 0x0002 Right-aligned tab stop.
    case right = 0x0002
    
    /// Tx_TABDecimal 0x0003 Decimal point-aligned tab stop.
    case decimal = 0x0003
}
