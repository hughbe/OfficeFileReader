//
//  EndDocumentAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.13 EndDocumentAtom
/// Referenced by: DocumentContainer
/// An atom record that specifies the end of information for the document inside a DocumentContainer record (section 2.4.1).
public struct EndDocumentAtom {
    public let rh: RecordHeader
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_EndDocumentAtom.
        /// rh.recLen MUST be 0x00000000.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .endDocumentAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000000 else {
            throw OfficeFileError.corrupted
        }
    }
}
