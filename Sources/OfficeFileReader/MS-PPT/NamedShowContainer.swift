//
//  NamedShowContainer.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.6.3 NamedShowContainer
/// Referenced by: NamedShowsContainer
/// A container record that specifies a named show.
public struct NamedShowContainer {
    public let rh: RecordHeader
    public let namedShowNameAtom: NamedShowNameAtom
    public let namedShowSlidesAtom: NamedShowSlidesAtom?
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_NamedShow.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .namedShow else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// namedShowNameAtom (variable): A NamedShowNameAtom record that specifies the name of this named show.
        self.namedShowNameAtom = try NamedShowNameAtom(dataStream: &dataStream)
        if dataStream.position - startPosition != self.rh.recLen {
            self.namedShowSlidesAtom = nil
            return
        }
        
        /// namedShowSlidesAtom (variable): An optional NamedShowSlidesAtom record that specifies the slides in this named show.
        self.namedShowSlidesAtom = try NamedShowSlidesAtom(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
