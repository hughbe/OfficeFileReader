//
//  SDTT.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

/// [MS-DOC] 2.9.240 SDTT
/// The SDTT structure specifies the type of structured document tag that is represented by a structured document tag bookmark in the document.
public enum SDTT: UInt32 {
    /// sdttUnknown 0x00000000 The type of the tag is determined from the range it encloses.
    case unknown = 0x00000000
    
    /// sdttRegular 0x00000001 The tag encloses a range of characters.
    case regular = 0x00000001
    
    /// sdttPara 0x00000002 The tag encloses a range of paragraphs.
    case para = 0x00000002
    
    /// sdttCell 0x00000003 The tag encloses a range of cells in a table.
    case cell = 0x00000003
    
    /// sdttRow 0x00000004 The tag encloses a range of rows in a table.
    case row = 0x00000004
}
