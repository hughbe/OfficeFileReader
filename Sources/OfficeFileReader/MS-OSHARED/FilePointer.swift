//
//  FilePointer.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.2.1.5 FilePointer
/// Specifies the offset into the stream or file that is to be read from or written to.
public struct FilePointer {
    public let offset: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// offset (4 bytes): Unsigned integer that specifies the offset into a stream or file.
        self.offset = try dataStream.read(endianess: .littleEndian)
    }
}
