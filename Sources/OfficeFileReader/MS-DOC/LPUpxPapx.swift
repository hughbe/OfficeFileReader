//
//  LPUpxPapx.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.140 LPUpxPapx
/// The LPUpxPapx structure specifies paragraph formatting properties.
/// The structure is padded to an even length, but the length in cbUpx MUST NOT include this padding.
public struct LPUpxPapx {
    public let cbUpx: UInt16
    public let papx: UpxPapx
    
    public init(dataStream: inout DataStream) throws {
        /// cbUpx (2 bytes): An unsigned integer that specifies the size, in bytes, of PAPX, not including the (potential) padding.
        self.cbUpx = try dataStream.read(endianess: .littleEndian)
        
        /// PAPX (variable): A UpxPapx that specifies paragraph formatting properties.
        self.papx = try UpxPapx(dataStream: &dataStream, size: Int(self.cbUpx))
    }
}
