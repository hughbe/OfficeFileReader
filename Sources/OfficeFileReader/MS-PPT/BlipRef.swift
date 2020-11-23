//
//  BlipRef.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

/// [MS-PPT] 2.2.1 BlipRef
/// Referenced by: TextPFException9
/// A 2-byte signed integer that specifies a zero-based index of a picture bullet within the collection of picture bullets specified by the BlipCollection9Container
/// record (section 2.9.72). The value 0xFFFF specifies a null reference.
public typealias BlipRef = Int16
