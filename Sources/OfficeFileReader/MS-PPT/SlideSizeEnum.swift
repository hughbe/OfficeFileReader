//
//  SlideSizeEnum.swift
//  
//
//  Created by Hugh Bellamy on 16/11/2020.
//

/// [MS-PPT] 2.13.26 SlideSizeEnum
/// Referenced by: DocumentAtom
/// An enumeration that specifies types of slide sizes.
public enum SlideSizeEnum: UInt16 {
    /// SS_Screen 0x0000 Slide size ratio is consistent with a computer screen.
    case screen = 0x0000
    
    /// SS_LetterPaper 0x0001 Slide size ratio is consistent with letter paper.
    case letterPaper = 0x0001
    
    /// SS_A4Paper 0x0002 Slide size ratio is consistent with A4 paper.
    case a4Paper = 0x0002
    
    /// SS_35mm 0x0003 Slide size ratio is consistent with 35mm photo slides.
    case thirtyFiveMmm = 0x0003
    
    /// SS_Overhead 0x0004 Slide size ratio is consistent with overhead projector slides.
    case overhead = 0x0004
    
    /// SS_Banner 0x0005 Slide size ratio is consistent with a banner.
    case banner = 0x0005
    
    /// SS_Custom 0x0006 Slide size ratio that is not consistent with any of the other specified slide sizes in this enumeration.
    case custom = 0x0006
}
