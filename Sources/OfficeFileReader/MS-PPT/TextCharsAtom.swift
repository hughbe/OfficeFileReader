//
//  TextCharsAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.42 TextCharsAtom
/// Referenced by: SlideListWithTextSubContainerOrAtom, TextClientDataSubContainerOrAtom
/// An atom record that specifies Unicode characters.
/// Let the corresponding text be specified by the TextHeaderAtom record that most closely precedes this record.
public struct TextCharsAtom {
    public let rh: RecordHeader
    public let textChars: String
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_TextCharsAtom.
        /// rh.recLen MUST be even.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .textCharsAtom else {
            throw OfficeFileError.corrupted
        }
        guard (self.rh.recLen % 2) == 0 else {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position

        /// textChars (variable): An array of UTF-16 Unicode [RFC2781] characters that specifies the characters of the corresponding text. The length,
        /// in bytes, of the array is specified by rh.recLen. The array MUST NOT contain the NUL character 0x0000.
        self.textChars = try dataStream.readString(count: Int(self.rh.recLen), encoding: .utf16LittleEndian)!
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
