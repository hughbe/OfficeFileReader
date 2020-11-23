//
//  RouteSlipProtectionEnum.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

/// [MS-DOC] 2.9.234 RouteSlipProtectionEnum
/// The RouteSlipProtectionEnum enumeration lists the possible protection levels for a document being routed.
public enum RouteSlipProtectionEnum: UInt16 {
    /// ProtectOff 0x0000 No protection.
    case off = 0x0000
    
    /// ProtectRevMark 0x0001 Changes to the document can be neither accepted nor rejected, and change tracking cannot be turned off.
    case revMark = 0x0001
    
    /// ProtectAnnot 0x0002 Users can insert comments into the document but cannot change the content of the document.
    case annot = 0x0002
    
    /// ProtectForm 0x0003 Users can make changes only in form fields or in unprotected sections of a document.
    case form = 0x0003
}
