//
//  TextCFExceptionAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.13 TextCFExceptionAtom
/// Referenced by: DocumentTextInfoContainer
/// An atom record that specifies character-level style and formatting.
public struct TextCFExceptionAtom {
    public let rh: RecordHeader
    public let cf: TextCFException
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_TextCharFormatExceptionAtom.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .textCharFormatExceptionAtom else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// cf (variable): A TextCFException structure that specifies character-level style and formatting.
        self.cf = try TextCFException(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
