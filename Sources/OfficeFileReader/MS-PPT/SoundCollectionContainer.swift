//
//  SoundCollectionContainer.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.16.1 SoundCollectionContainer
/// Referenced by: DocumentContainer
/// A container record that specifies all embedded sounds in the document.
public struct SoundCollectionContainer {
    public let rh: RecordHeader
    public let soundCollectionAtom: SoundCollectionAtom
    public let rgSoundContainer: [SoundContainer]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x005.
        /// rh.recType MUST be RT_SoundCollection.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        if self.rh.recInstance != 0x005 {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .soundCollection else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// soundCollectionAtom (12 bytes): A SoundCollectionAtom record that specifies the seed for creating new sound identifiers for sounds
        /// in this collection.
        self.soundCollectionAtom = try SoundCollectionAtom(dataStream: &dataStream)
        
        /// rgSoundContainer (variable): An array of SoundContainer records (section 2.4.16.3) that specifies the embedded sounds. The length,
        /// in bytes, of the array is specified by the following formula:
        /// rh.recLen - 12.
        var rgSoundContainer: [SoundContainer] = []
        while dataStream.position - startPosition < self.rh.recLen {
            rgSoundContainer.append(try SoundContainer(dataStream: &dataStream))
        }
        
        self.rgSoundContainer = rgSoundContainer
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
