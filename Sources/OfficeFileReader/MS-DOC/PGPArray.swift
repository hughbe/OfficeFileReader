//
//  PGPArray.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.187 PGPArray
/// The PGPArray structure is a collection of the PGPInfo entries in the document.
public struct PGPArray {
    public let cpgp: UInt16
    public let pgpInfoArray: [PGPInfo]
    
    public init(dataStream: inout DataStream) throws {
        /// cpgp (2 bytes): The count of PGPInfo entries to read.
        self.cpgp = try dataStream.read(endianess: .littleEndian)
        
        /// pgpInfoArray (variable): An array of PGPInfo structures. This array contains cpgp elements.
        var pgpInfoArray: [PGPInfo] = []
        pgpInfoArray.reserveCapacity(Int(self.cpgp))
        for _ in 0..<self.cpgp {
            pgpInfoArray.append(try PGPInfo(dataStream: &dataStream))
        }
        
        self.pgpInfoArray = pgpInfoArray
    }
}
