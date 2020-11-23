//
//  NotesAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.5.12 NotesAtom
/// Referenced by: NotesContainer
/// An atom record that specifies information about a notes slide or notes master slide.
public struct NotesAtom {
    public let rh: RecordHeader
    public let slideIdRef: SlideIdRef
    public let slideFlags: SlideFlags
    public let unused: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x1.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_NotesAtom.
        /// rh.recLen MUST be 0x00000008.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x1 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .notesAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000008 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// slideIdRef (4 bytes): A SlideIdRef (section 2.2.25) that specifies the presentation slide associated with the notes slide. It MUST be
        /// 0x00000000 if the NotesContainer record (section 2.5.6) that contains this NotesAtom record represents the notes master slide. It MUST
        /// NOT be 0x00000000 if the NotesContainer record that contains this NotesAtom record represents a notes slide.
        self.slideIdRef = try dataStream.read(endianess: .littleEndian)
        
        /// slideFlags (2 bytes): A SlideFlags structure that specifies which content on the notes slide follows content on the notes master slide.
        /// It MUST be 0x0000 if slideIdRef is 0x00000000.
        self.slideFlags = try SlideFlags(dataStream: &dataStream)
        
        /// unused (2 bytes): Undefined and MUST be ignored.
        self.unused = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
