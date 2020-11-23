//
//  StyleTextProp9Atom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.67 StyleTextProp9Atom
/// Referenced by: OutlineTextProps9Entry, PP9ShapeBinaryTagExtension
/// An atom record that specifies additional text formatting.
/// When this record is contained in an OutlineTextProps9Entry structure, let the corresponding text be as specified in the OutlineTextPropsHeaderExAtom
/// record contained in the OutlineTextProps9Entry structure that contains this StyleTextProp9Atom record.
/// When this record is contained in a PP9ShapeBinaryTagExtension record, let the corresponding text be specified by the TextHeaderAtom record contained
/// in the OfficeArtSpContainer ([MS-ODRAW] section 2.2.14) that contains this StyleTextProp9Atom record.
/// Let the corresponding shape be as specified in the corresponding text.
/// Let the corresponding main master be as specified in the corresponding text.
/// If the corresponding shape is a placeholder shape, character-level and paragraph-level formatting not specified by this StyleTextProp9Atom record inherit
/// from the TextMasterStyle9Atom records contained in the corresponding main master.
public struct StyleTextProp9Atom {
    public let rh: RecordHeader
    public let rgStyleTextProp9: [StyleTextProp9]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_StyleTextProp9Atom.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .styleTextProp9Atom else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// rgStyleTextProp9 (variable): An array of StyleTextProp9 structures that specifies additional formatting for the corresponding text. Each item in the
        /// array specifies formatting for a sequence of consecutive character runs of the corresponding text that share the same value of the fontStyle.pp9rt
        /// field of the TextCFException record. If a TextCFException record does not specify a fontStyle.pp9rt field, its value is assumed to be 0x0000. An
        /// item at index i MUST be ignored if i % 16 is not equal to the value of the fontstyle.pp9rt field of the next such sequence. The length, in bytes, of
        /// the array is specified by rh.recLen.
        var rgStyleTextProp9: [StyleTextProp9] = []
        while dataStream.position - startPosition < self.rh.recLen {
            rgStyleTextProp9.append(try StyleTextProp9(dataStream: &dataStream))
        }
        
        self.rgStyleTextProp9 = rgStyleTextProp9
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
