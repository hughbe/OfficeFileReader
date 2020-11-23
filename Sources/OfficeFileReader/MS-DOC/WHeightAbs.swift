//
//  WHeightAbs.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.345 WHeightAbs
/// The WHeightAbs structure specifies the frame height.
public struct WHeightAbs {
    public let dyaHeightAbs: YAS_nonNeg
    public let fMinHeight: Bool
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// DyaHeightAbs (15 bits): A YAS_nonNeg value that specifies frame height. If this value is 0x0000, the frame height is automatically
        /// determined based on the height of its contents.
        self.dyaHeightAbs = try YAS_nonNeg(value: flags.readBits(count: 15))
        
        /// A - fMinHeight (1 bit): A bit that specifies whether DyaHeightAbs specifies minimum frame height. The DyaHeightAbs MUST NOT
        /// be 0x0000 when fMinHeight is set.
        self.fMinHeight = flags.readBit()
        if self.fMinHeight && self.dyaHeightAbs.value == 0x0000 {
            throw OfficeFileError.corrupted
        }
    }
}
