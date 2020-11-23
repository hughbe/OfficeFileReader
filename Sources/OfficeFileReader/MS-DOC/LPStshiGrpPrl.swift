//
//  LPStshiGrpPrl.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.137 LPStshiGrpPrl
/// The LPStshiGrpPrl structure specifies an array of formatting properties.
public struct LPStshiGrpPrl {
    public let cbGrpprl: Int32
    public let grpprl: [Prl]
    
    public init(dataStream: inout DataStream) throws {
        /// cbGrpprl (4 bytes): A signed 32-bit integer that specifies the size, in bytes, of grpprl.
        self.cbGrpprl = try dataStream.read(endianess: .littleEndian)
        
        /// grpprl (variable): An array of Prl elements that specify formatting properties.
        var grpprl: [Prl] = []
        let startPosition = dataStream.position
        while dataStream.position - startPosition < self.cbGrpprl {
            grpprl.append(try Prl(dataStream: &dataStream))
        }
        
        self.grpprl = grpprl
        
        if dataStream.position - startPosition != self.cbGrpprl {
            throw OfficeFileError.corrupted
        }
    }
}
