//
//  FACTOIDINFO.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.66 FACTOIDINFO
/// The FACTOIDINFO structure contains information about a smart tag bookmark in the document.
public struct FACTOIDINFO {
    public let dwId: UInt32
    public let fSubEntity: Bool
    public let fUnused: UInt16
    public let fto: FTO
    public let pfpb: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// dwId (4 bytes): An unsigned integer that specifies a unique value this is used to reference the smart tag bookmark associated with this
        /// FACTOIDINFO. This MUST be unique for all FACTOIDINFO structures in all Document Parts.
        self.dwId = try dataStream.read(endianess: .littleEndian)
        
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fSubEntity (1 bit): A bit flag that specifies whether the factoid that is marked by the smart tag bookmark associated with this
        /// FACTOIDINFO structure is a sub-entity of a larger smart tag from the grammar checker.
        self.fSubEntity = flags.readBit()
        
        /// fUnused (15 bits): This field MUST be ignored.
        self.fUnused = flags.readRemainingBits()
        
        /// fto (2 bytes): An FTO specifying further information about the smart tag bookmark that is associated with this FACTOIDINFO.
        let ftoRaw: UInt16 = try dataStream.read(endianess: .littleEndian)
        guard let fto = FTO(rawValue: ftoRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.fto = fto
        
        /// pfpb (4 bytes): This field MUST be ignored.
        self.pfpb = try dataStream.read(endianess: .littleEndian)
    }
}

extension FACTOIDINFO: STTBData {
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
