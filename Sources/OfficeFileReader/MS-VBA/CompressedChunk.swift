//
//  File.swift
//  
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.4.1.1.4 CompressedChunk
/// A CompressedChunk is a record that encodes all data from a DecompressedChunk (section 2.4.1.1.3) in compressed format. A CompressedChunk
/// has two parts: a CompressedChunkHeader (section 2.4.1.1.5) followed by a CompressedChunkData (section 2.4.1.1.6). The number of bytes
/// in a CompressedChunk MUST be greater than or equal to 3. The number of bytes in a CompressedChunk MUST be less than or equal to 4098.
public struct CompressedChunk {
    public let compressedHeader: CompressedChunkHeader
    public let compressedData: CompressedChunkData
    
    public init(dataStream: inout DataStream) throws {
        /// CompressedHeader (2 bytes): A CompressedChunkHeader. Read by the Decompressing a CompressedChunk algorithm (section 2.4.1.3.2).
        /// Written by the Compressing a DecompressedChunk algorithm (section 2.4.1.3.7).
        self.compressedHeader = try CompressedChunkHeader(dataStream: &dataStream)
        
        /// CompressedData (variable): A CompressedChunkData. The size of CompressedData MUST be greater than zero. The size of
        /// CompressedData MUST be less than or equal to 4096. Read by the Decompressing a CompressedChunk algorithm. Written by the
        /// Compressing a DecompressedChunk.
        self.compressedData = try CompressedChunkData(dataStream: &dataStream, header: self.compressedHeader)
    }
}
