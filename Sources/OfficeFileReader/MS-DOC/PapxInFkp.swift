//
//  PapxInFkp.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.175 PapxInFkp
/// The PapxInFkp structure specifies a set of text properties.
public struct PapxInFkp {
    public let cb: UInt8
    public let grpprlInPapx: GrpPrlAndIstd
    
    public init(dataStream: inout DataStream) throws {
        /// cb (1 byte): An unsigned integer that specifies the size of the grpprlInPapx. If this value is not 0, the grpprlInPapx is 2×cb-1 bytes long.
        /// If this value is 0, the size is specified by the first byte of grpprlInPapx.
        self.cb = try dataStream.read()
        
        /// grpprlInPapx (variable): If cb is 0, the first byte of grpprlInPapx (call it cb') is an unsigned integer that specifies the size of the rest of
        /// grpprlInPapx. cb' MUST be at least 1. After cb', there are 2×cb' more bytes in grpprlInPapx. The bytes after cb' form a GrpPrlAndIstd.
        /// If cb is nonzero, grpprlInPapx is GrpPrlAndIstd.
        if self.cb == 0 {
            let cb: UInt8 = try dataStream.read()
            self.grpprlInPapx = try GrpPrlAndIstd(dataStream: &dataStream, size: 2 * UInt16(cb))
        } else {
            self.grpprlInPapx = try GrpPrlAndIstd(dataStream: &dataStream, size: (2 * UInt16(cb)) - 1)
        }
    }
}
