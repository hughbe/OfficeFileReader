//
//  NotesDiffContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.20.26 NotesDiffContainer
/// Referenced by: MainMasterDiffContainer, SlideDiffContainer
/// A container record that specifies how to display the changes made by the reviewer to the notes master slide or to a notes slide.
/// Let the corresponding reviewer document be as specified in the DiffTree10Container record that contains this NotesDiffContainer record.
/// Let the corresponding slide be as specified in the SlideDiffContainer record that contains this NotesDiffContainer record or let the corresponding main
/// master slide be as specified in the MainMasterDiffContainer record that contains this NotesDiffContainer record.
/// Let the corresponding notes slide be the NotesContainer record (section 2.5.6) as specified by the slideAtom.notesIdRef field of the corresponding
/// slide or let the corresponding notes master slide be as specified by the notesMasterPersistIdRef field of the DocumentAtom record (section 2.4.2) in
/// the corresponding reviewer document.
/// Let the corresponding notes shape be specified by the OfficeArtSpContainer record ([MS-ODRAW] section 2.2.14) contained in the corresponding
/// notes slide or corresponding notes master slide such that the placementId field of the PlaceholderAtom record contained within the OfficeArtSpContainer
/// record has the value of PT_NotesBody.
/// Let the corresponding notes text be as specified in the OfficeArtClientTextbox record contained within the corresponding notes shape.
public struct NotesDiffContainer {
    public let rhs: DiffRecordHeaders
    public let reserved1: UInt8
    public let wordList: Bool
    public let reserved2: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rhs (28 bytes): A DiffRecordHeaders structure that specifies the header for the container record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rhs.fIndex MUST be 0x00.
        /// rhs.gmiTag MUST be Diff_NotesDiff.
        self.rhs = try DiffRecordHeaders(dataStream: &dataStream)
        guard !self.rhs.fIndex.value else {
            throw OfficeFileError.corrupted
        }
        guard self.rhs.gmiTag == .notesDiff else {
            throw OfficeFileError.corrupted
        }

        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - reserved1 (2 bits): MUST be zero and MUST be ignored.
        self.reserved1 = UInt8(flags.readBits(count: 2))
        
        /// B - wordList (1 bit): A bit that specifies whether the change made by the reviewer to the corresponding notes text is not displayed. It MUST
        /// be FALSE if the corresponding notes text is contained within the corresponding notes master slide.
        self.wordList = flags.readBit()
        
        /// reserved2 (29 bits): MUST be zero and MUST be ignored.
        self.reserved2 = flags.readRemainingBits()
    }
}
