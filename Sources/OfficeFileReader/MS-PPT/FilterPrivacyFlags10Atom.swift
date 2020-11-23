//
//  FilterPrivacyFlags10Atom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.8 FilterPrivacyFlags10Atom
/// Referenced by: PP10DocBinaryTagExtension
/// An atom record that specifies privacy settings.
public struct FilterPrivacyFlags10Atom {
    public let rh: RecordHeader
    public let fRemovePII: Bool
    public let reserved: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_FilterPrivacyFlags10Atom (section 2.13.24).
        /// rh.recLen MUST be 0x00000004.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x00 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .filterPrivacyFlags10Atom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000004 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fRemovePII (1 bit): A bit that specifies whether personally identifiable information is removed when saving the document.
        self.fRemovePII = flags.readBit()
        
        /// reserved (31 bits): MUST be zero and MUST be ignored.
        self.reserved = flags.readRemainingBits()
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
