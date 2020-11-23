//
//  File.swift
//  
//
//  Created by Hugh Bellamy on 21/11/2020.
//

/// [MS-PPT] 2.13.44 WebOutputEnum
/// Referenced by: HTMLDocInfo9Atom, HTMLPublishInfoAtom
/// An enumeration that specifies the target Web technology support for which a publishing is optimized.
public enum WebOutputEnum: UInt8 {
    /// HTML_EXPORTVersion3 0x01 Web page is optimized for use with HTML, CSS, Javascript and frames.
    case version3 = 0x01
    
    /// HTML_EXPORTVersion4 0x02 Web page is optimized for use with HTML, MHTML, DHTML, CSS, JScript, frames, VML, and PNG graphics.
    case version1 = 0x02
    
    /// HTML_EXPORTDual 0x04 Web page contains optimized output for both technology formats and conditional statements to determine proper usage.
    case dual = 0x04
}
