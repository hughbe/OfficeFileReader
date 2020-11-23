//
//  LBCOperand.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

/// [MS-DOC] 2.9.129 LBCOperand
/// The LBCOperand enumeration specifies where text continues after a line break. When a line is shortened or broken into multiple text regions by the
/// presence of a picture, shape, or another object, the operand specifies the location at which the text continues. If a line is not broken by an object, the
/// following values have no effect and the text simply continues on the next line.
public enum LBCOperand: UInt8 {
    /// lbrNone 0x00 Text continues in the next available region of the current line, in logical reading order, or on the next line if no more regions are left.
    case none = 0x00
    
    /// lbrLeft 0x01 If the line break is located to the logical left of the object, text restarts in the next available region of the current line, in logical reading
    /// order, or on the next line if no more regions are left.
    /// If the line break is located to the logical right of the object, text restarts on the next available line that is not broken by an object. In this case, the
    /// use of this value has the same result as the use of the value lbrBoth.
    case left = 0x01
    
    /// lbrRight 0x02 If the line break is located to the logical right of the object, text restarts in the next available region of the current line, in logical reading
    /// order, or on the next line if no more regions are left.
    /// If the line break is located to the logical left of the object, text restarts on the next available line that is not broken by an object. In this case, the use
    /// of this value has the same result as the use of the value lbrBoth.
    case right = 0x02
    
    /// lbrBoth 0x03 Text restarts on the next available line that is not broken by the presence of a picture, shape, or another object.
    case both = 0x03
}
