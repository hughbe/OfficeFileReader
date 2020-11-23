//
//  NotesHeadersFootersContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.15.6 NotesHeadersFootersContainer
/// Referenced by: DocumentContainer
/// A container record that specifies information about the headers and footers on a notes slide.
public struct NotesHeadersFootersContainer {
    public let rh: RecordHeader
    public let hfAtom: HeadersFootersAtom
    public let userDateAtom: UserDateAtom?
    public let headerAtom: HeaderAtom?
    public let footerAtom: FooterAtom?
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x004.
        /// rh.recType MUST be RT_HeadersFooters.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x004 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .headersFooters else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// hfAtom (12 bytes): A HeadersFootersAtom record that specifies the options for displaying the headers and footers.
        self.hfAtom = try HeadersFootersAtom(dataStream: &dataStream)
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.userDateAtom = nil
            self.headerAtom = nil
            self.footerAtom = nil
            return
        }
        
        /// userDateAtom (variable): An optional UserDateAtom record that specifies the custom date to be used in a HeadersFootersAtom record.
        let nextAtom1 = try dataStream.peekRecordHeader()
        if nextAtom1.recType == .cString && nextAtom1.recInstance == 0x000 {
            self.userDateAtom = try UserDateAtom(dataStream: &dataStream)
        } else {
            self.userDateAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.headerAtom = nil
            self.footerAtom = nil
            return
        }
        
        /// headerAtom (variable): An optional HeaderAtom record that specifies the content of the header.
        let nextAtom2 = try dataStream.peekRecordHeader()
        if nextAtom2.recType == .cString && nextAtom2.recInstance == 0x001 {
            self.headerAtom = try HeaderAtom(dataStream: &dataStream)
        } else {
            self.headerAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.footerAtom = nil
            return
        }
        
        /// footerAtom (variable): An optional FooterAtom record that specifies the content of the footer.
        let nextAtom3 = try dataStream.peekRecordHeader()
        if nextAtom3.recType == .cString && nextAtom3.recInstance == 0x002 {
            self.footerAtom = try FooterAtom(dataStream: &dataStream)
        } else {
            self.footerAtom = nil
        }
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
