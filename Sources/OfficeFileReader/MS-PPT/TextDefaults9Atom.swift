//
//  TextDefaults9Atom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.74 TextDefaults9Atom
/// Referenced by: PP9DocBinaryTagExtension
/// An atom record that specifies additional default character-level and paragraph-level formatting.
public struct TextDefaults9Atom {
    public let rh: RecordHeader
    public let cf9: TextCFException9
    public let pf9: TextPFException9
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_TextDefaults9Atom.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .textDefaults9Atom else {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position
        
        /// cf9 (variable): A TextCFException9 structure that specifies default character-level formatting.
        self.cf9 = try TextCFException9(dataStream: &dataStream)
        
        /// pf9 (variable): A TextPFException9 structure that specifies default paragraph-level formatting.
        self.pf9 = try TextPFException9(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
