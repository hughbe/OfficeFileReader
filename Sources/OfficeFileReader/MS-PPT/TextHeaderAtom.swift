//
//  TextHeaderAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.41 TextHeaderAtom
/// Referenced by: SlideListWithTextSubContainerOrAtom, TextClientDataSubContainerOrAtom
/// An atom record that specifies the type of a text body. The presence of this atom indicates a text body whose properties are specified by other atom and
/// container records that follow. The records comprising this text body continue up until the next SlidePersistAtom record (section 2.4.14.5) or
/// the next TextHeaderAtom record that follows this TextHeaderAtom or the end of the rgChildRec array of the OfficeArtClientTextBox or
/// SlideListWithTextContainer (section 2.4.14.3) record that contains this TextHeaderAtom.
/// Let the corresponding slide be specified by one of the following:
///  When this TextHeaderAtom is contained in a SlideListWithTextContainer record, let the corresponding slide be the SlideContainer record (section 2.5.1)
/// as specified by the SlidePersistAtom record that most closely precedes this TextHeaderAtom record.
///  When this TextHeaderAtom is contained in a SlideContainer record, let the corresponding slide be specified by the SlideContainer record that contains
/// this TextHeaderAtom record.
///  When this TextHeaderAtom is contained in a NotesContainer record (section 2.5.6), let the corresponding slide be specified by the SlideContainer
/// record referred to by the notesAtom.slideIdRef field of the NotesContainer record that contains this TextHeaderAtom record.
/// Let the corresponding main master be specified by the MainMasterContainer record (section 2.5.3) specified by the slideAtom.masterIdRef field of the
/// corresponding slide.
/// Let the corresponding shape be specified by one of the following:
///  When this TextHeaderAtom record is contained in a OfficeArtSpContainer record ([MSODRAW] section 2.2.14), let the corresponding shape be the
/// OfficeArtSpContainer record that contains this TextHeaderAtom record.
///  When this TextHeaderAtom record is contained in a SlideListWithTextContainer record, let the corresponding shape be specified by the
/// OfficeArtSpContainer record ([MS-ODRAW] section 2.2.14) contained in the corresponding slide that contains an OutlineTextRefAtom record that
/// refers to this TextHeaderAtom record.
/// The characters of the text body are specified by the TextCharsAtom record or the TextBytesAtom record, if any, that follows this TextHeaderAtom record.
/// In addition, the text body contains a single terminating paragraph break character (0x000D) that is not included in the TextCharsAtom record or
/// TextBytesAtom record.
/// Let the corresponding text style, if any, be specified by the StyleTextPropAtom record that follows this TextHeaderAtom.
/// The text body contains a sequence of character runs comprised of consecutive characters with identical TextCFException record data as specified by the
/// TextCfRun structures in the rgTextCfRun array of the corresponding text style.
/// Let the corresponding text placeholder list be as specified in the SlideListWithTextContainer record that contains this TextHeaderAtom record.
public struct TextHeaderAtom {
    public let rh: RecordHeader
    public let textType: TextTypeEnum
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance Specifies whether this TextHeaderAtom record specifies the text of a placeholder shape. It MUST be greater than or equal to
        /// 0x000 and less than or equal to 0x005. When this TextHeaderAtom record is contained in a SlideListWithTextContainer record, this field
        /// specifies the index of an item in the corresponding text placeholder list. When this TextHeaderAtom record is contained in an
        /// OfficeArtClientTextbox record, this field MUST be 0x000.
        /// rh.recType MUST be RT_TextHeaderAtom.
        /// rh.recLen MUST be 0x00000004.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        if self.rh.recInstance >= 0x005 {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .textHeaderAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000004 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// textType (4 bytes): A TextTypeEnum enumeration that specifies the type of the text body.
        let textTypeRaw: UInt32 = try dataStream.read(endianess: .littleEndian)
        guard let textType = TextTypeEnum(rawValue: textTypeRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.textType = textType
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
