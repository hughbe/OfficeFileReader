//
//  Hplxsdr.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.117 Hplxsdr
/// The Hplxsdr structure contains the schema definition references of the document. Each individual reference consists of a Uniform Resource Identifier (URI),
/// manifest location, table of elements, and table of attributes.
public struct Hplxsdr {
    public let cXSDR: Int32
    public let rgxsdr: [XSDR]
    
    public init(dataStream: inout DataStream) throws {
        /// cXSDR (4 bytes): A signed integer that specifies the number of schema definition references. The minimum value is 0.
        self.cXSDR = try dataStream.read(endianess: .littleEndian)
        if self.cXSDR < 0 {
            throw OfficeFileError.corrupted
        }
        
        /// rgxsdr (variable): An array of XSDR.
        var rgxsdr: [XSDR] = []
        rgxsdr.reserveCapacity(Int(self.cXSDR))
        for _ in 0..<self.cXSDR {
            rgxsdr.append(try XSDR(dataStream: &dataStream))
        }
        
        self.rgxsdr = rgxsdr
    }
}
