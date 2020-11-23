//
//  DCS.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.51 DCS
/// The DCS structure specifies the drop cap properties for a paragraph.
public struct DCS {
    public let fdct: DropCapType
    public let cl: UInt8
    public let reserved: UInt8
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// fdct (3 bits): An integer that specifies the drop cap type. This MUST be one of the following values.
        let fdctRaw = UInt8(flags.readBits(count: 3))
        guard let fdct = DropCapType(rawValue: fdctRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.fdct = fdct
        
        /// cl (5 bits): An unsigned integer that specifies the number of lines to drop. This determines the size of the drop cap letter. The value MUST
        /// be between 1 and 10, inclusive.
        let cl = UInt8(flags.readBits(count: 5))
        if cl < 1 || cl > 10 {
            throw OfficeFileError.corrupted
        }

        self.cl = cl
        
        /// reserved (8 bits): Undefined and MUST be ignored.
        self.reserved = UInt8(flags.readRemainingBits())
    }
    
    /// fdct (3 bits): An integer that specifies the drop cap type. This MUST be one of the following values.
    public enum DropCapType: UInt8 {
        /// 1 Regular drop cap, which is a single letter beginning at the leading edge of the paragraph.
        case regular = 1

        /// 2 A drop cap which is in the margin of the page, outside of the paragraph.
        case inMarginOfPage = 2
    }
}
