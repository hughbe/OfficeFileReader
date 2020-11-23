//
//  TextPFExceptionAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.19 TextPFExceptionAtom
/// Referenced by: DocumentTextInfoContainer
/// An atom record that specifies paragraph-level formatting.
public struct TextPFExceptionAtom {
    public let rh: RecordHeader
    public let reserved: UInt16
    public let pf: TextPFException
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_TextParagraphFormatExceptionAtom.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .textParagraphFormatExceptionAtom else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// reserved (2 bytes): MUST be zero and MUST be ignored.
        self.reserved = try dataStream.read(endianess: .littleEndian)
        
        /// pf (variable): A TextPFException structure that specifies paragraph-level formatting.
        self.pf = try TextPFException(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
