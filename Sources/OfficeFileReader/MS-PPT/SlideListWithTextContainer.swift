//
//  SlideListWithTextContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.14.3 SlideListWithTextContainer
/// Referenced by: DocumentContainer
/// A container record that specifies a list of references to presentation slides and text-related records for text contained within those presentation slides.
/// Each SlidePersistAtom record (section 2.4.14.5) in this list references a SlideContainer record (section 2.5.1) as specified by the persistIdRef field of
/// the SlidePersistAtom record. Let the corresponding slide be the SlideContainer record so specified.
/// Let the corresponding text placeholder list be specified by the sequence of items in the slideAtom.rgPlaceholderTypes array of the corresponding
/// slide with one of the following values: PT_MasterTitle, PT_MasterBody, PT_MasterCenterTitle, PT_MasterSubTitle, PT_Title, PT_Body, PT_CenterTitle,
/// PT_SubTitle, PT_VerticalTitle, or PT_VerticalBody.
/// The ith TextHeaderAtom record that follows a SlidePersistAtom record specifies the text of a shape that corresponds to the ith item in the corresponding
/// text placeholder list.
public struct SlideListWithTextContainer {
    public let rh: RecordHeader
    public let rgChildRec: [SlideListWithTextSubContainerOrAtom]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_SlideListWithText.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
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
        var textCount: Int = 0
        var rgChildRec: [SlideListWithTextSubContainerOrAtom] = []
        while dataStream.position - startPosition < self.rh.recLen {
            let childRec = try SlideListWithTextSubContainerOrAtom(dataStream: &dataStream, textCount: textCount)
            rgChildRec.append(childRec)
            if case let .textBytesAtom(data: atom) = childRec {
                textCount = atom.textBytes.count
            }
            if case let .textCharsAtom(data: atom) = childRec {
                textCount = atom.textChars.count
            }
        }
        
        self.rgChildRec = rgChildRec
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
