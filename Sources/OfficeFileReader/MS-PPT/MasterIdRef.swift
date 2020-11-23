//
//  MasterIdRef.swift
//  
//
//  Created by Hugh Bellamy on 18/11/2020.
//

/// [MS-PPT] 2.2.17 MasterIdRef
/// Referenced by: SlideAtom
/// A 4-byte unsigned integer that specifies a reference to a main master slide or title master slide. It MUST be 0x00000000 or equal to the value of the
/// masterId field of a MasterPersistAtom record (section 2.4.14.2). The value 0x00000000 specifies a null reference.
public typealias MasterIdRef = UInt32
