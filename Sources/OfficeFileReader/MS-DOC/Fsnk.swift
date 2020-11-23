//
//  Fsnk.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

/// [MS-DOC] 2.9.97 Fsnk
/// The Fsnk enumeration provides a 32-bit integer that specifies what kind of DofrFsn a record is. A field of this type MUST contain one of the
/// following values.
public enum Fsnk: UInt32 {
    /// fsnkNil 0x00000000 No specified record kind.
    case `nil` = 0x00000000
    
    /// fsnkFrameset 0x00000001 A record that has this fsnk value applies to the most recent DofrFsn record with fsnk equal to fsnkFrame, unless
    /// it appears before the first DofrFsn record with fsnk equal to fsnkFrame, in which case it applies to the outermost frame. This record type
    /// supplies more details about how that frame handles its child frames.
    case frameset = 0x00000001
    
    /// fsnkFrame 0x00000002 This record contains basic specifications for a frame. Records that have this fsnk value MUST appear before any
    /// other records that describe that frame.
    case frame = 0x00000002
}
