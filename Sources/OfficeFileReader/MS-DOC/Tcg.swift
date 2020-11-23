//
//  Tcg.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.315 Tcg
/// The Tcg structure specifies command-related customizations.
public struct Tcg {
    public let nTcgVer: Int8
    public let tcg: Tcg255
    
    public init(dataStream: inout DataStream) throws {
        /// nTcgVer (1 byte): A signed integer that specifies the version of the structure. This value MUST be 255.
        self.nTcgVer = try dataStream.read()
        if self.nTcgVer != -1 {
            throw OfficeFileError.corrupted
        }
        
        /// tcg (variable): A Tcg255 structure, as specified following.
        self.tcg = try Tcg255(dataStream: &dataStream)
    }
}
