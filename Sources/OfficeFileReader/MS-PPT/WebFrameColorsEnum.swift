//
//  WebFrameColorsEnum.swift
//  
//
//  Created by Hugh Bellamy on 21/11/2020.
//

/// [MS-PPT] 2.13.43 WebFrameColorsEnum
/// Referenced by: HTMLDocInfo9Atom
/// An enumeration that specifies the color options for displaying the text and background for the Web page notes pane and outline pane.
public enum WebFrameColorsEnum: UInt16 {
    /// MSOWOPTBrowserColors 0x0000 Browser colors.
    case browserColors = 0x0000
    
    /// MSOWOPTPresentationSchemeTextColor 0x0001 Presentation text colors.
    case presentationSchemeTextColor = 0x0001
    
    /// MSOWOPTPresentationSchemeAccentColor 0x0002 Presentation accent colors.
    case presentationSchemeAccentColor = 0x0002
    
    /// MSOWOPTWhiteTextOnBlack 0x0003 White text on black background.
    case whiteTextOnBlack = 0x0003
    
    /// MSOWOPTBlackTextOnWhite 0x0004 Black text on white background.
    case blackTextOnWhite = 0x0004
}
