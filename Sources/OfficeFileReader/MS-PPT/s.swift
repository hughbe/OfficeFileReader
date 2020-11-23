//
//  ExWAVAudioEmbeddedAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.10.32 ExWAVAudioEmbeddedAtom
/// Referenced by: ExWAVAudioEmbeddedContainer
/// An atom record that specifies information about an embedded WAV audio.
public struct ExWAVAudioEmbeddedAtom {
    public let rh: RecordHeader
    public let soundIdRef: SoundIdRef
    public let soundLength: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x1.
        /// rh.recInstance MUST be 0x001.
        /// rh.recType MUST be an RT_ExternalWavAudioEmbeddedAtom.
        /// rh.recLen MUST be 0x00000008.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x1 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x001 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .externalWavAudioEmbeddedAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000008 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// soundIdRef (4 bytes): A SoundIdRef that specifies the value to look up in the SoundCollectionContainer record (section 2.4.16.1) to find the
        /// embedded audio.
        self.soundIdRef = try dataStream.read(endianess: .littleEndian)
        
        /// soundLength (4 bytes): A signed integer that specifies the duration, in milliseconds, for which to play the audio. It MUST be greater than
        /// or equal to 0x00000000.
        self.soundLength = try dataStream.read(endianess: .littleEndian)
        guard self.soundLength >= 0x00000000 else {
            throw OfficeFileError.corrupted
        }
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
