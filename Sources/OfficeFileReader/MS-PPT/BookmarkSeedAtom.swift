//
//  BookmarkSeedAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.22.5 BookmarkSeedAtom
/// Referenced by: BookmarkCollectionContainer
/// An atom record that specifies the seed value to use when creating new bookmark identifiers.
public struct BookmarkSeedAtom {
    public let rh: RecordHeader
    public let bookmarkIdSeed: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x002.
        /// rh.recType MUST be RT_BookmarkSeedAtom.
        /// rh.recLen MUST be 0x00000004.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x002 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .bookmarkSeedAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000004 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// bookmarkIdSeed (4 bytes): An unsigned integer that specifies a seed for creating a new bookmark identifier. It MUST be greater than all
        /// existing bookmark identifier values specified by the bookmarkID field of the BookmarkEntityAtom records and the bookmarkID field of the
        /// TextBookMarkAtom records.
        self.bookmarkIdSeed = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
