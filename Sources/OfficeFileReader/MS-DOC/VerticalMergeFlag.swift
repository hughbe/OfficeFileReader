//
//  VerticalMergeFlag.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

/// [MS-DOC] 2.9.342 VerticalMergeFlag
/// The VerticalMergeFlag enumeration provides a 2-bit value that specifies whether a table cell is merged with the cells above or below it.
/// This MUST be one of the following values.
public enum VerticalMergeFlag: UInt8 {
    /// fvmClear 0x00 The cell is not merged with cells above or below it. This is the default behavior.
    case clear = 0x00
    
    /// fvmMerge 0x01 The cell is one of a set of vertically merged cells. It contributes its layout region to the set and its own contents are not rendered.
    case merge = 0x01
    
    /// fvmRestart 0x03 The cell is the first cell in a set of vertically merged cells. The contents and formatting of this cell extend down into any
    /// consecutive cells below it that are set to the fvmMerge value.
    case restart = 0x03
}
