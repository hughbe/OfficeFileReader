//
//  Fts.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

/// [MS-DOC] 2.9.101 Fts
/// The Fts enumeration specifies how the preferred width for a table, table indent, table cell, cell margin, or cell spacing is defined. Any Table SPRM that
/// specifies a preferred table width, table indent, cell width, cell margin, or cell spacing MUST also specify an Fts value to determine how the size is
/// defined. Some Fts values are disallowed for some Sprms.
public enum Fts: UInt8 {
    /// ftsNil 0x00 The size is undefined and MUST be ignored.
    case `nil` = 0x00
    
    /// ftsAuto 0x01 No preferred width is specified. The width is derived from other table measurements where a preferred size is specified, as
    /// well as from the size of the table contents, and the constraining size of the container of the table.
    case auto = 0x01
    
    /// ftsPercent 0x02 The preferred width is measured in units of 1/50th of a percent (that is, a value of 50 translates to 1 percent).
    /// When specifying the preferred width of a portion of a table, such as a cell, spacing or indent, the percentage is relative to the width of the entire table.
    /// When specifying the preferred width of an entire table, the percentage is relative to the width of the page, less any margin or gutter space.
    /// Alternatively, if the table is nested inside another table, the percentage is relative to the width of the cell in the containing table, less cell margins.
    case percent = 0x02
    
    /// ftsDxa 0x03 The preferred width of the table, indent, cell, cell margin, or cell spacing is an absolute width measured in twips.
    case dxa = 0x03
    
    /// ftsDxaSys 0x13 The preferred cell spacing is an absolute width measured in twips. ftsDxaSys is used when cell spacing is applied as a result of
    /// applying a table border.
    case dxaSys = 0x13
}
