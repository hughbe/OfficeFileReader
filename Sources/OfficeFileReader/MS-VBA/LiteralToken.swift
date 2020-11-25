//
//  LiteralToken.swift
//  
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream

/// Tokens (variable): An array of Tokens. Each Token can either be a LiteralToken or a CopyToken as specified by the corresponding bit in FlagByte.
/// A LiteralToken is a copy of one byte, in uncompressed format, from the DecompressedBuffer (section 2.4.1.1.2). A CopyToken is a 2-byte encoding
/// of 3 or more bytes from the DecompressedBuffer. Read by the Decompressing a TokenSequence algorithm. Written by the Compressing a TokenSequence algorithm.
public struct LiteralToken: Token {
    public let value: UInt8
    
    public init(dataStream: inout DataStream) throws {
        self.value = try dataStream.read()
    }
    
    public func decompress(to: inout [UInt8]) {
        to.append(value)
    }
}
