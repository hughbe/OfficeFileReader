//
//  PgbPageDepth.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

/// [MS-DOC] 2.9.186 PgbPageDepth
/// The PgbPageDepth enumeration is used to specify the "depth" of a page border in relation to other page elements.
public enum PgbPageDepth: UInt8 {
    /// pgbAtFront 0x0 The page border is positioned in front of the text and other content.
    case atFront = 0x0
    
    /// pgbAtBack 0x1 The page border is positioned behind the text and other content.
    case atBack = 0x1
}
