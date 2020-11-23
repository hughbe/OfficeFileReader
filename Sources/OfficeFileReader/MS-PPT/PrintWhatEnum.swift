//
//  PrintWhatEnum.swift
//  
//
//  Created by Hugh Bellamy on 21/11/2020.
//

/// [MS-PPT] 2.13.23 PrintWhatEnum
/// Referenced by: PrintOptionsAtom
/// An enumeration that specifies which aspect of the presentation to print.
public enum PrintWhatEnum: UInt8 {
    /// PW_Slides 0x00 The presentation slides.
    case slides = 0x00
    
    /// PW_BuildSlides 0x01 The presentation slides plus extra images showing the steps of animations.
    case buildSlides = 0x01
    
    /// handouts2 0x02 A layout optimized for handout slides where two slides are shown per page.
    case handouts2 = 0x02
    
    /// handouts3 0x03 A layout optimized for handout slides where three slides are shown per page.
    case handouts3 = 0x03
    
    /// handouts6 0x04 A layout optimized for handout slides where six slides are shown per page.
    case handouts6 = 0x04
    
    /// PW_Notes 0x05 The presentation slides plus the attached notes.
    case notes = 0x05
    
    /// PW_Outline 0x06 The text outline of the presentation.
    case outline = 0x06
    
    /// handouts4 0x07 A layout optimized for handout slides where four slides are shown per page.
    case handouts4 = 0x07
    
    /// handouts9 0x08 A layout optimized for handout slides where nine slides are shown per page.
    case handouts9 = 0x08
    
    /// handouts1 0x09 A layout optimized for handout slides where one slide is shown per page.
    case handouts1 = 0x09
}
