//
//  PrcData.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.210 PrcData
/// The PrcData structure specifies an array of Prl elements and the size of the array.
public struct PrcData {
    public let cbGrpprl: UInt16
    public let grpPrl: [Prl]
    
    public init(dataStream: inout DataStream) throws {
        /// cbGrpprl (2 bytes): A signed integer that specifies the size of GrpPrl, in bytes. This value MUST be less than or equal to 0x3FA2.
        self.cbGrpprl = try dataStream.read(endianess: .littleEndian)
        if self.cbGrpprl > 0x3FA2 {
            throw OfficeFileError.corrupted
        }
        
        /// GrpPrl (variable): An array of Prl elements. GrpPrl contains a whole number of Prl elements.
        var grpPrl: [Prl] = []
        let startPosition = dataStream.position
        while dataStream.position - startPosition < self.cbGrpprl {
            let prl = try Prl(dataStream: &dataStream)
            grpPrl.append(prl)
        }
        
        self.grpPrl = grpPrl
        
        
        if dataStream.position - startPosition != self.cbGrpprl {
            throw OfficeFileError.corrupted
        }
    }
}
