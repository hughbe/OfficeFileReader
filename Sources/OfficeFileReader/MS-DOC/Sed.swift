//
//  Sed.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.243 Sed
/// The Sed structure specifies the location of the section properties.
public struct Sed {
    public let fn: UInt16
    public let fcSepx: Int32
    public let fnMpr: UInt16
    public let fcMpr: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// fn (2 bytes): This value is undefined and MUST be ignored.
        self.fn = try dataStream.read(endianess: .littleEndian)
        
        /// fcSepx (4 bytes): A signed integer value that specifies the position in the WordDocument Stream at which a Sepx structure is located.
        self.fcSepx = try dataStream.read(endianess: .littleEndian)
        
        /// fnMpr (2 bytes): This value is undefined and MUST be ignored.
        self.fnMpr = try dataStream.read(endianess: .littleEndian)
        
        /// fcMpr (4 bytes): This value is undefined and MUST be ignored.
        self.fcMpr = try dataStream.read(endianess: .littleEndian)
    }
}
