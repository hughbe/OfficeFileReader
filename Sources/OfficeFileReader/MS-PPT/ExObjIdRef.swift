//
//  ExObjIdRef.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

/// [MS-PPT] 2.2.8 ExObjIdRef
/// Referenced by: ExObjRefAtom
/// A 4-byte unsigned integer that specifies a reference to an external object. It MUST be equal to the value of the exObjId field of an ExMediaAtom
/// record (section 2.10.6) or the value of the exObjId field of an ExOleObjAtom record (section 2.10.12).
public typealias ExObjIdRef = UInt32
