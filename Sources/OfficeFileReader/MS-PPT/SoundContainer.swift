//
//  SoundContainer.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.16.3 SoundContainer
/// Referenced by: AnimationInfoContainer, SoundCollectionContainer
/// A container record that specifies information about an embedded sound.
public struct SoundContainer {
    public let rh: RecordHeader
    public let soundNameAtom: SoundNameAtom
    public let soundExtensionAtom: SoundExtensionAtom?
    public let soundIdAtom: SoundIdAtom
    public let builtinIdAtom: SoundBuiltinIdAtom?
    public let soundDataBlob: SoundDataBlob
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_Sound.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .sound else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// soundNameAtom (variable): A SoundNameAtom record that specifies the name of the sound.
        self.soundNameAtom = try SoundNameAtom(dataStream: &dataStream)
        
        /// soundExtensionAtom (16 bytes): An optional SoundExtensionAtom record that specifies the format of the audio data.
        let nextAtom1 = try dataStream.peekRecordHeader()
        if nextAtom1.recType == .cString && nextAtom1.recInstance == 0x001 {
            self.soundExtensionAtom = try SoundExtensionAtom(dataStream: &dataStream)
        } else {
            self.soundExtensionAtom = nil
        }
        
        /// soundIdAtom (variable): A SoundIdAtom record that specifies the sound identifier for the sound.
        self.soundIdAtom = try SoundIdAtom(dataStream: &dataStream)
        
        /// builtinIdAtom (variable): An optional SoundBuiltinIdAtom record that specifies an identifier that describes the sound.
        let nextAtom2 = try dataStream.peekRecordHeader()
        if nextAtom2.recType == .cString && nextAtom2.recInstance == 0x003 {
            self.builtinIdAtom = try SoundBuiltinIdAtom(dataStream: &dataStream)
        } else {
            self.builtinIdAtom = nil
        }
        
        /// soundDataBlob (variable): A SoundDataBlob record that specifies the audio data for the sound.
        self.soundDataBlob = try SoundDataBlob(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
