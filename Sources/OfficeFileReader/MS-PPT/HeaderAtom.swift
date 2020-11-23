//
//  HeaderAtom.swift
//
//
//  Created by Hugh Bellamy on 17/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.15.4 HeaderAtom
/// Referenced by: NotesHeadersFootersContainer
/// An atom record that specifies text to be used in a header on a handout slide or notes slide.
public struct HeaderAtom {
    public let rh: RecordHeader
    public let header: PrintableUnicodeString
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x001.
        /// rh.recType MUST be an RT_CString (section 2.13.24).
        /// rh.recLen MUST be even.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x001 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .cString else {
            throw OfficeFileError.corrupted
        }
        guard (self.rh.recLen % 2) == 0 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// header (variable): A PrintableUnicodeString (section 2.2.23 ) that specifies the text for the header. The length, in bytes, of the field is specified
        /// by rh.recLen.
        self.header = try PrintableUnicodeString(dataStream: &dataStream, byteCount: Int(self.rh.recLen))
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}

