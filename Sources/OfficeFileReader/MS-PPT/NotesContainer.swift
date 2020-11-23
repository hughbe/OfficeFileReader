//
//  NotesContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.5.6 NotesContainer
/// A container record that specifies a notes slide or a notes master slide.
/// Let the corresponding notes master be specified by the NotesContainer record specified by the notesMasterPersistIdRef field of the DocumentAtom
/// record (section 2.4.2).
public struct NotesContainer {
    public let rh: RecordHeader
    public let notesAtom: NotesAtom
    public let perSlideHeadersFootersContainer1: PerSlideHeadersFootersContainer?
    public let drawing: DrawingContainer
    public let slideSchemeColorSchemeAtom: SlideSchemeColorSchemeAtom
    public let perSlideHeadersFootersContainer2: PerSlideHeadersFootersContainer?
    public let slideNameAtom: SlideNameAtom?
    public let slideProgTagsContainer: SlideProgTagsContainer?
    public let rgNotesRoundTripAtom: [NotesRoundTripAtom]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_Notes.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .notes else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// notesAtom (16 bytes): A NotesAtom record that specifies data for this notes slide or notes master slide.
        self.notesAtom = try NotesAtom(dataStream: &dataStream)
        
        // Not specified but observed in the wild.
        if try dataStream.peekRecordHeader().recType == .headersFooters {
            self.perSlideHeadersFootersContainer1 = try PerSlideHeadersFootersContainer(dataStream: &dataStream)
        } else {
            self.perSlideHeadersFootersContainer1 = nil
        }
        
        /// drawing (variable): A DrawingContainer record (section 2.5.13) that specifies the arrangement of content on this notes slide or notes master
        /// slide.
        self.drawing = try DrawingContainer(dataStream: &dataStream)
        
        /// slideSchemeColorSchemeAtom (40 bytes): A SlideSchemeColorSchemeAtom record that specifies a color scheme for this notes slide or
        /// notes master slide. If notesAtom.slideFlags.fMasterScheme is set, the SlideSchemeColorSchemeAtom record contained by the
        /// corresponding notes master is used instead.
        self.slideSchemeColorSchemeAtom = try SlideSchemeColorSchemeAtom(dataStream: &dataStream)
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.slideNameAtom = nil
            self.slideProgTagsContainer = nil
            self.perSlideHeadersFootersContainer2 = nil
            self.rgNotesRoundTripAtom = []
            return
        }
        
        // Not specified but observed in the wild.
        if try dataStream.peekRecordHeader().recType == .headersFooters {
            self.perSlideHeadersFootersContainer2 = try PerSlideHeadersFootersContainer(dataStream: &dataStream)
        } else {
            self.perSlideHeadersFootersContainer2 = nil
        }
        
        /// slideNameAtom (variable): An optional SlideNameAtom record that specifies a name for this notes slide or notes master slide. It
        /// SHOULD<69> be preserved.
        if try dataStream.peekRecordHeader().recType == .cString {
            self.slideNameAtom = try SlideNameAtom(dataStream: &dataStream)
        } else {
            self.slideNameAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.slideProgTagsContainer = nil
            self.rgNotesRoundTripAtom = []
            return
        }
        
        /// slideProgTagsContainer (variable): An optional SlideProgTagsContainer record that specifies a list of programmable tags.
        if try dataStream.peekRecordHeader().recType == .progTags {
            self.slideProgTagsContainer = try SlideProgTagsContainer(dataStream: &dataStream)
        } else {
            self.slideProgTagsContainer = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.rgNotesRoundTripAtom = []
            return
        }
        
        /// rgNotesRoundTripAtom (variable): An array of NotesRoundTripAtom records that specifies additional data for this notes slide or notes
        /// master slide. The array continues while rh.recType of the NotesRoundTripAtom item is equal to one of the following record types:
        /// RT_RoundTripTheme12Atom, RT_RoundTripColorMapping12Atom, or RT_RoundTripNotesMasterTextStyles12Atom. Each record type
        /// MUST NOT appear more than once.
        var rgNotesRoundTripAtom: [NotesRoundTripAtom] = []
        while dataStream.position - startPosition < self.rh.recLen {
            let record = try dataStream.peekRecordHeader()
            guard record.recType == .roundTripTheme12Atom ||
                    record.recType == .roundTripColorMapping12Atom ||
                    record.recType == .roundTripNotesMasterTextStyles12Atom else {
                break
            }
            
            rgNotesRoundTripAtom.append(try NotesRoundTripAtom(dataStream: &dataStream))
        }
        
        self.rgNotesRoundTripAtom = rgNotesRoundTripAtom
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
