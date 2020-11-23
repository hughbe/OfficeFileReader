//
//  LPUpxRm.swift
//
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.139 LPUpxChpxRM
/// The LPUpxChpxRM structure that specifies character formatting properties for revision-marked style formatting.
/// The structure is padded to an even length.
public struct LPUpxChpxRM {
    public let cbUpx: UInt16
    public let chpx: UpxChpx
    
    public init(dataStream: inout DataStream) throws {
        /// cbUpx (2 bytes): An unsigned integer that specifies the length, in bytes, of CHPX. This value MUST NOT include padding.
        self.cbUpx = try dataStream.read(endianess: .littleEndian)
        
        /// CHPX (variable): A UpxChpx that specifies character formatting properties.
        self.chpx = try UpxChpx(dataStream: &dataStream, size: Int(self.cbUpx))
    }
}
