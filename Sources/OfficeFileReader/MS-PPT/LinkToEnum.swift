//
//  LinkToEnum.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

/// [MS-PPT] 2.13.15 LinkToEnum
/// Referenced by: InteractiveInfoAtom
/// An enumeration that specifies how the action of a hyperlink is interpreted. All locations are relative to the currently-displayed presentation slide in
/// the slide show.
public enum LinkToEnum: UInt8 {
    /// LT_NextSlide 0x00 The next slide.
    case nextSlide = 0x00
    
    /// LT_PreviousSlide 0x01 The previous slide.
    case previousSlide = 0x01
    
    /// LT_FirstSlide 0x02 The first slide.
    case firstSlide = 0x02
    
    /// LT_LastSlide 0x03 The last slide.
    case lastSlide = 0x03
    
    /// LT_CustomShow 0x06 A named show.
    case customShow = 0x06
    
    /// LT_SlideNumber 0x07 A specific slide number.
    case slideNumber = 0x07
    
    /// LT_Url 0x08 A Uniform Resource Locator (URL).
    case url = 0x08
    
    /// LT_OtherPresentation 0x09 Another presentation file.
    case otherPresentation = 0x09
    
    /// LT_OtherFile 0x0A Another file that is not necessarily a presentation.
    case otherFile = 0x0A
    
    /// LT_Nil 0xFF The hyperlink is not valid.
    case `nil` = 0xFF
    
}
