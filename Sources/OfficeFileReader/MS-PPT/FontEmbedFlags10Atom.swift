//
//  FontEmbedFlags10Atom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.12 FontEmbedFlags10Atom
/// Referenced by: PP10DocBinaryTagExtension
/// An atom record that specifies information about how font data is embedded.
public struct FontEmbedFlags10Atom {
    public let rh: RecordHeader
    public let fSubset: Bool
    public let fSubsetOptionConfirmed: Bool
    public let unused: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_FontEmbedFlags10Atom.
        /// rh.recLen MUST be 0x00000004.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x00 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .fontEmbedFlags10Atom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000004 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fSubset (1 bit): A bit that specifies whether embedded fonts contain data for only those characters in use.
        self.fSubset = flags.readBit()
        
        /// B - fSubsetOptionConfirmed (1 bit): A bit that specifies whether the user has confirmed the choice of fSubset in the user interface.
        self.fSubsetOptionConfirmed = flags.readBit()
        
        /// unused (30 bits): Undefined and MUST be ignored.
        self.unused = flags.readRemainingBits()
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
