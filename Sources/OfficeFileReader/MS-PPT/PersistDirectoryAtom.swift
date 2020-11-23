//
//  PersistDirectoryAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.3.4 PersistDirectoryAtom
/// An atom record that specifies a persist object directory. Each persist object identifier specified MUST be unique in that persist object directory.
public struct PersistDirectoryAtom {
    public let rh: RecordHeader
    public let rgPersistDirEntry: [PersistDirectoryEntry]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_PersistDirectoryAtom (section 2.13.24).
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .persistDirectoryAtom else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// rgPersistDirEntry (variable): An array of PersistDirectoryEntry structures (section 2.3.5) that specifies persist object identifiers and stream
        /// offsets to persist objects. The size, in bytes, of the array is specified by rh.recLen.
        var rgPersistDirEntry: [PersistDirectoryEntry] = []
        while dataStream.position - startPosition < self.rh.recLen {
            rgPersistDirEntry.append(try PersistDirectoryEntry(dataStream: &dataStream))
        }
        
        self.rgPersistDirEntry = rgPersistDirEntry
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
