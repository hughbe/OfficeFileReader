//
//  StdfPost2000OrNone.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.262 StdfPost2000OrNone
/// The StdfPost2000OrNone structure specifies general information about a style.
public struct StdfPost2000OrNone {
    public let stdfPost2000: StdfPost2000?
    
    public init(dataStream: inout DataStream, stshif: Stshif) throws {
        /// StdfPost2000 (8 bytes): An StdfPost2000 structure that specifies general information about the style. This field is optional;
        /// Stshif.cbSTDBaseInFile defines whether it is included or not.
        if stshif.cbSTDBaseInFile > 0x000A {
            self.stdfPost2000 = try StdfPost2000(dataStream: &dataStream)
        } else {
            self.stdfPost2000 = nil
        }
    }
}
