//
//  FFM.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

/// [MS-DOC] 2.9.81 FFM
/// The FFM enumeration specifies the type of font substitution that is needed for the associated text. Font substitution is needed when certain
/// language characters are not supported by the current font for the text, so a different font needs to be picked that supports the characters.
public enum FFM: UInt8 {
    /// ffmNone 0x00 No font substitution is needed for this text.
    case none = 0x00
    
    /// ffmDefault 0x01 Substitute a font using default heuristics.
    case `default` = 0x01
    
    /// ffmUILang 0x02 Substitute a font using the best font for the language of the text.
    case uiLang = 0x02
    
    /// ffmUIDialog 0x04 Substitute a font using the same font that the user interface text is displayed in, if appropriate.
    case uiDialog = 0x04
}
