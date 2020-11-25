//
//  File.swift
//  
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.4.1.1.6 CompressedChunkData
/// If CompressedChunkHeader.CompressedChunkFlag (section 2.4.1.1.5) is 0b0, CompressedChunkData contains an array of
/// CompressedChunkHeader.CompressedChunkSize elements plus 3 bytes of uncompressed data.
/// If CompressedChunkHeader CompressedChunkFlag is 0b1, CompressedChunkData contains an array of TokenSequence (section 2.4.1.1.7) elements.
public enum CompressedChunkData {
    case uncompressed(dataStream: DataStream)
    case compressed(tokenSequences: [TokenSequence])
    
    public init(dataStream: inout DataStream, header: CompressedChunkHeader) throws {
        /// Data (variable): An array of bytes. Specifies an encoding of bytes from the DecompressedBuffer (section 2.4.1.1.2). The size of Data in bytes
        /// MUST be CompressedChunk.CompressedChunkHeader.CompressedChunkSize (section 2.4.1.1.4) plus 3. Bytes from the
        /// DecompressedChunk (section 2.4.1.1.3) are encoded and written to Data by the Compressing a DecompressedChunk (section 2.4.1.3.7)
        /// algorithm. Data is read from the CompressedChunk to be decoded and written to the DecompressedChunk by the Decompressing a
        /// CompressedChunk (section 2.4.1.3.2) algorithm.
        var dataDataStream = DataStream(slicing: dataStream, startIndex: dataStream.position, count: Int(header.compressedChunkSize) + 3)
        if header.compressedChunkFlag {
            var tokenSequences: [TokenSequence] = []
            while dataDataStream.position < dataDataStream.count {
                tokenSequences.append(try TokenSequence(dataStream: &dataDataStream))
            }
            
            self = .compressed(tokenSequences: tokenSequences)
        } else {
            self = .uncompressed(dataStream: dataDataStream)
        }
    }
}
