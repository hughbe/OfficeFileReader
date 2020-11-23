//
//  Stdf.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.259 Stdf
/// The Stdf structure specifies general information about the style.
public struct Stdf {
    public let stdfBase: StdfBase
    public let stdfPost2000OrNone: StdfPost2000OrNone
    
    public init(dataStream: inout DataStream, stshif: Stshif) throws {
        /// stdfBase (10 bytes): An StdfBase structure that specifies general information about the style.
        self.stdfBase = try StdfBase(dataStream: &dataStream)
        
        /// StdfPost2000OrNone (8 bytes): An StdfPost2000OrNone that specifies general information about the style.
        self.stdfPost2000OrNone = try StdfPost2000OrNone(dataStream: &dataStream, stshif: stshif)
    }
}
