//
//  LFOLVL.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.133 LFOLVL
/// The LFOLVL structure contains information that is used to override the formatting information of a corresponding LVL.
public struct LFOLVL {
    public let iStartAt: Int32
    public let iLvl: UInt32
    public let fStartAt: Bool
    public let fFormatting: Bool
    public let grfhic: grfhic
    public let unused1: UInt16
    public let unused2: UInt8
    public let lvl: LVL?
    
    public init(dataStream: inout DataStream) throws {
        /// iStartAt (4 bytes): If fStartAt is set to 0x1, this is a signed integer that specifies the start-at value that overrides lvlf.iStartAt of the corresponding
        /// LVL. This value MUST be less than or equal to 0x7FFF and MUST be greater than or equal to zero. If both fStartAt and fFormatting are set to
        /// 0x1, or if fStartAt is set to 0x0, this value is undefined and MUST be ignored.
        let iStartAt: Int32 = try dataStream.read(endianess: .littleEndian)
        if iStartAt < 0x1 || iStartAt > 0x7FFF {
            throw OfficeFileError.corrupted
        }
        
        self.iStartAt = iStartAt
        
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// iLvl (4 bits): An unsigned integer that specifies the zero-based level of the list that this overrides. This LFOLVL overrides the LVL that specifies
        /// the level formatting of this level of the LSTF that is specified by the lsid field of the LFO to which this LFOLVL corresponds. This value MUST
        /// be less than or equal to 0x08.
        self.iLvl = flags.readBits(count: 4)
        if self.iLvl > 0x08 {
            throw OfficeFileError.corrupted
        }
        
        /// A - fStartAt (1 bit): A bit that specifies whether this LFOLVL overrides the start-at value of the level.
        self.fStartAt = flags.readBit()
        
        /// B - fFormatting (1 bit): A bit that specifies whether lvl is an LVL that overrides the corresponding LVL.
        self.fFormatting = flags.readBit()
        
        /// grfhic (8 bits): A grfhic that specifies the HTML incompatibilities of the overriding level formatting.
        self.grfhic = OfficeFileReader.grfhic(rawValue: UInt8(flags.readBits(count: 8)))
        
        /// unused1 (15 bits): This MUST be ignored.
        self.unused1 = UInt16(flags.readBits(count: 15))
        
        /// C - unused2 (3 bits): This MUST be ignored.
        self.unused2 = UInt8(flags.readBits(count: 3))
        
        /// lvl (variable): If fFormatting is set to 0x1, this is an LVL that completely overrides the LVL to which this LFOLVL corresponds. If fFormatting is
        /// not set to 0x1, this does not exist
        if self.fFormatting {
            self.lvl = try LVL(dataStream: &dataStream)
        } else {
            self.lvl = nil
        }
    }
}
