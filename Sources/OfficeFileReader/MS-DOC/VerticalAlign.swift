//
//  VerticalAlign.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

/// [MS-DOC] 2.9.341 VerticalAlign
/// The VerticalAlign enumeration specifies the vertical alignment of content within table cells.
public enum VerticalAlign: UInt8 {
    /// vaTop 0x00 Specifies that content is vertically aligned to the top of the cell.
    case top = 0x00
    
    /// vaCenter 0x01 Specifies that content is vertically aligned to the center of the cell.
    case center = 0x01
    
    /// vaBottom 0x02 Specifies that content is vertically aligned to the bottom of the cell.
    case bottom = 0x02
}
