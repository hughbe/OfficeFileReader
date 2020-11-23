//
//  LPUpxChpx.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.138 LPUpxChpx
/// The LPUpxChpx structure specifies character formatting properties. This structure is padded to an even length, but the length in cbUpx
/// MUST NOT include this padding.
public struct LPUpxChpx {
    public let cbUpx: UInt16
    public let chpx: UpxChpx
    
    public init(dataStream: inout DataStream) throws {
        /// cbUpx (2 bytes): An unsigned integer that specifies the size, in bytes, of CHPX. This value does not include the padding.
        self.cbUpx = try dataStream.read(endianess: .littleEndian)
        
        /// CHPX (variable): A UpxChpx that specifies character formatting properties.
        self.chpx = try UpxChpx(dataStream: &dataStream, size: Int(self.cbUpx))
    }
}
