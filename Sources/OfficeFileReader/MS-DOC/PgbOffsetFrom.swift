//
//  PgbOffsetFrom.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

/// [MS-DOC] 2.9.185 PgbOffsetFrom
/// The PgbOffsetFrom enumeration is used to specify the location from which the offset of a page border is measured.
public enum PgbOffsetFrom: UInt8 {
    /// pgbFromText 0x0 The offset of the page border is measured from the text.
    case fromText = 0x0
    
    /// pgbFromEdge 0x1 The offset of the page border is measured from the edge of the page.
    case fromEdge = 0x1
}
