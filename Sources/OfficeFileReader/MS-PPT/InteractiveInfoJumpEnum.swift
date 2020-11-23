//
//  InteractiveInfoJumpEnum.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

/// [MS-PPT] 2.13.14 InteractiveInfoJumpEnum
/// Referenced by: InteractiveInfoAtom
/// An enumeration that specifies a location relative to the currently-displayed presentation slide in the slide show.
public enum InteractiveInfoJumpEnum: UInt8 {
    /// II_NoJump 0x00 No change.
    case noJump = 0x00
    
    /// II_NextSlide 0x01 The next slide.
    case nextSlide = 0x01
    
    /// II_PreviousSlide 0x02 The previous slide.
    case previousSlide = 0x02
    
    /// II_FirstSlide 0x03 The first slide.
    case firstSlide = 0x03
    
    /// II_LastSlide 0x04 The last slide.
    case lastSlide = 0x04
    
    /// II_LastSlideViewed 0x05 The last viewed slide.
    case lastSlideViewed = 0x05
    
    /// II_EndShow 0x06 The end of show slide (a virtual slide displayed after the last slide)
    case endShow = 0x06
}
