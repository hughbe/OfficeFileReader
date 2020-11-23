//
//  ExWAVAudioLinkContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.10.33 ExWAVAudioLinkContainer
/// Referenced by: ExObjListSubContainer
/// A container record that specifies information about external WAV audio.
public struct ExWAVAudioLinkContainer {
    public let rh: RecordHeader
    public let exMediaAtom: ExMediaAtom
    public let audioFilePathAtom: UncOrLocalPathAtom?
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_ExternalWavAudioLink.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .externalWavAudioLink else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// exMedia (16 bytes): An ExMediaAtom record (section 2.10.6) that specifies information about the external WAV audio.
        self.exMediaAtom = try ExMediaAtom(dataStream: &dataStream)
        if dataStream.position - startPosition == self.rh.recLen {
            self.audioFilePathAtom = nil
            return
        }
        
        /// audioFilePathAtom (variable): An optional UncOrLocalPathAtom record that specifies the UNC or local path to a WAV audio file. The length,
        /// in bytes, of the field is specified by the following formula: rh.recLen – 16.
        self.audioFilePathAtom = try UncOrLocalPathAtom(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
