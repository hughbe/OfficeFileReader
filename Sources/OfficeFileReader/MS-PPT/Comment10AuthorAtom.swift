//
//  Comment10AuthorAtom.swift
//
//
//  Created by Hugh Bellamy on 17/11/2020.
//

import DataStream

/// [MS-PPT] 2.5.26 Comment10AuthorAtom
/// Referenced by: Comment10Container
/// An atom record that specifies the name of the author of the presentation comment. The presentation comment is specified by the Comment10Container
/// record that contains this Comment10AuthorAtom record.
public struct Comment10AuthorAtom {
    public let rh: RecordHeader
    public let commentAuthor: PrintableUnicodeString
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_CString (section 2.13.24).
        /// rh.recLen MUST be an even number. It MUST be less than or equal to 104.
        let rh = try RecordHeader(dataStream: &dataStream)
        guard rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard rh.recType == .cString else {
            throw OfficeFileError.corrupted
        }
        guard (rh.recLen % 2) == 0 && rh.recLen <= 104 else {
            throw OfficeFileError.corrupted
        }
        
        self.rh = rh
        
        let startPosition = dataStream.position

        /// commentAuthor (variable): A PrintableUnicodeString (section 2.2.23) that specifies the name of the author. The length, in bytes, of the field
        /// is specified by rh.recLen.
        self.commentAuthor = try PrintableUnicodeString(dataStream: &dataStream, byteCount: Int(self.rh.recLen))
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}

