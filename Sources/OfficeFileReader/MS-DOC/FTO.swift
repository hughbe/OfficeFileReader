//
//  FTO.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

/// [MS-DOC] 2.9.100 FTO
/// The FTO enumerated type identifies the feature that is responsible to create a given smart tag in a document.
public enum FTO: UInt16 {
    /// ftoUnknown 0x0000 Not known.
    case unknown = 0x0000
    
    /// ftoGrammar 0x0001 The grammar checker.
    case grammar = 0x0001
    
    /// ftoScanDll 0x0002 An external scanning DLL.
    case scanDll = 0x0002
    
    /// ftoVB 0x0003 Visual Basic for Applications (VBA) script.
    case vb = 0x0003
}
