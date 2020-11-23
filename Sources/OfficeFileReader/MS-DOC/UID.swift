//
//  UID.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

/// [MS-DOC] 2.9.333 UID
/// The UID enumeration identifies common user types.
public enum UID: UInt16 {
    /// uidNone 0x0000 No users.
    case none = 0x0000
    
    /// uidCurrent 0xFFFA The current user.
    case current = 0xFFFA
    
    /// uidEditors 0xFFFB Editors of the document.
    case editors = 0xFFFB
    
    /// uidOwners 0xFFFC Owners of the document.
    case owners = 0xFFFC
    
    /// uidContributors 0xFFFD Contributors to the document.
    case contributors = 0xFFFD
    
    /// uidAdministrators 0xFFFE Members of the administrator group on the computer.
    case administrators = 0xFFFE
    
    /// uidEveryone 0xFFFF All users.
    case everyone = 0xFFFF
}
