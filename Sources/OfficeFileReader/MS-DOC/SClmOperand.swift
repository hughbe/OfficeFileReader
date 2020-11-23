//
//  SClmOperand.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

/// [MS-DOC] 2.9.237 SClmOperand
/// The SClmOperand structure provides an enumeration which specifies the type of document grid that is used for the section. This enumeration defines the
/// following 16-bit unsigned integer values.
public enum SClmOperand: UInt16 {
    /// clmUseDefault 0x0000 Specifies that document grid is disabled.
    case useDefault = 0x0000
    
    /// clmCharsAndLines 0x0001 Specifies a document grid that enforces both character spacing and line pitch. Line pitch is specified by sprmSDyaLinePitch;
    /// character spacing is specified by sprmSDxtCharSpace.
    case charsAndLines = 0x0001
    
    /// clmLinesOnly 0x0002 Specifies a document grid that enforces only line pitch. Line pitch is specified by sprmSDyaLinePitch.
    case linesOnly = 0x0002
    
    /// clmEnforceGrid 0x0003 Specifies a document grid that enforces both character spacing and line pitch. Line pitch is specified by sprmSDyaLinePitch;
    /// character spacing is specified by sprmSDxtCharSpace. Each full-width character MUST occupy its own grid square.
    case enforceGrid = 0x0003
}
