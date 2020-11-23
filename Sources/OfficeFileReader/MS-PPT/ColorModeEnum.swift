//
//  ColorModeEnum.swift
//  
//
//  Created by Hugh Bellamy on 21/11/2020.
//

/// [MS-PPT] 2.13.5 ColorModeEnum
/// Referenced by: PrintOptionsAtom
/// An enumeration that specifies how colors are printed.
public enum ColorModeEnum: UInt8 {
    /// CM_BlackAndWhite 0x00 Every color is represented as black only or white only.
    case blackAndWhite = 0x00
    
    /// CM_Grayscale 0x01 Every color is represented by its corresponding shade of gray.
    case grayscale = 0x01
    
    /// CM_Color 0x02 No processing is done on the colors before sending them to the printer.
    case color = 0x02
}
