//
//  AnimAfterEffectEnum.swift
//  
//
//  Created by Hugh Bellamy on 23/11/2020.
//

/// [MS-PPT] 2.13.1 AnimAfterEffectEnum
/// Referenced by: AnimationInfoAtom
/// An enumeration that specifies behavior types of shapes or text after animation effects are complete.
public enum AnimAfterEffectEnum: UInt8 {
    /// AI_NoAfterEffect 0x00 No further change to the animated object after the animation is complete.
    case noAfterEffect = 0x00
    
    /// AI_Dim 0x01 Change the animated object to a specified color after the animation is complete.
    case dim = 0x01
    
    /// AI_Hide 0x02 Hide the animated object on the next mouse click.
    case hide = 0x02
    
    /// AI_HideImmediately 0x03 Hide the animated object immediately after the animation is complete.
    case hideImmediately = 0x03
}
