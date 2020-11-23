//
//  FooterMCAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.49 FooterMCAtom
/// Referenced by: SlideListWithTextSubContainerOrAtom, TextClientDataSubContainerOrAtom
/// An atom record that specifies a footer metacharacter.
/// The metacharacter is replaced by the text in the corresponding footer.
/// Let the corresponding footer be specified by the FooterAtom record contained in the SlideHeadersFootersContainer record (section 2.4.15.1) for presentation
/// slides, the NotesHeadersFootersContainer record (section 2.4.15.6) for handout slides and notes slides, or in the PerSlideHeadersFootersContainer record
/// for each slide.
/// Let the corresponding text be specified by the TextHeaderAtom record that most closely precedes this FooterMCAtom record.
public struct FooterMCAtom {
    public let rh: RecordHeader
    public let position: TextPosition
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_FooterMetaCharAtom.
        /// rh.recLen MUST be 0x00000004.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .footerMetaCharAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000004 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// position (4 bytes): A TextPosition that specifies the position of the metacharacter in the corresponding text.
        self.position = try TextPosition(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
