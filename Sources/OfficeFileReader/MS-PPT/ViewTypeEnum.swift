//
//  ViewTypeEnum.swift
//  
//
//  Created by Hugh Bellamy on 22/11/2020.
//

/// [MS-PPT] 2.13.42 ViewTypeEnum
/// Referenced by: UserEditAtom
/// An enumeration that specifies different viewing modes in which a presentation can be displayed in a user interface.
public enum ViewTypeEnum: UInt16 {
    /// V_Slide 0x0001 A view optimized for the display of a presentation slide.
    case slide = 0x0001

    /// V_SlideMaster 0x0002 A view optimized for the display of a main master slide.
    case slideMaster = 0x0002

    /// V_Notes 0x0003 A view optimized for the display of a notes slide.
    case notes = 0x0003

    /// V_Handout 0x0004 A view optimized for the display of the handout master slide.
    case handout = 0x0004

    /// V_NotesMaster 0x0005 A view optimized for the display of the notes master slide.
    case notesMaster = 0x0005

    /// V_OutlineMaster 0x0006 A view optimized for the display of the outline master slide.
    case outlineMaster = 0x0006

    /// V_Outline 0x0007 A view optimized for the display of the text on the presentation slides.
    case outline = 0x0007

    /// V_SlideSorter 0x0008 A view optimized for the simultaneous display of multiple presentation slides.
    case slideSorter = 0x0008

    /// V_VisualBasic 0x0009 A view optimized for the display of the VBA information.
    case visualBasic = 0x0009

    /// V_TitleMaster 0x000A A view optimized for the display of a title master slide.
    case titleMaster = 0x000A

    /// V_SlideShow 0x000B A view optimized for the display of a slide show.
    case slideShow = 0x000B

    /// V_SlideShowFullScreen 0x000C A view optimized for the display of a slide show in full screen.
    case slideShowFullScreen = 0x000C

    /// V_NotesText 0x000D A view optimized for the display of the text of a notes slide.
    case notesText = 0x000D

    /// V_PrintPreview 0x000E A view optimized for the display of a print preview of the presentation slides.
    case printPreview = 0x000E

    /// V_Thumbnails 0x000F A view optimized for the simultaneous display of multiple presentation slides in a single column.
    case thumbnails = 0x000F

    /// V_MasterThumbnails 0x0010 A view optimized for the simultaneous display of multiple main master slides or title master slides in a single column.
    case masterThumbnails = 0x0010

    /// V_PodiumSlideView 0x0011 A view optimized for the display of presentation slides while a slide show is also being displayed.
    case podiumSlideView = 0x0011

    /// V_PodiumNotesView 0x0012 A view optimized for the display of the text of a notes slide while a slide show is also being displayed.
    case podiumNotesView = 0x0012
}
