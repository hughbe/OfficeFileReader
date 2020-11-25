//
//  CompressedChunkHeader.swift
//  
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.4.1.1.5 CompressedChunkHeader
/// A CompressedChunkHeader is the first record in a CompressedChunk (section 2.4.1.1.4). A CompressedChunkHeader specifies the size of the entire
/// CompressedChunk and the data encoding format in CompressedChunk.CompressedData. CompressedChunkHeader information is used by the
/// Decompressing a CompressedChunk (section 2.4.1.3.2) and Compressing a DecompressedChunk (section 2.4.1.3.7) algorithms.
public struct CompressedChunkHeader {
    public let compressedChunkSize: UInt16
    public let compressedChunkSignature: UInt8
    public let compressedChunkFlag: Bool
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)

        /// CompressedChunkSize (12 bits): An unsigned integer that specifies the number of bytes in the CompressedChunk minus 3. MUST be
        /// greater than or equal to zero. If CompressedChunkFlag is equal to 0b1, this element MUST be less than or equal to 4095. If
        /// CompressedChunkFlag is equal to 0b0, this element MUST be 4095. Read by the Extract CompressedChunkSize (section
        /// 2.4.1.3.12) algorithm. Written by the Pack CompressedChunkSize (section 2.4.1.3.13) algorithm.
        self.compressedChunkSize = flags.readBits(count: 12)
        
        /// A – CompressedChunkSignature (3 bits): MUST be 0b011. Written by the Pack CompressedChunkSignature (section 2.4.1.3.14) algorithm.
        self.compressedChunkSignature = UInt8(flags.readBits(count: 3))
        guard self.compressedChunkSignature == 0b011 else {
            throw OfficeFileError.corrupted
        }
        
        /// B – CompressedChunkFlag (1 bit): A bit specifying how CompressedChunk.CompressedData is compressed. If this is 0b1,
        /// CompressedChunk.CompressedData is in compressed format. If this is 0b0, CompressedChunk.CompressedData contains uncompressed
        /// data. Read by the Extract CompressedChunkFlag (section 2.4.1.3.15) algorithm. Written by the Pack CompressedChunkFlag
        /// (section 2.4.1.3.16) algorithm.
        self.compressedChunkFlag = flags.readBit()
        guard (self.compressedChunkFlag && self.compressedChunkSize <= 4095) ||
                (!self.compressedChunkFlag && self.compressedChunkSize == 4095) else {
            throw OfficeFileError.corrupted
        }
    }
}
