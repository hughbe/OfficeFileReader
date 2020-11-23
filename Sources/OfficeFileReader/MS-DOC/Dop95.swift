//
//  Dop95.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.7.3 Dop95
/// The Dop95 structure contains document and compatibility settings. These settings influence the appearance and behavior of the current document
/// and store document-level state.
public struct Dop95 {
    public let dopBase: DopBase
    public let copts80: Copts80
    
    public init(dataStream: inout DataStream) throws {
        /// dopBase (84 bytes): A DopBase structure that specifies document and compatibility settings.
        self.dopBase = try DopBase(dataStream: &dataStream)
        
        /// copts80 (4 bytes): A copts80 specifying compatibility options. Copts80.copts60 components MUST be equal to DopBase.copts60.
        self.copts80 = try Copts80(dataStream: &dataStream)
    }
}
