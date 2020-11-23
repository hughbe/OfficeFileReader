//
//  Dofrt.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

/// [MS-DOC] 2.9.63 Dofrt
/// The Dofrt enumeration provides a 32-bit unsigned integer that specifies the type of record contained in a Dofrh. A field of this type MUST contain
/// one of the following values.
public enum Dofrt: UInt32 {
    /// dofrtFs 0x00000000 Frame set root record.
    case fs = 0x00000000
    
    /// dofrtFsn 0x00000001 Frame record.
    case fsn = 0x00000001
    
    /// dofrtFsnp 0x00000002 Frame child marker.
    case fsnp = 0x00000002
    
    /// dofrtFsnName 0x00000003 Frame name.
    case fsnName = 0x00000003
    
    /// dofrtFsnFnm 0x00000004 Frame file path.
    case fsnFnm = 0x00000004
    
    /// dofrtFsnSpbd 0x00000005 Frame border attributes.
    case fsnSpbd = 0x00000005
    
    /// dofrtRglstsf 0x00000006 An array of list styles used in the document.
    case rglstsf = 0x00000006
}
