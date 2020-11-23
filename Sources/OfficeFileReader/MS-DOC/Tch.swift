//
//  Tch.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.320 Tch
/// The Tch structure is used by PlcfTch and specifies table character information for the CP range.
public struct Tch {
    public let fUnk: Bool
    public let unused: UInt32
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fUnk (1 bit): A bit that specifies that the table character cache for the CP range is unknown. If fUnk is set, unused MUST be ignored.
        self.fUnk = flags.readBit()
        
        /// unused (31 bits): A bit field that specifies information for the CP range. This value SHOULD<263> be zero and SHOULD be ignored.
        self.unused = flags.readRemainingBits()
    }
}
