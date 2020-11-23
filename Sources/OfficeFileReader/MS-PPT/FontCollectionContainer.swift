//
//  FontCollectionContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.8 FontCollectionContainer
/// Referenced by: DocumentTextInfoContainer
/// A container record that specifies information about fonts in the presentation.
public struct FontCollectionContainer {
    public let rh: RecordHeader
    public let rgFontCollectionEntry: [FontCollectionEntry]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_FontCollection.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .fontCollection else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// rgFontCollectionEntry (variable): An array of FontCollectionEntry structures that specifies information about the fonts. The size, in bytes,
        /// of the array is specified by rh.recLen.
        var rgFontCollectionEntry: [FontCollectionEntry] = []
        while dataStream.position - startPosition < self.rh.recLen {
            rgFontCollectionEntry.append(try FontCollectionEntry(dataStream: &dataStream, startPosition: startPosition, size: Int(self.rh.recLen)))
        }
        
        self.rgFontCollectionEntry = rgFontCollectionEntry
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
