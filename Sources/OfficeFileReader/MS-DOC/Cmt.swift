//
//  Cmt.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

/// [MS-DOC] 2.9.40 Cmt
/// The Cmt enumeration provides an unsigned 3-bit integer that specifies the type of a command; see Cid for more details. The valid values are as follows.
public enum Cmt: UInt8 {
    /// cmtFci 0x1 Command based on a built-in command. See CidFci.
    case fci = 0x1
    
    /// cmtMacro 0x2 Macro command. See CidMacro.
    case macro = 0x2
    
    /// cmtAllocated 0x3 Allocated command. See CidAllocated.
    case allocated = 0x3
    
    /// cmtNil 0x7 No command. See Cid.
    case `nil` = 0x7
}
