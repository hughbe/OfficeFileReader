//
//  SoundCollectionAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.16.2 SoundCollectionAtom
/// Referenced by: SoundCollectionContainer
/// An atom record that specifies the seed for creating new sound identifiers for sounds in the SoundCollectionContainer record (section 2.4.16.1).
public struct SoundCollectionAtom {
    public let rh: RecordHeader
    public let soundIdSeed: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_SoundCollectionAtom.
        /// rh.recLen MUST be 0x00000004.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .soundCollectionAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000004 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// soundIdSeed (4 bytes): A signed integer that specifies the seed for creating a new sound identifier. It MUST be greater than 0x00000000
        /// and greater than or equal to all sound identifiers specified by the SoundIdAtom records.
        self.soundIdSeed = try dataStream.read(endianess: .littleEndian)
        if self.soundIdSeed < 0x00000000 {
            throw OfficeFileError.corrupted
        }
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
