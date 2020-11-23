//
//  CNS.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

/// [MS-DOC] 2.9.42 CNS
/// The CNS enumeration provides an unsigned 8-bit integer that specifies the separator character to be used between the chapter number and the page
/// number when chapter numbering is enabled in page number fields.
public enum CNS: UInt8 {
    /// cnsHyphen 0x00 Specifies that the separator character is a hyphen ("-").
    case hyphen = 0x00
    
    /// cnsPeriod 0x01 Specifies that the separator character is a period (".").
    case period = 0x01
    
    /// cnsColon 0x02 Specifies that the separator character is a colon (":").
    case colon = 0x02
    
    /// cnsEmDash 0x03 Specifies that the separator character is an em dash ("—").
    case emDash = 0x03
    
    /// cnsEnDash 0x04 Specifies that the separator character is an en dash ("–").
    case enDash = 0x04
}
