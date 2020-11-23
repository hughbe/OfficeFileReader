//
//  LpStd.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.135 LPStd
/// The LPStd structure specifies a length-prefixed style definition.
public struct LpStd {
    public let cbStd: Int16
    public let std: STD?
    
    public init(dataStream: inout DataStream, stshif: Stshif) throws {
        /// cbStd (2 bytes): A signed integer that specifies the size, in bytes, of std. This value MUST NOT be less than 0. LPStd structures are
        /// stored on even-byte boundaries, but this length MUST NOT include this padding.
        /// A style definition can be empty, in which case cbStd MUST be 0.
        self.cbStd = try dataStream.read(endianess: .littleEndian)
        if self.cbStd < 0 {
            throw OfficeFileError.corrupted
        }
        
        /// std (variable): An STD that specifies the style definition.
        let startPosition = dataStream.position
        if self.cbStd > 0 {
            self.std = try STD(dataStream: &dataStream, stshif: stshif, size: Int(self.cbStd))
        } else {
            self.std = nil
        }
        
        if dataStream.position - startPosition != self.cbStd {
            throw OfficeFileError.corrupted
        }
    }
}
