//
//  SoundExtensionAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.16.5 SoundExtensionAtom
/// Referenced by: SoundContainer
/// An atom record that specifies the format of the audio data for a sound.
public struct SoundExtensionAtom {
    public let rh: RecordHeader
    public let soundExtension: String
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x001.
        /// rh.recType MUST be RT_CString (section 2.13.24).
        /// rh.recLen MUST be 0x00000008.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x001 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .cString else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000008 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// soundExtension (8 bytes): A UTF-16 Unicode [RFC2781] string that specifies the format of the audio data for a sound. It SHOULD<13>
        /// be a value from the following table.
        /// Value (case-insensitive) Meaning
        /// .wav The format is WAV.
        /// wave The format is WAV.
        /// .aif The format is Audio Interchange File Format (AIFF).
        /// aiff The format is AIFF.
        self.soundExtension = try dataStream.readString(count: Int(self.rh.recLen), encoding: .utf16LittleEndian)!
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
