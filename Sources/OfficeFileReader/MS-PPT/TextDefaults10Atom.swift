//
//  TextDefaults10Atom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.75 TextDefaults10Atom
/// Referenced by: PP10DocBinaryTagExtension
/// An atom record that specifies additional default character-level formatting.
public struct TextDefaults10Atom {
    public let rh: RecordHeader
    public let cf10: TextCFException10
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_TextDefaults10Atom.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .textDefaults10Atom else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// cf10 (variable): A TextCFException10 structure that specifies additional font information.
        self.cf10 = try TextCFException10(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
