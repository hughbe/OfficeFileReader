//
//  NamedShowNameAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.6.4 NamedShowNameAtom
/// Referenced by: NamedShowContainer
/// An atom record that specifies the name of a named show
public struct NamedShowNameAtom {
    public let rh: RecordHeader
    public let namedShowName: PrintableUnicodeString
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_CString (section 2.13.24).
        /// rh.recLen MUST be an even number.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .cString else {
            throw OfficeFileError.corrupted
        }
        guard (self.rh.recLen % 2) == 0 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// namedShowName (variable): A PrintableUnicodeString (section 2.2.23) that specifies the name of a named show that can be used when
        /// running the slide show.
        self.namedShowName = try PrintableUnicodeString(dataStream: &dataStream, byteCount: Int(self.rh.recLen))
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
