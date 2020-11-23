//
//  EnvelopeFlags9Atom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.11.3 EnvelopeFlags9Atom
/// Referenced by: PP9DocBinaryTagExtension
/// An atom record that specifies information about an envelope.
public struct EnvelopeFlags9Atom {
    public let rh: RecordHeader
    public let fHasEnvelope: Bool
    public let fEnvelopeVisible: Bool
    public let reserved1: UInt8
    public let fEnvelopeDirty: Bool
    public let reserved2: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_EnvelopeFlags9Atom.
        /// rh.recLen MUST be 0x00000004.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .envelopeFlags9Atom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000004 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)

        /// A - fHasEnvelope (1 bit): A bit that specifies whether an EnvelopeData9Atom record exists in the file.
        self.fHasEnvelope = flags.readBit()
        
        /// B - fEnvelopeVisible (1 bit): A bit that specifies whether the envelope is visible. If the value is TRUE, fHasEnvelope MUST also be TRUE.
        self.fEnvelopeVisible = flags.readBit()
        
        /// C - reserved1 (2 bits): MUST be zero and MUST be ignored.
        self.reserved1 = UInt8(flags.readBits(count: 2))
        
        /// D - fEnvelopeDirty (1 bit): A bit that specifies whether the envelope has been modified since the last time it was sent to the mail client. If the value
        /// is TRUE, fHasEnvelope MUST also be TRUE.
        self.fEnvelopeDirty = flags.readBit()
        
        /// reserved2 (27 bits): MUST be zero and MUST be ignored.
        self.reserved2 = flags.readRemainingBits()
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
