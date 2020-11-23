//
//  SummaryContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.22.3 SummaryContainer
/// Referenced by: DocumentContainer
/// A container record that specifies bookmark information.
public struct SummaryContainer {
    public let rh: RecordHeader
    public let bookmarkCollection: BookmarkCollectionContainer
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_Summary.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .summary else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// bookmarkCollection (variable): A BookmarkCollectionContainer record that specifies the bookmarks.
        self.bookmarkCollection = try BookmarkCollectionContainer(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
