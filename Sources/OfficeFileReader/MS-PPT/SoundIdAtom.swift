//
//  SoundIdAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.16.6 SoundIdAtom
/// Referenced by: SoundContainer
/// An atom record that specifies the sound identifier for a sound.
public struct SoundIdAtom {
    public let rh: RecordHeader
    public let soundId: String
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x002.
        /// rh.recType MUST be RT_CString (section 2.13.24).
        /// rh.recLen MUST be an even number.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x002 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .cString else {
            throw OfficeFileError.corrupted
        }
        guard (self.rh.recLen % 2) == 0 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// soundId (variable): A UTF-16 Unicode [RFC2781] string representation of the base-10 form of an integer value that specifies the sound
        /// identifier for a sound. The integer value MUST be greater than zero, less than or equal to the seed specified by the SoundCollectionAtom
        /// record and unique within the SoundCollectionContainer record (section 2.4.16.1). The length, in bytes, of the field is specified by rh.recLen.
        self.soundId = try dataStream.readString(count: Int(self.rh.recLen), encoding: .utf16LittleEndian)!
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
