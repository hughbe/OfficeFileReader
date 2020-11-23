//
//  ProgStringTagContainer.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.11.30 ProgStringTagContainer
/// Referenced by: DocProgTagsSubContainerOrAtom, ShapeProgTagsSubContainerOrAtom, SlideProgTagsSubContainerOrAtom
/// A container record that specifies a programmable tag that has a UnicodeString as its value.
public struct ProgStringTagContainer {
    public let rh: RecordHeader
    public let tagNameAtom: TagNameAtom
    public let tagValueAtom: TagValueAtom?
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_ProgStringTag.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .progStringTag else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// tagNameAtom (variable): A TagNameAtom record that specifies the name of the programmable tag.
        self.tagNameAtom = try TagNameAtom(dataStream: &dataStream)
        if dataStream.position - startPosition == self.rh.recLen {
            self.tagValueAtom = nil
            return
        }
        
        /// tagValueAtom (variable): An optional TagValueAtom record that specifies the value of the programmable tag.
        self.tagValueAtom = try TagValueAtom(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
