//
//  BookmarkCollectionContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.22.4 BookmarkCollectionContainer
/// Referenced by: SummaryContainer
/// A container record that specifies a collection of bookmarks
public struct BookmarkCollectionContainer {
    public let rh: RecordHeader
    public let bookmarkSeedAtom: BookmarkSeedAtom
    public let rgBookmarkEntity: [BookmarkEntityAtomContainer]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_BookmarkCollection.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .bookmarkCollection else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// bookmarkSeedAtom (12 bytes): A BookmarkSeedAtom record that specifies the identifier to use when creating a new bookmark.
        self.bookmarkSeedAtom = try BookmarkSeedAtom(dataStream: &dataStream)
        
        /// rgBookmarkEntity (variable): An array of BookmarkEntityAtomContainer records that specifies the bookmarks. The size, in bytes, of the
        /// array is specified by the following formula: rh.recLen – 12
        var rgBookmarkEntity: [BookmarkEntityAtomContainer] = []
        while dataStream.position - startPosition < self.rh.recLen {
            rgBookmarkEntity.append(try BookmarkEntityAtomContainer(dataStream: &dataStream))
        }
        
        self.rgBookmarkEntity = rgBookmarkEntity
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
