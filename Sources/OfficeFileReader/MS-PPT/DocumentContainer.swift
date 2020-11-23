//
//  DocumentContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.1 DocumentContainer
/// A container record that specifies information about the document.
public struct DocumentContainer {
    public let rh: RecordHeader
    public let documentAtom: DocumentAtom
    public let exObjList: ExObjListContainer?
    public let documentTextInfo: DocumentTextInfoContainer
    public let soundCollection: SoundCollectionContainer?
    public let drawingGroup: DrawingGroupContainer
    public let masterList: MasterListWithTextContainer
    public let docInfoList: DocInfoListContainer?
    public let slideHF: SlideHeadersFootersContainer?
    public let notesHF: NotesHeadersFootersContainer?
    public let slideList: SlideListWithTextContainer?
    public let notesList: NotesListWithTextContainer?
    public let slideShowDocInfoAtom: SlideShowDocInfoAtom?
    public let namedShows: NamedShowsContainer?
    public let summary: SummaryContainer?
    public let docRoutingSlipAtom: DocRoutingSlipAtom?
    public let printOptionsAtom: PrintOptionsAtom?
    public let rtCustomTableStylesAtom1: RoundTripCustomTableStyles12Atom?
    public let endDocumentAtom: EndDocumentAtom
    public let rtCustomTableStylesAtom2: RoundTripCustomTableStyles12Atom?
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_Document (section 2.13.24)
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .document else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// documentAtom (48 bytes): A DocumentAtom record (section 2.4.2) that specifies size information for presentation slides and notes slides.
        self.documentAtom = try DocumentAtom(dataStream: &dataStream)
        
        /// exObjList (variable): An optional ExObjListContainer record (section 2.10.1) that specifies the list of external objects in the document.
        if try dataStream.peekRecordHeader().recType == .externalObjectList {
            self.exObjList = try ExObjListContainer(dataStream: &dataStream)
        } else {
            self.exObjList = nil
        }
        
        /// documentTextInfo (variable): A DocumentTextInfoContainer record (section 2.9.1) that specifies the default text styles for the document.
        self.documentTextInfo = try DocumentTextInfoContainer(dataStream: &dataStream)
        
        /// soundCollection (variable): An optional SoundCollectionContainer record (section 2.4.16.1) that specifies the list of sounds in the file.
        if try dataStream.peekRecordHeader().recType == .soundCollection {
            self.soundCollection = try SoundCollectionContainer(dataStream: &dataStream)
        } else {
            self.soundCollection = nil
        }
        
        /// drawingGroup (variable): A DrawingGroupContainer record (section 2.4.3) that specifies drawing information for the document.
        self.drawingGroup = try DrawingGroupContainer(dataStream: &dataStream)
        
        /// masterList (variable): A MasterListWithTextContainer record (section 2.4.14.1) that specifies the list of main master slides and title master
        /// slides.
        self.masterList = try MasterListWithTextContainer(dataStream: &dataStream)
        
        /// docInfoList (variable): An optional DocInfoListContainer record (section 2.4.4) that specifies additional document information.
        if try dataStream.peekRecordHeader().recType == .list {
            self.docInfoList = try DocInfoListContainer(dataStream: &dataStream)
        } else {
            self.docInfoList = nil
        }
        
        /// slideHF (variable): An optional SlideHeadersFootersContainer record (section 2.4.15.1) that specifies the default header and footer
        /// information for presentation slides.
        let nextAtom1 = try dataStream.peekRecordHeader()
        if nextAtom1.recType == .headersFooters && nextAtom1.recInstance == 0x003 {
            self.slideHF = try SlideHeadersFootersContainer(dataStream: &dataStream)
        } else {
            self.slideHF = nil
        }
        
        /// notesHF (variable): An optional NotesHeadersFootersContainer record (section 2.4.15.6) that specifies the default header and footer
        /// information for notes slides.
        let nextAtom2 = try dataStream.peekRecordHeader()
        if nextAtom2.recType == .headersFooters && nextAtom2.recInstance == 0x004 {
            self.notesHF = try NotesHeadersFootersContainer(dataStream: &dataStream)
        } else {
            self.notesHF = nil
        }
        
        /// slideList (variable): An optional SlideListWithTextContainer record (section 2.4.14.3) that specifies the list of presentation slides.
        let nextAtom3 = try dataStream.peekRecordHeader()
        if nextAtom3.recType == .slideListWithText && nextAtom3.recInstance == 0x000 {
            self.slideList = try SlideListWithTextContainer(dataStream: &dataStream)
        } else {
            self.slideList = nil
        }

        /// notesList (variable): An optional NotesListWithTextContainer record (section 2.4.14.6) that specifies the list of notes slides.
        let nextAtom4 = try dataStream.peekRecordHeader()
        if nextAtom4.recType == .slideListWithText && nextAtom4.recInstance == 0x002 {
            self.notesList = try NotesListWithTextContainer(dataStream: &dataStream)
        } else {
            self.notesList = nil
        }
        
        /// slideShowDocInfoAtom (88 bytes): An optional SlideShowDocInfoAtom record (section 2.6.1) that specifies slide show information for the document.
        if try dataStream.peekRecordHeader().recType == .slideShowDocInfoAtom {
            self.slideShowDocInfoAtom = try SlideShowDocInfoAtom(dataStream: &dataStream)
        } else {
            self.slideShowDocInfoAtom = nil
        }
        
        /// namedShows (variable): An optional NamedShowsContainer record (section 2.6.2) that specifies named shows in the document.
        if try dataStream.peekRecordHeader().recType == .namedShows {
            self.namedShows = try NamedShowsContainer(dataStream: &dataStream)
        } else {
            self.namedShows = nil
        }
        
        /// summary (variable): An optional SummaryContainer record (section 2.4.22.3) that specifies bookmarks for the document.
        if try dataStream.peekRecordHeader().recType == .summary {
            self.summary = try SummaryContainer(dataStream: &dataStream)
        } else {
            self.summary = nil
        }
        
        /// docRoutingSlipAtom (variable): An optional DocRoutingSlipAtom record (section 2.11.1) that specifies document routing information.
        if try dataStream.peekRecordHeader().recType == .docRoutingSlipAtom {
            self.docRoutingSlipAtom = try DocRoutingSlipAtom(dataStream: &dataStream)
        } else {
            self.docRoutingSlipAtom = nil
        }
        
        /// printOptionsAtom (13 bytes): An optional PrintOptionsAtom record (section 2.4.12) that specifies default print options.
        if try dataStream.peekRecordHeader().recType == .printOptionsAtom {
            self.printOptionsAtom = try PrintOptionsAtom(dataStream: &dataStream)
        } else {
            self.printOptionsAtom = nil
        }
        
        try dataStream.skipUnknownRecords(startPosition: startPosition, length: Int(self.rh.recLen))
        
        /// rtCustomTableStylesAtom1 (variable): An optional RoundTripCustomTableStyles12Atom record (section 2.11.13) that specifies round-trip
        /// information for custom table styles.
        if try dataStream.peekRecordHeader().recType == .roundTripCustomTableStyles12Atom {
            self.rtCustomTableStylesAtom1 = try RoundTripCustomTableStyles12Atom(dataStream: &dataStream)
        } else {
            self.rtCustomTableStylesAtom1 = nil
        }
        
        try dataStream.skipUnknownRecords(startPosition: startPosition, length: Int(self.rh.recLen))
        
        /// endDocumentAtom (8 bytes): An EndDocumentAtom record (section 2.4.13) that specifies the end of the information for the document.
        self.endDocumentAtom = try EndDocumentAtom(dataStream: &dataStream)
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.rtCustomTableStylesAtom2 = nil
            return
        }
        
        /// rtCustomTableStylesAtom2 (variable): An optional RoundTripCustomTableStyles12Atom record that specifies round-trip information for
        /// custom table styles. It MUST NOT exist if rtCustomTableStylesAtom1 exists.
        if try dataStream.peekRecordHeader().recType == .roundTripCustomTableStyles12Atom {
            guard self.rtCustomTableStylesAtom1 == nil else {
                throw OfficeFileError.corrupted
            }
            
            self.rtCustomTableStylesAtom2 = try RoundTripCustomTableStyles12Atom(dataStream: &dataStream)
        } else {
            self.rtCustomTableStylesAtom2 = nil
        }
        
        try dataStream.skipUnknownRecords(startPosition: startPosition, length: Int(self.rh.recLen), includeAny: true)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
