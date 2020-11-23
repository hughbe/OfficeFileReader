//
//  Sty.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

/// [MS-DOC] 2.9.299 Sty
/// The Sty structure is used by the Selsf structure and specifies the type of the selection that was made.
public enum Sty: UInt16 {
    /// styNil 0x0000 The selection type is undefined and is determined from the Selsf structure.
    case `nil` = 0x0000
    
    /// styChar 0x0001 The selection is one or more characters, an inline picture, or a text frame.
    case char = 0x0001
    
    /// styWord 0x0002 The selection is one or more whole words.
    case word = 0x0002
    
    /// stySent 0x0003 The selection is a sentence.
    case sent = 0x0003
    
    /// styPara 0x0004 The selection is a paragraph or a table cell.
    case para = 0x0004
    
    /// styLine 0x0005 The selection is one or more whole lines of text.
    case line = 0x0005
    
    /// styCol 0x000C The selection is one or more whole table cells.
    case col = 0x000C
    
    /// styRow 0x000D The selection is one or more table rows.
    case row = 0x000D
    
    /// styColAll 0x000E The selection is one or more table columns.
    case colAll = 0x000E
    
    /// styWholeTable 0x000F The selection is a whole table.
    case wholeTable = 0x000F
    
    /// styPrefix 0x001B The selection is a bullet or numbering character in a bulleted or numbered list.
    case prefix = 0x001B
}
