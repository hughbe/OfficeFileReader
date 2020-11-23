//
//  Kul.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

/// [MS-DOC] 2.9.127 Kul
/// The Kul enumeration specifies the style of underlining for text.
public enum Kul: UInt8 {
    /// kulNone 0x00 No underlining.
    case none = 0x00
    
    /// kulSingle 0x01 Normal single underline.
    case single = 0x01
    
    /// kulWords 0x02 Underline words only.
    case words = 0x02
    
    /// kulDouble 0x03 Double underline.
    case double = 0x03
    
    /// kulDotted 0x04 Dotted underline.
    case dotted = 0x04
    
    /// kulThick 0x06 Heavy underline.
    case heavy = 0x06
    
    /// kulDash 0x07 Dashed underline.
    case dashed = 0x07
    
    /// kulDotDash 0x09 Dot-dash underline.
    case dotDash = 0x09
    
    /// kulDotDotDash 0x0A Dot-dot-dash underline.
    case dotDotDash = 0x0A
    
    /// kulWavy 0x0B Wavy underline.
    case wavy = 0x0B
    
    /// kulDottedHeavy 0x14 Heavy dotted underline.
    case dottedHeavy = 0x14
    
    /// kulDashHeavy 0x17 Heavy dashed underline.
    case dashHeavy = 0x17
    
    /// kulDotDashHeavy 0x19 Heavy dot-dash underline.
    case dotDashHeavy = 0x19
    
    /// kulDotDotDashHeavy 0x1A Heavy dot-dot-dash underline.
    case dotDotDashHeavy = 0x1A
    
    /// kulWavyHeavy 0x1B Heavy wavy underline.
    case wavyHeavy = 0x1B
    
    /// kulDashLong 0x27 Long-dash underline.
    case dashLong = 0x27
    
    /// kulWavyDouble 0x2B Wavy double underline.
    case wavyDouble = 0x2B
    
    /// kulDashLongHeavy 0x37 Heavy long-dash underline.
    case dashLongHeavy = 0x37
}
