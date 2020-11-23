//
//  AntiMoniker.swift
//  
//
//  Created by Hugh Bellamy on 10/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.7.4 AntiMoniker
/// Referenced by: HyperlinkMoniker
/// This structure specifies an anti-moniker. An anti-moniker acts as the inverse of any moniker it is composed onto, effectively canceling out that
/// moniker. In a composite moniker, anti-monikers are used to cancel out existing moniker elements, because monikers cannot be removed from
/// a composite moniker. For more information about anti-monikers, see [MSDN-IMAMI].
public struct AntiMoniker {
    public let count: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// count (4 bytes): An unsigned integer that specifies the number of anti-monikers that have been composed together to create this instance.
        /// When an anti-moniker is composed with another antimoniker, the resulting composition would have a count field equaling the sum of the
        /// two count fields of the composed anti-monikers. This value MUST be less than or equal to 1048576.
        self.count = try dataStream.read(endianess: .littleEndian)
        if self.count > 1048576 {
            throw OfficeFileError.corrupted
        }
    }
}
