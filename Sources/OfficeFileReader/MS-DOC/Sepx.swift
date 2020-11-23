//
//  Sepx.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

public struct Sepx {
    public let cb: Int16
    public let grpprl: [Prl]
    
    public init(dataStream: inout DataStream) throws {
        /// cb (2 bytes): A signed integer that specifies the size of grpprl, in bytes.
        self.cb = try dataStream.read(endianess: .littleEndian)
        
        /// grpprl (variable): An array of Prl structures that specify the properties of a section. This array MUST contain a whole number of Prl structures.
        let startPosition = dataStream.position
        var grpprl: [Prl] = []
        while dataStream.position - startPosition < self.cb {
            grpprl.append(try Prl(dataStream: &dataStream))
        }
        
        self.grpprl = grpprl
        
        if dataStream.position - startPosition != self.cb {
            throw OfficeFileError.corrupted
        }
    }
}
