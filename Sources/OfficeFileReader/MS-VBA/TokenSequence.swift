//
//  TokenSequence.swift
//  
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// [MS-OVBA] 2.4.1.1.7 TokenSequence
/// A TokenSequence is a FlagByte followed by an array of Tokens. The number of Tokens in the final TokenSequence MUST be greater than or equal to 1.
/// The number of Tokens in the final TokenSequence MUST less than or equal to eight. All other TokenSequences in the CompressedChunkData MUST
/// contain eight Tokens.
public struct TokenSequence {
    public let flagByte: UInt8
    public let tokens: [Token]
    
    public init(dataStream: inout DataStream) throws {
        /// FlagByte (1 byte): An array of bits. Each bit specifies the type of a Token in the TokenSequence. A value of 0b0 specifies a LiteralToken.
        /// A value of 0b1 specifies a CopyToken (section 2.4.1.1.8). The least significant bit in the FlagByte denotes the first Token in the
        /// TokenSequence. The most significant bit in the FlagByte denotes the last Token in the TokenSequence. The correspondence between a
        /// FlagByte element and a Token element is maintained by the Decompressing a TokenSequence (section 2.4.1.3.4) and the Compressing
        /// a TokenSequence (section 2.4.1.3.8) algorithms.
        var flags: BitFieldReader<UInt8> = try dataStream.readBits(endianess: .littleEndian)
        self.flagByte = flags.rawValue
        
        /// Tokens (variable): An array of Tokens. Each Token can either be a LiteralToken or a CopyToken as specified by the corresponding bit in
        /// FlagByte. A LiteralToken is a copy of one byte, in uncompressed format, from the DecompressedBuffer (section 2.4.1.1.2). A CopyToken
        /// is a 2- byte encoding of 3 or more bytes from the DecompressedBuffer. Read by the Decompressing a TokenSequence algorithm. Written
        /// by the Compressing a TokenSequence algorithm.
        var tokens: [Token] = []
        for _ in 0..<8 {
            if flags.readBit() {
                tokens.append(try CopyToken(dataStream: &dataStream))
            } else {
                tokens.append(try LiteralToken(dataStream: &dataStream))
            }
        }
        
        self.tokens = tokens
    }
}
