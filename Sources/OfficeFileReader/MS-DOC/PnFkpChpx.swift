//
//  PnFkpChpx.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.206 PnFkpChpx
/// The PnFkpChpx structure specifies the location in the WordDocument Stream of a ChpxFkp structure.
public struct PnFkpChpx {
    public let pn: UInt32
    public let unused: UInt32
    
    public init(dataStream: inout DataStream) throws {
        let rawValue: UInt32 = try dataStream.read(endianess: .littleEndian)
        
        /// pn (22 bits): An unsigned integer value that specifies the offset in the WordDocument Stream of a ChpxFkp structure. The ChpxFkp
        /// structure begins at an offset of pn * 512.
        self.pn = rawValue & 0b1111111111111111111111
        
        /// unused (10 bits): This value is undefined and MUST be ignored.
        self.unused = (rawValue >> 2) & 0b1111111111
    }
}
