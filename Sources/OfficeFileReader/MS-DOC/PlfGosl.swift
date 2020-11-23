//
//  PlfGosl.swift
//
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.197 PlfGosl
/// The PlfGosl structure is a list of GOSL structures that are specified as an array, and its associated count of elements. Each element specifies the
/// option set to use for a grammar checker that implements the CGAPI interface. An option set specifies a value for each grammar option.
public struct PlfGosl {
    public let iMac: Int32
    public let rggosl: [GOSL]
    
    public init(dataStream: inout DataStream) throws {
        /// iMac (4 bytes): A signed integer that represents the count of entries in rgcosl. This value MUST be greater than or equal to zero.
        self.iMac = try dataStream.read(endianess: .littleEndian)
        if self.iMac < 0 {
            throw OfficeFileError.corrupted
        }
        
        /// rggosl (variable): An array of GOSL structures.
        var rggosl: [GOSL] = []
        rggosl.reserveCapacity(Int(self.iMac))
        for _ in 0..<self.iMac {
            rggosl.append(try GOSL(dataStream: &dataStream))
        }
        
        self.rggosl = rggosl
    }
}
