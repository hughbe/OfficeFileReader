//
//  DofrFsnSpbd.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.60 DofrFsnSpbd
/// The DofrFsnSpbd structure specifies borders and divider (splitter bar) properties for the entire frame set.
public struct DofrFsnSpbd {
    public let dzaSpb: Int32
    public let cvSpb: COLORREF
    public let fNoBorder: Bool
    public let f3DBorder: Bool
    public let fUnused: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// dzaSpb (4 bytes): A signed integer that specifies the width, in twips, of the borders and dividers. This value MUST be between 0 and
        /// 31,680. If this value is 0, the default border size is used.
        let dzaSpb: Int32 = try dataStream.read(endianess: .littleEndian)
        if dzaSpb < 0 || dzaSpb > 31680 {
            throw OfficeFileError.corrupted
        }
        
        self.dzaSpb = dzaSpb
        
        /// cvSpb (4 bytes): A COLORREF that specifies the color of the borders and dividers.
        self.cvSpb = try COLORREF(dataStream: &dataStream)
        
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fNoBorder (1 bit): Specifies whether the frame set has visible borders. If this value is zero, it displays borders. If this value is 1,
        /// it does not.
        self.fNoBorder = flags.readBit()
        
        /// B - f3DBorder (1 bit): Specifies whether the frame set border uses a raised style.
        self.f3DBorder = flags.readBit()
        
        /// fUnused (30 bits): This value MUST be zero and MUST be ignored.
        self.fUnused = flags.readRemainingBits()
    }
}
