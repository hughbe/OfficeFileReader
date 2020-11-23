//
//  BookmarkEntityAtomContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.22.6 BookmarkEntityAtomContainer
/// Referenced by: BookmarkCollectionContainer
/// A container record that specifies information about a bookmark.
public struct BookmarkEntityAtomContainer {
    public let rh: RecordHeader
    public let bookmarkEntityAtom: BookmarkEntityAtom
    public let bookmarkValueAtom: BookmarkValueAtom
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recType MUST be RT_BookmarkEntityAtom.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .bookmarkEntityAtom else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// bookmarkEntityAtom (76 bytes): A BookMarkEntityAtom record that specifies how to link text to a bookmark.
        self.bookmarkEntityAtom = try BookmarkEntityAtom(dataStream: &dataStream)
        
        /// bookmarkValueAtom (variable): A BookmarkValueAtom record that specifies the text value of the bookmark. This field MUST be the same
        /// as the text referred to by the associated TextBookMarkAtom record referred to by the bookmarkId field of the bookmarkEntityAtom in
        /// this record.
        self.bookmarkValueAtom = try BookmarkValueAtom(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
