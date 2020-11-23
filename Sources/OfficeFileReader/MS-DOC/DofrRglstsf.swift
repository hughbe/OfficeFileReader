//
//  DofrRglstsf.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.62 DofrRglstsf
/// The DofrRglstsf structure specifies the list styles that are used in the document.
public struct DofrRglstsf {
    public let clstsf: Int32
    public let rglstsf: [Lstsf]
    
    public init(dataStream: inout DataStream) throws {
        /// clstsf (4 bytes): A signed integer that specifies the count of the items in rglstsf.
        self.clstsf = try dataStream.read(endianess: .littleEndian)
        
        /// rglstsf (variable): An array of Lstsf that specifies the list styles used in the document.
        var rglstsf: [Lstsf] = []
        rglstsf.reserveCapacity(Int(self.clstsf))
        for _ in 0..<self.clstsf {
            rglstsf.append(try Lstsf(dataStream: &dataStream))
        }
        
        self.rglstsf = rglstsf
    }
}
