//
//  NotesId.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.2.18 NotesId
/// Referenced by: NotesPersistAtom
/// A 4-byte unsigned integer that specifies an identifier for a notes slide. It MUST be greater than or equal to 0x00000100 and MUST be less than or
/// equal to 0x7FFFFFFF. The set of NotesId values in the file MUST NOT contain duplicates.
public struct NotesId {
    public let value: UInt32
    
    public init(dataStream: inout DataStream) throws {
        self.value = try dataStream.read(endianess: .littleEndian)
        guard self.value >= 0x00000100 && self.value <= 0x7FFFFFFF else {
            throw OfficeFileError.corrupted
        }
    }
}
