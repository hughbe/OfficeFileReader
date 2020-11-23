//
//  DPCID.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

public struct DPCID {
    public let padding1: UInt16
    public let fSquiggle: Bool
    public let fIgnored: Bool
    public let fSquiggleChanged: Bool
    public let fUnused: UInt32
    public let idpci: IDPCI
    public let idata: UInt32
    public let fcct: FCCT
    public let id: UInt32
    public let padding2: UInt8
    
    public init(dataStream: inout DataStream) throws {
        /// padding1 (2 bytes): Two bytes that are used for padding. This MUST be ignored.
        self.padding1 = try dataStream.read(endianess: .littleEndian)
        
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fSquiggle (1 bit): A bit flag that specifies whether an application is expected to display a squiggle under the region of text denoted
        /// by the bookmark associated with this DPCID. If the region of text is inside the Main Document Part, fSquiggle MUST be 0.
        self.fSquiggle = flags.readBit()
        
        /// B - fIgnored (1 bit): A bit flag that specifies whether the user requested that the flagging of the region of text by the format consistency
        /// checker that is denoted by the bookmark associated with this DPCID be ignored. If the region of text is inside the Main Document Part,
        /// fIgnored MUST be 1.
        self.fIgnored = flags.readBit()
        
        /// C - fSquiggleChanged (1 bit): A bit flag that specifies whether the squiggle under the region of text denoted by the bookmark associated
        /// with this DPCID has recently been changed. If the region of text is inside the Main Document Part, fSquiggleChanged MUST be 1.
        self.fSquiggleChanged = flags.readBit()
        
        /// fUnused (29 bits): This value MUST be 0 and MUST be ignored.
        self.fUnused = flags.readRemainingBits()
        
        /// idpci (4 bytes): An IDPCI that specifies the kind of formatting that the format consistency checker flagged, within the range of text that
        /// is covered by the format consistency-checker bookmark associated with this DPCID. If the range of text is inside the Main Document
        /// Part, idpci MUST be idpciFmt, idpciPapc, or idpciLvl.
        let idpciRaw: UInt32 = try dataStream.read(endianess: .littleEndian)
        guard let idpci = IDPCI(rawValue: idpciRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.idpci = idpci
        
        /// idata (4 bytes): This value is undefined and MUST be ignored.
        self.idata = try dataStream.read(endianess: .littleEndian)
        
        /// fcct (1 byte): An FCCT that contains further information about the format consistency-checker bookmark associated with this DPCID.
        self.fcct = try FCCT(dataStream: &dataStream)
        
        /// id (4 bytes): An unsigned integer that specifies a unique value used to reference the format consistency-checker bookmark associated
        /// with this DPCID. This value MUST be unique for all DPCIDs inside a given SttbfBkmkFcc.
        self.id = try dataStream.read(endianess: .littleEndian)
        
        /// padding2 (1 byte): This value is undefined and MUST be ignored.
        self.padding2 = try dataStream.read()
    }
}

extension DPCID: STTBData {
    public init(dataStream: inout DataStream, size: UInt16, extend: Bool) throws {
        if !extend {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        try self.init(dataStream: &dataStream)
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
