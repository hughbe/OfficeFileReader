//
//  HTMLPublishInfo9Container.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.18.2 HTMLPublishInfo9Container
/// Referenced by: PP9DocBinaryTagExtension
/// A container record that specifies additional information for how to publish a document as a Web page.
public struct HTMLPublishInfo9Container {
    public let rh: RecordHeader
    public let fileNameAtom: FileNameAtom
    public let namedShowAtom: NamedShowAtom?
    public let htmlPublishInfoAtom: HTMLPublishInfoAtom
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_HTMLPublishInfo9 (section2.13.24).
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .htmlPublishInfo9 else {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position
        
        /// fileNameAtom (variable): A FileNameAtom record that specifies the file name.
        self.fileNameAtom = try FileNameAtom(dataStream: &dataStream)
        
        /// namedShowAtom (variable): An optional NamedShowAtom record that specifies the named show being published. It MUST exist if the
        /// htmlPublishInfoAtom.fUseNamedShowX field is set to TRUE.
        if try dataStream.peekRecordHeader().recType == .namedShow {
            self.namedShowAtom = try NamedShowAtom(dataStream: &dataStream)
        } else {
            self.namedShowAtom = nil
        }
        
        /// htmlPublishInfoAtom (20 bytes): A HTMLPublishInfoAtom record that specifies the settings for publishing the document.
        self.htmlPublishInfoAtom = try HTMLPublishInfoAtom(dataStream: &dataStream)
                
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
