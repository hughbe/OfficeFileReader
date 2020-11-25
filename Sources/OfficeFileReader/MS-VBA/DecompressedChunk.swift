//
//  DecompressedChunk.swift
//  
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-VBA] 2.4.1.1.3 DecompressedChunk
/// A DecompressedChunk is a resizable array of bytes in the DecompressedBuffer (section 2.4.1.1.2). The byte array is the data from a
/// CompressedChunk (section 2.4.1.1.4) in uncompressed format.
public struct DecompressedChunk {
    public let dataStream: DataStream
    
    public init(compressedChunk: CompressedChunk) throws {
        switch compressedChunk.compressedData {
        case .uncompressed(dataStream: let dataStream):
            self.dataStream = dataStream
        case .compressed(tokenSequences: let tokenSequences):
            var data: [UInt8] = []
            for sequence in tokenSequences {
                for token in sequence.tokens {
                    token.decompress(to: &data)
                }
            }
            
            self.dataStream = DataStream(data)
        }
    }
}
