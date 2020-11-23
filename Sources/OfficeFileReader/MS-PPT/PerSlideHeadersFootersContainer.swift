//
//  PerSlideHeadersFootersContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.5.16 PerSlideHeadersFootersContainer
/// Referenced by: MainMasterContainer, SlideContainer
/// A container record that specifies information about the headers and footers within a slide
public struct PerSlideHeadersFootersContainer {
    public let rh: RecordHeader
    public let hfAtom: HeadersFootersAtom
    public let userDateAtom: UserDateAtom?
    public let footerAtom: FooterAtom?
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_HeadersFooters.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .headersFooters else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// hfAtom (12 bytes): A HeadersFootersAtom record that specifies the options for displaying headers and footers.
        self.hfAtom = try HeadersFootersAtom(dataStream: &dataStream)
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.userDateAtom = nil
            self.footerAtom = nil
            return
        }
        
        /// userDateAtom (variable): An optional UserDateAtom record that specifies the custom date to be used in the date field.
        let nextAtom1 = try dataStream.peekRecordHeader()
        if nextAtom1.recType == .cString && nextAtom1.recInstance == 0x000 {
            self.userDateAtom = try UserDateAtom(dataStream: &dataStream)
        } else {
            self.userDateAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.footerAtom = nil
            return
        }
        
        /// footerAtom (variable): An optional FooterAtom record that specifies the text that is used in the footer.
        let nextAtom2 = try dataStream.peekRecordHeader()
        if nextAtom2.recType == .cString && nextAtom2.recInstance == 0x002 {
            self.footerAtom = try FooterAtom(dataStream: &dataStream)
        } else {
            self.footerAtom = nil
        }
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
