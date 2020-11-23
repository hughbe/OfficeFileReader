//
//  Rnc.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

/// [MS-DOC] 2.9.231 Rnc
/// The Rnc enumeration specifies whether and when the numbering for footnotes or endnotes restarts. The members of this enumeration are specified
/// as the following 8-bit unsigned integer values.
public enum Rnc: UInt8 {
    /// rncCont 0x00 Numbering is continuous throughout the whole document.
    case cont = 0x00
    
    /// rncRstSect 0x01 Numbering restarts at the beginning of the section.
    case sect = 0x01
    
    /// rncRstPage 0x02 Numbering restarts every page.
    case page = 0x02
}
