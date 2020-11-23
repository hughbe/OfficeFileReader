//
//  BookmarkEntityAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.22.7 BookmarkEntityAtom
/// Referenced by: BookmarkEntityAtomContainer
/// An atom record that specifies information used to link the bookmark records in the text itself to the bookmarks in the Summary Information Stream.
public struct BookmarkEntityAtom {
    public let rh: RecordHeader
    public let bookmarkId: UInt32
    public let bookmarkName: String
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_BookmarkEntityAtom.
        /// rh.recLen MUST be 0x00000044.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .bookmarkEntityAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000044 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// bookmarkId (4 bytes): An unsigned integer that specifies this bookmark identifier. It MUST be the same as the bookmarkID field of a
        /// TextBookMarkAtom record.
        self.bookmarkId = try dataStream.read(endianess: .littleEndian)
        
        /// bookmarkName (64 bytes): A char2 that specifies the name of a bookmark. The name MUST NOT be empty. The name SHOULD be the same
        /// as one of the PropertyIdentifierAndOffset.PropertyIdentifier fields, as specified in [MS-OLEPS] section 2.19, in the Summary Information Stream.
        self.bookmarkName = try dataStream.readString(count: 64, encoding: .utf16LittleEndian)!

        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
