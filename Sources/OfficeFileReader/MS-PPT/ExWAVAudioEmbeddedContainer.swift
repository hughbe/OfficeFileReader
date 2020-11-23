//
//  ExWAVAudioEmbeddedContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.10.31 ExWAVAudioEmbeddedContainer
/// Referenced by: ExObjListSubContainer
/// A container record that specifies information about embedded WAV audio.
public struct ExWAVAudioEmbeddedContainer {
    public let rh: RecordHeader
    public let exMediaAtom: ExMediaAtom
    public let exWavAudioEmbedded: ExWAVAudioEmbeddedAtom?
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_ExternalWavAudioEmbedded.
        /// rh.recLen MUST be 0x20.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .externalWavAudioEmbedded else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x20 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// exMedia (16 bytes): An ExMediaAtom record (section 2.10.6) that specifies information about the WAV audio.
        self.exMediaAtom = try ExMediaAtom(dataStream: &dataStream)
        
        /// exWavAudioEmbedded (16 bytes): An ExWAVAudioEmbeddedAtom record that specifies information about an embedded WAV audio in
        /// the SoundCollectionContainer record (section 2.4.16.1).
        self.exWavAudioEmbedded = try ExWAVAudioEmbeddedAtom(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
