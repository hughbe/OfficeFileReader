//
//  ExHyperlinkIdRef.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import Foundation

/// [MS-PPT] 2.2.6 ExHyperlinkIdRef
/// Referenced by: ExHyperlinkRefAtom, InteractiveInfoAtom
/// A 4-byte unsigned integer that specifies a reference to a hyperlink. It MUST be 0x00000000 or equal to the value of the exHyperlinkId field of
/// an ExHyperlinkAtom record (section 2.10.17). The value 0x00000000 specifies a null reference.
public typealias ExHyperlinkIdRef = UInt32
