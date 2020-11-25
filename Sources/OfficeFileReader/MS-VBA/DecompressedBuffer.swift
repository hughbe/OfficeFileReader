//
//  DecompressedBuffer.swift
//  
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.4.1.1.2 DecompressedBuffer
/// The DecompressedBuffer is a resizable array of bytes that contains the same data as the CompressedContainer (section 2.4.1.1.1), but the data is in
/// an uncompressed format.
public struct DecompressedBuffer {
    public let decompressedChunks: [DecompressedChunk]
    
    public init(container: CompressedContainer) throws {
        var decompressedChunks: [DecompressedChunk] = []
        for compressedChunk in container.chunks {
            decompressedChunks.append(try DecompressedChunk(compressedChunk: compressedChunk))
        }
        
        self.decompressedChunks = decompressedChunks
    }
}
