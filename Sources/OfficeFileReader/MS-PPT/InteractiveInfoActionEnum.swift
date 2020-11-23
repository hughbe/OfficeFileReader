//
//  InteractiveInfoActionEnum.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

/// [MS-PPT] 2.13.13 InteractiveInfoActionEnum
/// Referenced by: InteractiveInfoAtom
/// An enumeration that specifies an action that can be performed when interacting with an object during a slide show.
public enum InteractiveInfoActionEnum: UInt8 {
    /// II_NoAction 0x00 No effect.
    case noAction = 0x00
    
    /// II_MacroAction 0x01 A macro is executed.
    case macroAction = 0x01
    
    /// II_RunProgramAction 0x02 A program is run.
    case runProgramAction = 0x02
    
    /// II_JumpAction 0x03 The current presentation slide of the slide show jumps to another presentation slide in the same presentation.
    case jumpAction = 0x03
    
    /// II_HyperlinkAction 0x04 A URL is executed.
    case hyperlinkAction = 0x04
    
    /// II_OLEAction 0x05 An OLE action (only valid if the object this applies to is an OLE embedded object).
    case oleAction = 0x05
    
    /// II_MediaAction 0x06 A media object is played.
    case mediaAction = 0x06
    
    /// II_CustomShowAction 0x07 A named show is displayed.
    case customShowAction = 0x07
}
