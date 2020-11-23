//
//  PlaceholderEnum.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

/// [MS-PPT] 2.13.21 PlaceholderEnum
/// Referenced by: PlaceholderAtom, RoundTripHFPlaceholder12Atom, RoundTripNewPlaceholderId12Atom, SlideAtom
/// An enumeration that specifies the type of a placeholder shape. The meaning of each enumeration value is further specified in the PlaceholderAtom record.
/// This enumeration is also used to define a slide layout as described in the SlideAtom record.
public enum PlaceholderEnum: UInt8 {
    /// PT_None 0x00 No placeholder shape.
    case none = 0x00

    /// PT_MasterTitle 0x01 Master title text placeholder shape.
    case masterTitle = 0x01

    /// PT_MasterBody 0x02 Master body text placeholder shape.
    case masterBody = 0x02

    /// PT_MasterCenterTitle 0x03 Master center title text placeholder shape.
    case masterCenterTitle = 0x03

    /// PT_MasterSubTitle 0x04 Master sub-title text placeholder shape.
    case masterSubTitle = 0x04

    /// PT_MasterNotesSlideImage 0x05 Master notes slide image placeholder shape.
    case masterNotesSlideImage = 0x05

    /// PT_MasterNotesBody 0x06 Master notes body text placeholder shape.
    case masterNotesBody = 0x06

    /// PT_MasterDate 0x07 Master date placeholder shape.
    case masterDate = 0x07

    /// PT_MasterSlideNumber 0x08 Master slide number placeholder shape.
    case masterSlideNumber = 0x08

    /// PT_MasterFooter 0x09 Master footer placeholder shape.
    case masterFooter = 0x09

    /// PT_MasterHeader 0x0A Master header placeholder shape.
    case masterHeader = 0x0A

    /// PT_NotesSlideImage 0x0B Notes slide image placeholder shape.
    case notesSlideImage = 0x0B

    /// PT_NotesBody 0x0C Notes body text placeholder shape.
    case notesBody = 0x0C

    /// PT_Title 0x0D Title text placeholder shape.
    case title = 0x0D

    /// PT_Body 0x0E Body text placeholder shape.
    case body = 0x0E

    /// PT_CenterTitle 0x0F Center title text placeholder shape.
    case center = 0x0F

    /// PT_SubTitle 0x10 Sub-title text placeholder shape.
    case subTitle = 0x10

    /// PT_VerticalTitle 0x11 Vertical title text placeholder shape.
    case verticalTitle = 0x11

    /// PT_VerticalBody 0x12 Vertical body text placeholder shape.
    case verticalBody = 0x12

    /// PT_Object 0x13 Object placeholder shape.
    case object = 0x13

    /// PT_Graph 0x14 Graph object placeholder shape.
    case graph = 0x14

    /// PT_Table 0x15 Table object placeholder shape.
    case table = 0x15

    /// PT_ClipArt 0x16 Clipart object placeholder shape.
    case clipArt = 0x16

    /// PT_OrgChart 0x17 Organization chart object placeholder shape.
    case orgChart = 0x17

    /// PT_Media 0x18 Media object placeholder shape.
    case media = 0x18

    /// PT_VerticalObject 0x19 Vertical object placeholder shape.
    case verticalObject = 0x19

    /// PT_Picture 0x1A Picture object placeholder shape.
    case picture = 0x1A
}
