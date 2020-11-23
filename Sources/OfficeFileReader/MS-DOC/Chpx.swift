//
//  Chpx.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.32 Chpx
/// The Chpx structure specifies a set of properties for text.
public struct Chpx {
    public let cb: UInt8
    public let grpprl: [Prl]
    
    public init(dataStream: inout DataStream) throws {
        /// cb (1 byte): An unsigned integer that specifies the size of grpprl, in bytes.
        self.cb = try dataStream.read()
        
        var grpprl: [Prl] = []
        let startPosition = dataStream.position
        while dataStream.position - startPosition < self.cb {
            grpprl.append(try Prl(dataStream: &dataStream))
        }
        
        self.grpprl = grpprl
        
        if dataStream.position - startPosition != self.cb {
            throw OfficeFileError.corrupted
        }
    }
}
