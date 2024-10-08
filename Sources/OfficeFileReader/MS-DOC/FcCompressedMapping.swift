//
//  FcCompressedMapping.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

private let unicodeMapping: [UInt8: UInt16] = [
    0x82: 0x201A,
    0x83: 0x0192,
    0x84: 0x201E,
    0x85: 0x2026,
    0x86: 0x2020,
    0x87: 0x2021,
    0x88: 0x02C6,
    0x89: 0x2030,
    0x8A: 0x0160,
    0x8B: 0x2039,
    0x8C: 0x0152,
    0x91: 0x2018,
    0x92: 0x2019,
    0x93: 0x201C,
    0x94: 0x201D,
    0x95: 0x2022,
    0x96: 0x2013,
    0x97: 0x2014,
    0x98: 0x02DC,
    0x99: 0x2122,
    0x9A: 0x0161,
    0x9B: 0x203A,
    0x9C: 0x0153,
    0x9F: 0x0178,
]

internal extension DataStream {
    mutating func readCompressedString(count: Int) throws -> String {
        var s = ""
        s.reserveCapacity(Int(count))
        
        for _ in 0..<count {
            let byte: UInt8 = try read()
            if byte < 0x80 {
                s.append(Character(Unicode.Scalar(byte)))
            } else if let char = unicodeMapping[byte] {
                s.append(Character(Unicode.Scalar(char)!))
            } else {
                s.append(Character(Unicode.Scalar(byte)))
            }
        }
        
        return s
    }
}
