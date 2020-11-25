//
//  CopyToken.swift
//  
//
//  Created by Hugh Bellamy on 25/11/2020.
//

import DataStream
import BitField

/// [MS-OVBA] 2.4.1.1.8 CopyToken
/// CopyToken is a two-byte record interpreted as an unsigned 16-bit integer in little-endian order. A CopyToken is a compressed encoding of an array of
/// bytes from a DecompressedChunk (section 2.4.1.1.3). The byte array encoded by a CopyToken is a byte-for-byte copy of a byte array elsewhere
/// in the same DecompressedChunk, called a CopySequence (section 2.4.1.3.19).
/// The starting location, in a DecompressedChunk, is determined by the Compressing a Token (section 2.4.1.3.9) and the Decompressing a Token
/// (section 2.4.1.3.5) algorithms. Packed into the CopyToken is the Offset, the distance, in byte count, to the beginning of the CopySequence. Also
/// packed into the CopyToken is the Length, the number of bytes encoded in the CopyToken. Length also specifies the count of bytes in the
/// CopySequence. The values encoded in Offset and Length are computed by the Matching (section 2.4.1.3.19.4) algorithm.
public struct CopyToken: Token {
    /// [MS-OVBA] 2.4.1.3.19.1 CopyToken Help
    /// CopyToken Help derived bit masks are used by the Unpack CopyToken (section 2.4.1.3.19.2) and the Pack CopyToken (section 2.4.1.3.19.3)
    /// algorithms. CopyToken Help also derives the maximum length for a CopySequence (section 2.4.1.3.19) which is used by the Matching algorithm
    /// (section 2.4.1.3.19.4).
    /// The pseudocode uses the state variables described in State Variables (section 2.4.1.2): DecompressedCurrent and DecompressedChunkStart.
    /// The pseudocode for CopyToken Help returns the following output parameters:
    /// LengthMask (2 bytes): An unsigned 16-bit integer. A bitmask used to access CopyToken.Length.
    /// OffsetMask (2 bytes): An unsigned 16-bit integer. A bitmask used to access CopyToken.Offset.
    /// BitCount (2 bytes): An unsigned 16-bit integer. The number of bits set to 0b1 in OffsetMask.
    /// MaximumLength (2 bytes): An unsigned 16-bit integer. The largest possible integral value that can fit into CopyToken.Length.
    private static func copyTokenHelp(token: UInt16) -> (length: UInt16, offsetMask: UInt16, bitCount: UInt16, maximumLength: UInt16) {
        fatalError("NYI")
    }
    
    /// [MS-OVBA] 2.4.1.3.19.2 Unpack CopyToken
    /// The Unpack CopyToken pseudocode will compute the specifications of a CopySequence (section 2.4.1.3.19) that are encoded in a
    /// CopyToken.
    /// The pseudocode for Unpack CopyToken takes the following input parameters:
    /// Token (2 bytes): A CopyToken (section 2.4.1.1.8).
    /// The pseudocode takes the following output parameters:
    /// Offset (2 bytes): An unsigned 16-bit integer that specifies the beginning of a CopySequence (section 2.4.1.3.19).
    /// Length (2 bytes): An unsigned 16-bit integer that specifies the length of a CopySequence (section 2.4.1.3.19) as follows:
    private static func unpack(token: UInt16) -> (offset: UInt16, length: UInt16) {
        //var flags = BitField(rawValue: rawValue)
        fatalError("NYI")
    }
    
    public init(dataStream: inout DataStream) throws {
        //var rawValue: UInt16 = try dataStream.read(endianess: .littleEndian)
        let _: UInt16 = try dataStream.read(endianess: .littleEndian)
        fatalError("NYI")
        
        /// Length (variable): A variable bit unsigned integer that specifies the number of bytes contained in a CopySequence minus three. MUST be
        /// greater than or equal to zero. MUST be less than 4093. The number of bits used to encode Length MUST be greater than or equal to four.
        /// The number of bits used to encode Length MUST be less than or equal to 12. The number of bits used to encode Length is computed and
        /// used in the Unpack CopyToken (section 2.4.1.3.19.2) and the Pack CopyToken (section 2.4.1.3.19.3) algorithms.
        
        /// Offset (variable): A variable bit unsigned integer that specifies the distance, in byte count, from the beginning of a duplicate set of bytes in
        /// the DecompressedBuffer to the beginning of a CopySequence. The value stored in Offset is the distance minus three. MUST be greater than
        /// zero. MUST be less than 4096. The number of bits used to encode Offset MUST be greater than or equal to four. The number of bits used
        /// to encode Offset MUST be less than or equal to 12. The number of bits used to encode Offset is computed and used in the Unpack
        /// CopyToken and the Pack CopyToken algorithms.
    }
    
    public func decompress(to: inout [UInt8]) {
        fatalError("NYI")
    }
}
