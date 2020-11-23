//
//  BlockSel.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.13 BlockSel
/// The BlockSel structure is used by Selsf to specify the left and right boundaries of a text block selection. The values are pixels at the zoom level in which
/// the selection was made.
public struct BlockSel {
    public let zpFirst: Int16
    public let zpLim: Int16
    
    public init(dataStream: inout DataStream) throws {
        /// zpFirst (2 bytes): A signed integer that specifies the physical left boundary of the selection, in pixels. The physical left page margin is at pixel zero.
        self.zpFirst = try dataStream.read(endianess: .littleEndian)
        
        /// zpLim (2 bytes): A signed integer that specifies the physical right boundary of the selection, in pixels. zpLim MUST be greater than or
        /// equal to zpFirst.
        self.zpLim = try dataStream.read(endianess: .littleEndian)
        if self.zpLim < self.zpFirst {
            throw OfficeFileError.corrupted
        }
    }
}
