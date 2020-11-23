//
//  LSTF.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.147 LSTF
/// The LSTF structure contains formatting properties that apply to an entire list.
public struct LSTF {
    public let lsid: Int32
    public let tplc: Tplc
    public let rgistdPara: (UInt16, UInt16, UInt16, UInt16, UInt16, UInt16, UInt16, UInt16, UInt16)
    public let fSimpleList: Bool
    public let unused1: Bool
    public let fAutoNum: Bool
    public let unused2: Bool
    public let fHybrid: Bool
    public let reserved1: UInt8
    public let grfhic: grfhic
    
    public init(dataStream: inout DataStream) throws {
        /// lsid (4 bytes): A signed integer that specifies the list identifier. This MUST be unique for each LSTF. This value MUST NOT be 0xFFFFFFFF.
        self.lsid = try dataStream.read(endianess: .littleEndian)
        if self.lsid == Int32(bitPattern: 0xFFFFFFFF) {
            throw OfficeFileError.corrupted
        }
        
        /// tplc (4 bytes): A Tplc that specifies a unique identifier for this LSTF that MAY<227> be used for user interface purposes. If fHybrid is nonzero,
        /// this MUST be ignored.
        self.tplc = try Tplc(dataStream: &dataStream)
        
        /// rgistdPara (18 bytes): An array of nine 16-bit signed integers. Each element of rgistdPara specifies the ISTD of the style that is linked to the
        /// corresponding level in the list. If no style is linked to a given level, the value of the corresponding element of rgistdPara MUST be 0x0FFF.
        self.rgistdPara = (
            try dataStream.read(endianess: .littleEndian),
            try dataStream.read(endianess: .littleEndian),
            try dataStream.read(endianess: .littleEndian),
            try dataStream.read(endianess: .littleEndian),
            try dataStream.read(endianess: .littleEndian),
            try dataStream.read(endianess: .littleEndian),
            try dataStream.read(endianess: .littleEndian),
            try dataStream.read(endianess: .littleEndian),
            try dataStream.read(endianess: .littleEndian)
        )
        
        var flags: BitFieldReader<UInt8> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fSimpleList (1 bit): A bit that, when set to 0x1, specifies that this LSTF represents a simple (one-level) list that has one corresponding LVL
        /// (see the fcPlfLst field of FibRgFcLcb97). Otherwise, this LSTF represents a multi-level list that has nine corresponding LVLs.
        self.fSimpleList = flags.readBit()
        
        /// B - unused1 (1 bit): This bit MUST be ignored.
        self.unused1 = flags.readBit()
        
        /// C - fAutoNum (1 bit): A bit that specifies whether the list that this LSTF represents is used for the AUTONUMOUT, AUTONUMLGL, and
        /// AUTONUM fields (see AUTONUMOUT, AUTONUMLGL, and AUTONUM in flt).
        self.fAutoNum = flags.readBit()
        
        /// D - unused2 (1 bit): This bit MUST be ignored.
        self.unused2 = flags.readBit()
        
        /// E - fHybrid (1 bit): A bit that specifies whether the list this LSTF defines is a hybrid list.
        self.fHybrid = flags.readBit()
        
        /// F - reserved1 (3 bits): This MUST be zero, and MUST be ignored.
        self.reserved1 = UInt8(flags.readRemainingBits())
        
        /// grfhic (1 byte): A grfhic that specifies the HTML incompatibilities of the list.
        self.grfhic = try OfficeFileReader.grfhic(dataStream: &dataStream)
    }
}
