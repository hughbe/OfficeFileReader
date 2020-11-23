//
//  TextRulerAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.29 TextRulerAtom
/// Referenced by: TextClientDataSubContainerOrAtom
/// An atom record that specifies a text ruler.
public struct TextRulerAtom {
    public let rh: RecordHeader
    public let textRuler: TextRuler
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_TextRulerAtom.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .textRulerAtom else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// textRuler (variable): A TextRuler structure that specifies a text ruler.
        self.textRuler = try TextRuler(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
