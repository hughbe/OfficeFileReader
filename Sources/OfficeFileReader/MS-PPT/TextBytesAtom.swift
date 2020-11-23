//
//  TextCharsAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.43 TextBytesAtom
/// Referenced by: SlideListWithTextSubContainerOrAtom, TextClientDataSubContainerOrAtom
/// An atom record that specifies Unicode characters.
/// Let the corresponding text be specified by the TextHeaderAtom record that most closely precedes this record.
public struct TextBytesAtom {
    public let rh: RecordHeader
    public let textBytes: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_TextBytesAtom.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .textBytesAtom else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// textBytes (variable): An array of bytes that specifies the characters of the corresponding text. Each item represents the low byte of a UTF-16
        /// Unicode [RFC2781] character whose high byte is 0x00. The length, in bytes, of the array is specified by rh.recLen. The array MUST NOT
        /// contain a 0x00 byte.
        self.textBytes = try dataStream.readBytes(count: Int(self.rh.recLen))
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
