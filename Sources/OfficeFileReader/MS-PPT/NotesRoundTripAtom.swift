//
//  NotesRoundTripAtom.swift
//
//
//  Created by Hugh Bellamy on 23/11/2020.
//

import DataStream

/// [MS-PPT] 2.5.7 NotesRoundTripAtom
/// Referenced by: NotesContainer
/// A variable type record whose type and meaning is dictated by the value of rh.recType, as specified in the following table.
public enum NotesRoundTripAtom {
    /// RT_RoundTripTheme12Atom A RoundTripThemeAtom record that specifies round-trip information. It SHOULD<70> be ignored and SHOULD<71>
    /// be preserved.
    case roundTripTheme12Atom(data: RoundTripThemeAtom)
    
    /// RT_RoundTripColorMapping12Atom A RoundTripColorMappingAtom record that specifies round-trip information. It SHOULD<72> be ignored
    /// and SHOULD<73> be preserved.
    case roundTripColorMapping12Atom(data: RoundTripColorMappingAtom)
    
    /// RT_RoundTripNotesMasterTextStyles12Atom A RoundTripNotesMasterTextStyles12Atom record that specifies round-trip information. It
    /// SHOULD<74> be ignored and SHOULD<75> be preserved.
    case roundTripNotesMasterTextStyles12Atom(data: RoundTripNotesMasterTextStyles12Atom)
    
    public init(dataStream: inout DataStream) throws {
        switch try dataStream.peekRecordHeader().recType {
        case .roundTripTheme12Atom:
            self = .roundTripTheme12Atom(data: try RoundTripThemeAtom(dataStream: &dataStream))
        case .roundTripColorMapping12Atom:
            self = .roundTripColorMapping12Atom(data: try RoundTripColorMappingAtom(dataStream: &dataStream))
        case .roundTripNotesMasterTextStyles12Atom:
            self = .roundTripNotesMasterTextStyles12Atom(data: try RoundTripNotesMasterTextStyles12Atom(dataStream: &dataStream))
        default:
            throw OfficeFileError.corrupted
        }
    }
}
