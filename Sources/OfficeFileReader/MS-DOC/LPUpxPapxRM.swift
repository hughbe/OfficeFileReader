//
//  LPUpxRm.swift
//
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.141 LPUpxPapxRM
/// The LPUpxPapxRM structure specifies the paragraph formatting properties that are used for revisionmarked style formatting.
/// The structure is padded to be an even length, but the length in cbUpx MUST NOT include this padding.
public struct LPUpxPapxRM {
    public let cbUpx: UInt16
    public let papx: UpxPapx
    
    public init(dataStream: inout DataStream) throws {
        /// cbUpx (2 bytes): An unsigned 16-bit integer that specifies the size, in bytes, of PAPX. This value does not include any specified
        /// padding.
        self.cbUpx = try dataStream.read(endianess: .littleEndian)
        
        /// PAPX (variable): A UpxPapx that specifies paragraph formatting properties.
        self.papx = try UpxPapx(dataStream: &dataStream, size: Int(self.cbUpx))
    }
}
