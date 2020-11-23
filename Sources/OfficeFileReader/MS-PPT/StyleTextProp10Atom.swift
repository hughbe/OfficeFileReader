//
//  StyleTextProp10Atom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.69 StyleTextProp10Atom
/// Referenced by: OutlineTextProps10Entry, PP10ShapeBinaryTagExtension
/// An atom record that specifies additional character-level formatting.
/// When this record is contained in an OutlineTextProps10Entry structure, let the corresponding text be as specified in the OutlineTextPropsHeaderExAtom
/// record contained in the OutlineTextProps10Entry structure that contains this StyleTextProp10Atom record.
/// When this record is contained in a PP10ShapeBinaryTagExtension record, let the corresponding text be specified by the TextHeaderAtom record contained
/// in the OfficeArtSpContainer ([MS-ODRAW] section 2.2.14) that contains this StyleTextProp10Atom record.
/// Let the corresponding shape be as specified in the corresponding text.
/// Let the corresponding main master be as specified in the corresponding text.
/// If the corresponding shape is a placeholder shape, character-level formatting not specified by this StyleTextProp10Atom record inherits from the
/// TextMasterStyle10Atom records contained in the corresponding main master.
public struct StyleTextProp10Atom {
    public let rh: RecordHeader
    public let rgStyleTextProp10: [TextCFException10]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_StyleTextProp10Atom.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .styleTextProp10Atom else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// rgStyleTextProp10 (variable): An array of TextCFException10 structures that specifies additional character-level formatting for the corresponding
        /// text. Each item in the array specifies formatting for a sequence of consecutive character runs that share the same value of the pp10runid field of
        /// the TextCFException9 structure, as specified by the StyleTextProp9Atom record that refers to the same corresponding text. If a TextCFException9
        /// structure does not contain the pp10runid field, its value is assumed to be 0x0000. An item at index i MUST be ignored if i % 16 is not equal to
        /// the value of the pp10runid field of the next such sequence. The length, in bytes, of the array is specified by rh.recLen.
        var rgStyleTextProp10: [TextCFException10] = []
        while dataStream.position - startPosition < self.rh.recLen {
            rgStyleTextProp10.append(try TextCFException10(dataStream: &dataStream))
        }
        
        self.rgStyleTextProp10 = rgStyleTextProp10
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
