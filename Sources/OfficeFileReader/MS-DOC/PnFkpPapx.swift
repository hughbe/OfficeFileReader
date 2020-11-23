//
//  PnFkpPapx.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.207 PnFkpPapx
/// The PnFkpPapx structure specifies the offset of a PapxFkp in the WordDocument Stream.
public struct PnFkpPapx {
    public let pn: UInt32
    public let unused: UInt32
    
    public init(dataStream: inout DataStream) throws {
        let rawValue: UInt32 = try dataStream.read(endianess: .littleEndian)
        
        /// pn (22 bits): An unsigned integer that specifies the offset in the WordDocument Stream of a PapxFkp structure.
        /// The PapxFkp structure begins at an offset of pn×512.
        self.pn = rawValue & 0b1111111111111111111111
        
        /// unused (10 bits): This value is undefined and MUST be ignored.
        self.unused = (rawValue >> 2) & 0b1111111111
    }
}
