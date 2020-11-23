//
//  ElementTypeEnum.swift
//  
//
//  Created by Hugh Bellamy on 22/11/2020.
//

/// [MS-PPT] 2.13.9 ElementTypeEnum
/// Referenced by: VisualShapeChartElementAtom, VisualShapeGeneralAtom, VisualSoundAtom
/// An enumeration that specifies the element type of an animation target.
public enum ElementTypeEnum: UInt32 {
    /// TL_ET_ShapeType 0x00000001 The animation targets a shape or some part of a shape.
    case shape = 0x00000001
    
    /// TL_ET_SoundType 0x00000002 The animation targets a sound file that does not correspond to a shape.
    case sound = 0x00000002
}
