//
//  NamedShowsContainer.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.6.2 NamedShowsContainer
/// Referenced by: DocumentContainer
/// A container record that specifies the named shows.
public struct NamedShowsContainer {
    public let rh: RecordHeader
    public let rgNamedShow: [NamedShowContainer]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_NamedShows.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .namedShows else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// rgNamedShow (variable): An array of NamedShowContainer records that specifies the named shows.
        var rgNamedShow: [NamedShowContainer] = []
        while dataStream.position - startPosition < self.rh.recLen {
            rgNamedShow.append(try NamedShowContainer(dataStream: &dataStream))
        }
        
        self.rgNamedShow = rgNamedShow
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
