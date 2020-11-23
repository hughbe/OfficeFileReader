//
//  PlfCosl.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.196 PlfCosl
/// The PlfCosl structure is a list of COSL that is specified as an array and its associated count of elements. Each element specifies the option set
/// to use for a grammar checker that implements the NLCheck interface. An option set specifies a value for each grammar option.
public struct PlfCosl {
    public let iMac: Int32
    public let rgcosl: [COSL]
    
    public init(dataStream: inout DataStream) throws {
        /// iMac (4 bytes): A signed integer that specifies the number of entries in rgcosl. This value MUST be greater than or equal to zero.
        self.iMac = try dataStream.read(endianess: .littleEndian)
        if self.iMac < 0 {
            throw OfficeFileError.corrupted
        }
        
        /// rgcosl (variable): An array of COSL.
        var rgcosl: [COSL] = []
        rgcosl.reserveCapacity(Int(self.iMac))
        for _ in 0..<self.iMac {
            rgcosl.append(try COSL(dataStream: &dataStream))
        }
        
        self.rgcosl = rgcosl
    }
}
