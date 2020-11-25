//
//  CompressedContainer.swift
//  
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.4.1.1.1 CompressedContainer
/// A CompressedContainer is an array of bytes holding the compressed data. The Decompression algorithm (section 2.4.1.3.1) processes a
/// CompressedContainer to populate a DecompressedBuffer. The Compression algorithm (section 2.4.1.3.6) processes a DecompressedBuffer to
/// produce a CompressedContainer.
/// A CompressedContainer MUST be the last array of bytes in a stream. On read, the end of stream indicator determines when the entire
/// CompressedContainer has been read.
/// The CompressedContainer is a SignatureByte followed by array of CompressedChunk (section 2.4.1.1.4) structures.
public struct CompressedContainer {
    public let signatureByte: UInt8
    public let chunks: [CompressedChunk]
    
    public init(dataStream: inout DataStream, count: Int) throws {
        let startPosition = dataStream.position

        /// SignatureByte (1 byte): Specifies the beginning of the CompressedContainer. MUST be 0x01. The Decompression algorithm (section
        /// 2.4.1.3.1) reads SignatureByte. The Compression algorithm (section 2.4.1.3.6) writes SignatureByte.
        self.signatureByte = try dataStream.read()
        guard self.signatureByte == 0x01 else {
            throw OfficeFileError.corrupted
        }
        
        /// Chunks (variable): An array of CompressedChunk (section 2.4.1.1.4) records. Specifies the compressed data. Read by the Decompression
        /// algorithm. Written by the Compression algorithm.
        var chunks: [CompressedChunk] = []
        while dataStream.position - startPosition < count {
            chunks.append(try CompressedChunk(dataStream: &dataStream))
        }
        
        self.chunks = chunks
    }
}
