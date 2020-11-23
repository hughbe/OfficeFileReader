//
//  CMajorityOperand.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.39 CMajorityOperand
/// The CMajorityOperand structure is used by sprmCMajority to specify which character properties of the text to reset to match that of the
/// underlying paragraph style.
public struct CMajorityOperand {
    public let cb: UInt8
    public let grpprl: [Prl]
    
    public init(dataStream: inout DataStream) throws {
        /// cb (1 byte): An unsigned 8-bit integer that specifies the size, in bytes, of grpprl.
        self.cb = try dataStream.read()
        
        /// grpprl (variable): An array of Prl. Specifies character property Sprms which, when combined with default values for non-specified
        /// properties, give a set of character properties to compare against. For a specific set of properties, if the properties of the current text
        /// match those of the combined set, the value for the property is set to that of the current paragraph style (taking style hierarchy into
        /// account.) Details and exceptions are specified in sprmCMajority.
        var grpprl: [Prl] = []
        let startPosition = dataStream.position
        while dataStream.position - startPosition < self.cb {
            grpprl.append(try Prl(dataStream: &dataStream))
        }
        
        if dataStream.position - startPosition != self.cb {
            throw OfficeFileError.corrupted
        }
        
        self.grpprl = grpprl
    }
}
