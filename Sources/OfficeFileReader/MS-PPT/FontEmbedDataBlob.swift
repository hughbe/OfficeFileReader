//
//  FontEmbedDataBlob.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.11.5 FontEmbedDataBlob
/// Referenced by: FontCollectionEntry
/// An atom record that specifies the font data of an embedded font.
public struct FontEmbedDataBlob {
    public let rh: RecordHeader
    public let data: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be greater than or equal to 0x000 and less than or equal to 0x003.
        /// rh.recType MUST be an RT_FontEmbedDataBlob.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance <= 0x003 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .fontEmbedDataBlob else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000044 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// data (variable): A structure that specifies the font data of an embedded font as specified in [EmbedOpen-Type-Format]. The length, in bytes,
        /// of this field is specified by rh.recLen.
        self.data = try dataStream.readBytes(count: Int(self.rh.recLen))
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
