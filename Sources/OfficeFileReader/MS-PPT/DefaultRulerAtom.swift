//
//  DefaultRulerAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.28 DefaultRulerAtom
/// Referenced by: DocumentTextInfoContainer
/// An atom record that specifies the default ruler and corresponding options.
public struct DefaultRulerAtom {
    public let rh: RecordHeader
    public let defaultTextRuler: TextRuler
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_DefaultRulerAtom.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .defaultRulerAtom else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// defaultTextRuler (variable): A TextRuler structure that specifies the default text ruler. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// defaultTextRuler.fDefaultTabSize MUST be TRUE.
        /// defaultTextRuler.fCLevels MUST be TRUE.
        /// defaultTextRuler.fTabStops MUST be TRUE.
        /// defaultTextRuler.fLeftMargin1 MUST be TRUE.
        /// defaultTextRuler.fLeftMargin2 MUST be TRUE.
        /// defaultTextRuler.fLeftMargin3 MUST be TRUE.
        /// defaultTextRuler.fLeftMargin4 MUST be TRUE.
        /// defaultTextRuler.fLeftMargin5 MUST be TRUE.
        /// defaultTextRuler.fIndent1 MUST be TRUE.
        /// defaultTextRuler.fIndent2 MUST be TRUE.
        /// defaultTextRuler.fIndent3 MUST be TRUE.
        /// defaultTextRuler.fIndent4 MUST be TRUE.
        /// defaultTextRuler.fIndent5 MUST be TRUE.
        self.defaultTextRuler = try TextRuler(dataStream: &dataStream)
        guard self.defaultTextRuler.fDefaultTabSize &&
                self.defaultTextRuler.fCLevels &&
                self.defaultTextRuler.fTabStops &&
                self.defaultTextRuler.fLeftMargin1 &&
                self.defaultTextRuler.fLeftMargin2 &&
                self.defaultTextRuler.fLeftMargin3 &&
                self.defaultTextRuler.fLeftMargin4 &&
                self.defaultTextRuler.fLeftMargin5 &&
                self.defaultTextRuler.fIndent1 &&
                self.defaultTextRuler.fIndent2 &&
                self.defaultTextRuler.fIndent3 &&
                self.defaultTextRuler.fIndent4 &&
                self.defaultTextRuler.fIndent5 else {
            throw OfficeFileError.corrupted
        }
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
