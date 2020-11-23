//
//  UidSel.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

/// [MS-DOC] 2.9.334 UidSel
/// The UidSel structure is a 2-byte integer that identifies a user or group of users for the purpose of specifying range-level protection information
/// about the given users. If the integer is greater than zero, it MUST be a 1-based index into the SttbProtUser at an offset of
/// FibRgFcLcb2003.fcSttbProtUser in the Table Stream. Otherwise, it is a UID type that MUST be one of the uidEveryone, uidEditors, or
/// uidOwners values.
public typealias UidSel = UInt16
