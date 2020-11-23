//
//  SoundDataBlob.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.11.29 SoundDataBlob
/// Referenced by: SoundContainer
/// An atom record that specifies audio data for a sound.
public struct SoundDataBlob {
    public let rh: RecordHeader
    public let data: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_SoundDataBlob.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .soundDataBlob else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// data (variable): A structure that specifies WAV or AIFF audio data for a sound. The length, in bytes, of this field is specified by rh.recLen.
        self.data = try dataStream.readBytes(count: Int(self.rh.recLen))
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
