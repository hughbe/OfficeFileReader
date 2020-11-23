//
//  FcCompressed.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.73 FcCompressed
/// The FcCompressed structure specifies the location of text in the WordDocument Stream.
public struct FcCompressed {
    public let fc: UInt32
    public let fCompressed: Bool
    public let r1: Bool
    
    public init(dataStream: inout DataStream) throws {
        var rawValue: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)

        /// fc (30 bits): An unsigned integer that specifies an offset in the WordDocument Stream where the text starts. If fCompressed is zero,
        /// the text is an array of 16-bit Unicode characters starting at offset fc. If fCompressed is 1, the text starts at offset fc/2 and is an
        /// array of 8-bit Unicode characters, except for the values which are mapped to Unicode characters as follows.
        /// Byte Unicode Character
        /// 0x82 0x201A
        /// 0x83 0x0192
        /// 0x84 0x201E
        /// 0x85 0x2026
        /// 0x86 0x2020
        /// 0x87 0x2021
        /// 0x88 0x02C6
        /// 0x89 0x2030
        /// 0x8A 0x0160
        /// 0x8B 0x2039
        /// 0x8C 0x0152
        /// 0x91 0x2018
        /// 0x92 0x2019
        /// 0x93 0x201C
        /// 0x94 0x201D
        /// 0x95 0x2022
        /// 0x96 0x2013
        /// 0x97 0x2014
        /// 0x98 0x02DC
        /// 0x99 0x2122
        /// 0x9A 0x0161
        /// 0x9B 0x203A
        /// 0x9C 0x0153
        /// 0x9F 0x0178
        self.fc = rawValue.readBits(count: 30)
        
        /// A - fCompressed (1 bit): A bit that specifies whether the text is compressed.
        self.fCompressed = rawValue.readBit()

        /// B - r1 (1 bit): This bit MUST be zero, and MUST be ignored.
        self.r1 = rawValue.readBit()
    }
}
