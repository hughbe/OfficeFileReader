//
//  TabJC.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

/// [MS-DOC] 2.9.300 TabJC
/// The TabJC enumeration provides a 3-bit unsigned integer that specifies the type of alignment which is applied to the text that is entered at this
/// tab stop. This MUST be one of the following values.
public enum TabJC: UInt8 {
    /// jcLeft 0x0 Left justification.
    case left = 0x0
    
    /// jcCenter 0x1 Center justification.
    case center = 0x1
    
    /// jcRight 0x2 Right justification.
    case right = 0x2
    
    /// jcDecimal 0x3 Specifies that the current tab stop results in a location in the document at which all following text is aligned around the first
    /// decimal separator in the following text runs. If there is no decimal separator, text is aligned around the implicit decimal separator after the
    /// last digit of the first numeric value that appears in the following text. All text runs before the first decimal character appear before the tab
    /// stop; all text runs after it appear after the tab stop location.
    case decimal = 0x3
    
    /// jcBar 0x4 Specifies that the current tab is a bar tab.
    case bar = 0x4
    
    /// jcList 0x6 Specifies that the current tab is a list tab.
    case list = 0x6
}
