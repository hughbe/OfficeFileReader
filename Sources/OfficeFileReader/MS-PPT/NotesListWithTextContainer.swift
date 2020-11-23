//
//  NotesListWithTextContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.14.6 NotesListWithTextContainer
/// Referenced by: DocumentContainer
/// A container record that specifies a list of references to notes slides.
public struct NotesListWithTextContainer {
    public let rh: RecordHeader
    public let rgNotesPersistAtom: [NotesPersistAtom]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x002.
        /// rh.recType MUST be RT_SlideListWithText.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x002 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .slideListWithText else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// rgChildRec (variable): An array of SlideListWithTextSubContainerOrAtom records that specifies the references to presentation slides and
        /// text contained within those presentation slides. The sequence of the rh.recType fields of array items MUST be a valid
        /// SlideListWithTextRecordList as specified in the following ABNF (specified in [RFC5234]) grammar:
        /// SlideListWithTextRecordList = 1*SlideRecordList
        /// SlideRecordList = RT_SlidePersistAtom *8(RT_TextHeaderAtom TextCharsOrBytesRecord
        /// StyleTextPropRecord MetaCharRecordList TextBookmarkRecordList TextSpecialInfoRecord InteractiveRecordList)
        /// TextCharsOrBytesRecord = *1(RT_TextCharsAtom / RT_TextBytesAtom)
        /// StyleTextPropRecord = *1RT_StyleTextPropAtom
        /// MetaCharRecordList = *(RT_SlideNumberMetaCharAtom / RT_DateTimeMetaCharAtom /
        /// RT_GenericDateMetaCharAtom / RT_HeaderMetaCharAtom / RT_FooterMetaCharAtom /RT_RtfDateTimeMetaCharAtom)
        /// TextBookmarkRecordList = *RT_TextBookmarkAtom
        /// TextSpecialInfoRecord = *1RT_TextSpecialInfoAtom
        /// InteractiveRecordList = *(RT_InteractiveInfo RT_TextInteractiveInfoAtom)
        var rgNotesPersistAtom: [NotesPersistAtom] = []
        while dataStream.position - startPosition < self.rh.recLen {
            rgNotesPersistAtom.append(try NotesPersistAtom(dataStream: &dataStream))
        }
        
        self.rgNotesPersistAtom = rgNotesPersistAtom
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
