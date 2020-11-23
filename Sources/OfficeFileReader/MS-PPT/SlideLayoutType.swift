//
//  File.swift
//  
//
//  Created by Hugh Bellamy on 21/11/2020.
//

/// [MS-PPT] 2.13.25 SlideLayoutType
/// Referenced by: SlideAtom
/// An enumeration that specifies the slide layout of a slide
public enum SlideLayoutType: UInt32 {
    /// SL_TitleSlide 0x00000000 One title and one subtitle placeholder shapes.
    case titleSlide = 0x00000000
    
    /// SL_TitleBody 0x00000001 Presentation slide or main master slide layout with one title and one body placeholder shape.
    case titleBody = 0x00000001
    
    /// SL_MasterTitle 0x00000002 Title master slide layout with one title and one subtitle placeholder shape.
    case masterTitle = 0x00000002
    
    /// SL_TitleOnly 0x00000007 Presentation slide layout with one title placeholder shape.
    case titleOnly = 0x00000007
    
    /// SL_TwoColumns 0x00000008 Presentation slide layout with one title and two body placeholder shapes stacked horizontally.
    case twoColumns = 0x00000008
    
    /// SL_TwoRows 0x00000009 Presentation slide layout with one title and two body placeholder shapes stacked vertically.
    case twoRows = 0x00000009
    
    /// SL_ColumnTwoRows 0x0000000A Presentation slide layout with one title and three body placeholder shapes split into two columns.
    /// The right column has two rows.
    case columnTwoRows = 0x0000000A
    
    /// SL_TwoRowsColumn 0x0000000B Presentation slide layout with one title and three body placeholder shapes split into two columns.
    /// The left column has two rows.
    case twoRowsColumn = 0x0000000B
    
    /// SL_TwoColumnsRow 0x0000000D Presentation slide layout with one title and three body placeholder shapes split into two rows.
    /// The top row has two columns.
    case twoColumnsRow = 0x0000000D
    
    /// SL_FourObjects 0x0000000E Presentation slide layout with one title and four body placeholder shapes.
    case fourObjects = 0x0000000E
    
    /// SL_BigObject 0x0000000F Presentation slide layout with one body placeholder shape.
    case bigObject = 0x0000000F
    
    /// SL_Blank 0x00000010 Presentation slide layout with no placeholder shape.
    case blank = 0x00000010
    
    /// SL_VerticalTitleBody 0x00000011 Presentation slide layout with a vertical title placeholder shape on the right and a body placeholder shape on
    /// the left.
    case verticalTitleBody = 0x00000011
    
    /// SL_VerticalTwoRows 0x00000012 Presentation slide layout with a vertical title placeholder shape on the right and two body placeholder shapes
    /// in two columns on the left.
    case verticalTwoRows = 0x00000012
}
