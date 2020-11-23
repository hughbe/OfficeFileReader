//
//  Kt.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

/// [MS-DOC] 2.9.126 Kt
/// The Kt enumeration specifies the type of action to be taken when a shortcut key combination is pressed. This enumeration is used by the Kme structure.
public enum Kt: UInt16 {
    /// ktCid 0x0000 Execute a command specified by a Cid.
    case cid = 0x0000
    
    /// ktChar 0x0001 Insert a single character.
    case char = 0x0001
    
    /// ktMask 0x0003 Perform the default action (as if the key combination is unassigned).
    case mask = 0x0003
}
