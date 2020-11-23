//
//  TextBookmarkAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.53 TextBookmarkAtom
/// Referenced by: SlideListWithTextSubContainerOrAtom, TextClientDataSubContainerOrAtom
/// An atom record that specifies a range of text that has a bookmark. The length of the range of text is specified by the following formula: end - begin
public struct TextBookmarkAtom {
    public let rh: RecordHeader
    public let end: TextPosition
    public let begin: TextPosition
    public let bookmarkID: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_TextBookmarkAtom.
        /// rh.recLen MUST be 0x0000000C.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .textBookmarkAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x0000000C else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// begin (4 bytes): A TextPosition that specifies the beginning of the bookmarked range.
        self.begin = try TextPosition(dataStream: &dataStream)
        
        /// end (4 bytes): A TextPosition that specifies the end of the bookmarked range. This field MUST be greater than begin and SHOULD<107>
        /// be less than or equal to begin plus 255.
        self.end = try TextPosition(dataStream: &dataStream)
        
        /// bookmarkID (4 bytes): An unsigned integer that specifies a reference to a bookmark identifier. It MUST be the same as the bookmarkID field of
        /// a BookmarkEntityAtom record.
        self.bookmarkID = try dataStream.read(endianess: .littleEndian)

        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
