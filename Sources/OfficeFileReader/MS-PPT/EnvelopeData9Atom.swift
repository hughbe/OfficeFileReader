//
//  EnvelopeData9Atom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.11.4 EnvelopeData9Atom
/// Referenced by: PP9DocBinaryTagExtension
/// An atom record that specifies data for an envelope.
public struct EnvelopeData9Atom {
    public let rh: RecordHeader
    public let data: MsoEnvelopeCLSID
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_EnvelopeData9Atom.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .envelopeData9Atom else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// data (variable): An MsoEnvelopeCLSID ([MS-OSHARED] section 2.3.8.1) that specifies data for an envelope. The length, in bytes, of this field
        /// is specified by rh.recLen.
        self.data = try MsoEnvelopeCLSID(dataStream: &dataStream, size: self.rh.recLen)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
