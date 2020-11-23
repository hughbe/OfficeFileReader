//
//  NotesIdRef.swift
//  
//
//  Created by Hugh Bellamy on 21/11/2020.
//

/// [MS-PPT] 2.2.19 NotesIdRef
/// Referenced by: SlideAtom
/// A 4-byte unsigned integer that specifies a reference to a notes slide. It MUST be 0x00000000 or equal to the value of the notesId field of a
/// NotesPersistAtom record (section 2.4.14.7). The value 0x00000000 specifies a null reference.
public typealias NotesIdRef = UInt32
