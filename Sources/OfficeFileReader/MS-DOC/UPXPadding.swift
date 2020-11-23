//
//  UPXPadding.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.337 UPXPadding
/// The UPXPadding structure specifies the padding that is used to pad the UpxPapx, UpxChpx, or UpxTapx structure if any of them are an odd
/// number of bytes in length. The number of bytes that are required MUST be written as a zero value.
/// The UpxPapx, UpxChpx, and UpxTapx structures MUST be written as an even length, even if their contents are an odd length.
public struct UPXPadding {
    public let blob: UInt8?
    
    public init(dataStream: inout DataStream, startPosition: Int) throws {
        /// blob (variable): A structure that specifies any padding that is required to pad structures of an odd number of bytes in length so
        /// that they end on an even-byte boundary. It has a size of 1 byte if padding is needed, and 0 bytes if no padding is needed.
        if (dataStream.position - startPosition) % 2 != 0 {
            self.blob = try dataStream.read()
        } else {
            self.blob = nil
        }
    }
}
