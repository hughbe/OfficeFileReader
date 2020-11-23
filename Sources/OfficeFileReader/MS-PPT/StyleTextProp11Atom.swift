//
//  StyleTextProp11Atom.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.70 StyleTextProp11Atom
/// Referenced by: OutlineTextProps11Entry, PP11ShapeBinaryTagExtension
/// An atom record that specifies additional text properties.
/// When this record is contained in an OutlineTextProps11Entry structure, let the corresponding text be as specified in the OutlineTextPropsHeaderExAtom
/// record contained in the OutlineTextProps11Entry structure that contains this StyleTextProp11Atom record.
/// When this record is contained in a PP11ShapeBinaryTagExtension record, let the corresponding text be specified by the TextHeaderAtom record contained
/// in the OfficeArtSpContainer ([MS-ODRAW] section 2.2.14) that contains this StyleTextProp11Atom record.
public struct StyleTextProp11Atom {
    public let rh: RecordHeader
    public let rgStyleTextProp11: [StyleTextProp11]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_StyleTextProp11Atom.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .styleTextProp11Atom else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// rgStyleTextProp11 (variable): An array of StyleTextProp11 structures that specifies smart tags for the corresponding text. Each item specifies
        /// properties for a sequence of characters until the beginning or end of the next smart tag. An item at index i MUST be ignored if i % 16 is not equal
        /// to the value of the si.pp10runid field of the StyleTextProp9 record that refers to the same characters. If the StyleTextProp9 record does not
        /// contain a si.pp10runid field, its value is assumed to be 0x0000.
        var rgStyleTextProp11: [StyleTextProp11] = []
        while dataStream.position - startPosition < self.rh.recLen {
            rgStyleTextProp11.append(try StyleTextProp11(dataStream: &dataStream))
        }
        
        self.rgStyleTextProp11 = rgStyleTextProp11
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
