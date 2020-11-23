//
//  File.swift
//  
//
//  Created by Hugh Bellamy on 22/11/2020.
//

/// [MS-PPT] 2.13.40 TimeVisualElementEnum
/// Referenced by: VisualPageAtom, VisualShapeChartElementAtom, VisualShapeGeneralAtom, VisualSoundAtom
/// An enumeration that specifies the part of a slide or shape to which the animation is applied.
public enum TimeVisualElementEnum: UInt32 {
    /// TL_TVET_Shape 0x00000000 Applies to the shape and all its text.
    case shape = 0x00000000
    
    /// TL_TVET_Page 0x00000001 Applies to the slide.
    case page = 0x00000001
    
    /// TL_TVET_TextRange 0x00000002 Applies to a specified range of text of the shape.
    case textRange = 0x00000002
    
    /// TL_TVET_Audio 0x00000003 Applies to the audio of the shape.
    case audio = 0x00000003
    
    /// TL_TVET_Video 0x00000004 Applies to the video of the shape.
    case video = 0x00000004
    
    /// TL_TVET_ChartElement 0x00000005 Applies to the elements of the chart.
    case chartElement = 0x00000005
    
    /// TL_TVET_ShapeOnly 0x00000006 Applies to the shape but not its text.
    case shapeOnly = 0x00000006
    
    /// TL_TVET_AllTextRange 0x00000008 Applies to all text of the shape.
    case allTextRange = 0x00000008
}
