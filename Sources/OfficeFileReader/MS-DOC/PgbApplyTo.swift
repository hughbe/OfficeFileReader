//
//  PgbApplyTo.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

/// [MS-DOC] 2.9.184 PgbApplyTo
/// The PgbApplyTo enumeration is used to specify the pages to which a page border applies
public enum PgbApplyTo: UInt8 {
    /// pgbAllPages 0x0 The page border applies to all pages in the section.
    case allPages = 0x0
    
    /// pgbFirstPage 0x1 The page border applies only to the first page of the section.
    case firstPage = 0x1
    
    /// pgbAllButFirst 0x2 The page border applies to all but the first page of the section.
    case allButFirst = 0x2
}
