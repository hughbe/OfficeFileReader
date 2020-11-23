//
//  OfficeArtRGFOPTE.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.3.1 OfficeArtRGFOPTE
/// Referenced by: OfficeArtFOPT, OfficeArtSecondaryFOPT, OfficeArtTertiaryFOPT
/// The OfficeArtRGFOPTE record specifies a property table, which consists of an array of fixed-size property table entries, followed by a variable-length
/// field of complex data.
public struct OfficeArtRGFOPTE {
    public let rgfopte: [OfficeArtFOPTE]
    public let complexData: [[UInt8]?]
    
    public init(dataStream: inout DataStream, count: Int) throws {
        /// rgfopte (variable): An array of OfficeArtFOPTE records, as defined in section 2.2.7, that specifies property table entries.
        var rgfopte: [OfficeArtFOPTE] = []
        rgfopte.reserveCapacity(count)
        for _ in 0..<count {
            rgfopte.append(try OfficeArtFOPTE(dataStream: &dataStream))
        }
        
        self.rgfopte = rgfopte
        
        /// complexData (variable): A field of complex data for properties that have the fComplex bit set to 0x1. The complex data is stored
        /// immediately following rgfopte.
        var complexData: [[UInt8]?] = []
        complexData.reserveCapacity(count)
        for element in self.rgfopte {
            if element.opid.fComplex {
                complexData.append(try dataStream.readBytes(count: Int(element.op)))
            } else {
                complexData.append(nil)
            }
        }
        
        self.complexData = complexData
    }
}
