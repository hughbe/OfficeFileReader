//
//  HatchStyle.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

/// [MS-WMF] 2.1.1.12 HatchStyle Enumeration
/// The HatchStyle Enumeration specifies the hatch pattern.
/// typedef enum
/// {
///  HS_HORIZONTAL = 0x0000,
///  HS_VERTICAL = 0x0001,
///  HS_FDIAGONAL = 0x0002,
///  HS_BDIAGONAL = 0x0003,
///  HS_CROSS = 0x0004,
///  HS_DIAGCROSS = 0x0005
/// } HatchStyle;
public enum HatchStyle: UInt16 {
    /// HS_HORIZONTAL: A horizontal hatch.
    case horizontal = 0x0000
    
    /// HS_VERTICAL: A vertical hatch.
    case vertical = 0x0001
    
    /// HS_FDIAGONAL: A 45-degree downward, left-to-right hatch.
    case fDiagonal = 0x0002
    
    /// HS_BDIAGONAL: A 45-degree upward, left-to-right hatch.
    case bDiagonal = 0x0003
    
    /// HS_CROSS: A horizontal and vertical cross-hatch.
    case cross = 0x0004
    
    /// HS_DIAGCROSS: A 45-degree crosshatch.
    case diagCross = 0x0005
}
