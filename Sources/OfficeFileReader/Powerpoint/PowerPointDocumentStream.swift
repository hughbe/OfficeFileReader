//
//  PowerPointDocumentStream.swift
//  
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import CompoundFileReader
import DataStream

public struct PowerPointDocumentStream {
    private let storage: CompoundFileStorage
    private var dataStream: DataStream
    
    public let persistObjectDirectory: PersistObjectDirectory
    public let documentContainer: DocumentContainer
    public let notesMasterSlide: NotesContainer?
    public let handoutMasterSlide: HandoutContainer?
    public let masterSlides: [MasterOrSlideContainer]
    public let presentationSlides: [SlideContainer]
    public let notesSlides: [NotesContainer]
    public let activeXControls: [ExControlStg]
    public let embeddedOleObjects: [ExOleObjStg]
    public let linkedOleObjects: [ExOleObjStg]
    public let vbaProject: VbaProjectStg?
    
    internal init(storage: CompoundFileStorage, currentUser: CurrentUser) throws {
        self.storage = storage
        self.dataStream = storage.dataStream

        /// Part 1: Construct the persist object directory.
        /// 1. Read the CurrentUserAtom record (section 2.3.2) from the Current User Stream (section 2.1.1). All seek operations in the steps that follow
        /// this step are in the PowerPoint Document Stream.
        /// 2. Seek, in the PowerPoint Document Stream, to the offset specified by the offsetToCurrentEdit field of the CurrentUserAtom record
        /// identified in step 1.
        guard currentUser.currentUserAtom.offsetToCurrentEdit <= dataStream.count else {
            throw OfficeFileError.corrupted
        }
        
        dataStream.position = Int(currentUser.currentUserAtom.offsetToCurrentEdit)
        
        /// Part 1: Construct the persist object directory.
        self.persistObjectDirectory = try PersistObjectDirectory(dataStream: &dataStream)
        
        /// Part 2: Identify the document persist object.
        /// 1. Read the docPersistIdRef field of the UserEditAtom record first identified in step 3 of Part 1, that is, the UserEditAtom record closest to
        /// the end of the stream.
        let docPersistIdRef = self.persistObjectDirectory.userEditAtom.docPersistIdRef
        
        /// 2. Lookup the value of the docPersistIdRef field in the persist object directory constructed in step 8 of Part 1 to find the stream offset of
        /// a persist object.
        /// 3. Seek to the stream offset specified in step 2.
        try self.persistObjectDirectory.seek(dataStream: &dataStream, to: docPersistIdRef)
        
        /// 4. Read the DocumentContainer record at the current offset. Let this record be a live record.
        self.documentContainer = try DocumentContainer(dataStream: &dataStream)
        
        /// Part 3: Identify the notes master slide persist object.
        /// 1. Read the documentAtom.notesMasterPersistIdRef field of the DocumentContainer record identified in step 4 of Part 2. If the value of the
        /// field is zero, skip to step 1 of Part 4.
        let notesMasterPersistIdRef = documentContainer.documentAtom.notesMasterPersistIdRef
        if notesMasterPersistIdRef.isNullReference {
            self.notesMasterSlide = nil
        } else {
            /// 2. Lookup the value of the documentAtom.notesMasterPersistIdRef field in the persist object directory constructed in step 8 of Part 1 to
            /// find the stream offset of a persist object.
            /// 3. Seek to the stream offset specified in step 2.
            try self.persistObjectDirectory.seek(dataStream: &dataStream, to: notesMasterPersistIdRef)
            
            /// 4. Read the NotesContainer record at the current offset. Let this record be a live record.
            self.notesMasterSlide = try NotesContainer(dataStream: &dataStream)
        }
        
        /// Part 4: Identify the handout master slide persist object.
        /// 1. Read the documentAtom.handoutMasterPersistIdRef field of the DocumentContainer record identified in step 4 of Part 2. If the value of
        /// the field is zero, skip to step 1 of Part 5.
        let handoutMasterPersistIdRef = documentContainer.documentAtom.handoutMasterPersistIdRef
        if handoutMasterPersistIdRef.isNullReference {
            self.handoutMasterSlide = nil
        } else {
            /// 2. Lookup the value of the documentAtom.handoutMasterPersistIdRef field in the persist object directory constructed in step 8 of Part 1
            /// to find the stream offset of a persist object.
            /// 3. Seek to the stream offset specified in step 2.
            try self.persistObjectDirectory.seek(dataStream: &dataStream, to: handoutMasterPersistIdRef)
            
            /// 4. Read the HandoutContainer record at the current offset. Let this record be a live record.
            self.handoutMasterSlide = try HandoutContainer(dataStream: &dataStream)
        }
        
        /// Part 5: Identify the main master slide and title master slide persist objects.
        /// 1. Read the MasterListWithTextContainer record specified by the masterList field of the DocumentContainer record identified in step 4 of
        /// Part 2.
        let masterList = documentContainer.masterList
        
        /// 2. Read the first MasterPersistAtom (section 2.4.14.2) child record of the MasterListWithTextContainer record identified in step 1.
        var masterSlides: [MasterOrSlideContainer] = []
        for masterPersistAtom in masterList.rgMasterPersistAtom {
            /// 3. Lookup the value of the persistIdRef field of the MasterPersistAtom record previously identified in the persist object directory
            /// constructed in step 8 of Part 1 to find the stream offset of a persist object.
            /// 4. Seek to the stream offset specified in step 3.
            try self.persistObjectDirectory.seek(dataStream: &dataStream, to: masterPersistAtom.persistIdRef)
            
            /// 5. Read the MasterOrSlideContainer record at the current offset. Let this record be a live record.
            masterSlides.append(try MasterOrSlideContainer(dataStream: &dataStream))
            
            /// 6. Repeat steps 3 through 5 for each MasterPersistAtom child record of the MasterListWithTextContainer record identified in step 1.
        }
        
        self.masterSlides = masterSlides
        
        /// Part 6: Identify the presentation slide persist objects.
        /// 1. Read the SlideListWithTextContainer record (section 2.4.14.3), if present, specified by the slideList field of the DocumentContainer
        /// record identified in step 4 of Part 2. If not present, skip to step 1 of Part 7.
        if let slideListWithTextContainer = documentContainer.slideList {
            var presentationSlides: [SlideContainer] = []

            /// 2. Read the first SlidePersistAtom (section 2.4.14.5) child record of the SlideListWithTextContainer record identified in step 1.
            for child in slideListWithTextContainer.rgChildRec {
                guard case let .slidePersistAtom(data: slidePersistAtom) = child else {
                    continue
                }
                
                /// 3. Lookup the value of the persistIdRef field of the SlidePersistAtom record (section 2.4.14.5) previously identified in the persist
                /// object directory constructed in step 8 of Part 1 to find the stream offset of a persist object.
                /// 4. Seek to the stream offset specified in step 3.
                try self.persistObjectDirectory.seek(dataStream: &dataStream, to: slidePersistAtom.persistIdRef)
                
                /// 5. Read the SlideContainer record at the current offset. Let this record be a live record.
                presentationSlides.append(try SlideContainer(dataStream: &dataStream))
                
                /// 6. Repeat steps 3 through 5 for each SlidePersistAtom child record (section 2.4.14.5) of the SlideListWithTextContainer record
                /// identified in step 1.
            }
            
            self.presentationSlides = presentationSlides
        } else {
            self.presentationSlides = []
        }
        
        /// Part 7: Identify the notes slide persist objects.
        /// 1. Read the NotesListWithTextContainer record (section 2.4.14.6), if present, specified by the notesList field of the DocumentContainer
        /// record identified in step 4 of Part 2. If not present, skip to step 1 of Part 8.
        if let notesListWithTextContainer = documentContainer.notesList {
            var notesSlides: [NotesContainer] = []
        
            /// 2. Read the first NotesPersistAtom (section 2.4.14.7) child record of the NotesListWithTextContainer record identified in step 1.
            for notesPersistAtom in notesListWithTextContainer.rgNotesPersistAtom {
                /// 3. Lookup the value of the persistIdRef field of the NotesPersistAtom record previously identified in the persist object directory
                /// constructed in step 8 of Part 1 to find the stream offset of a persist object.
                /// 4. Seek to the stream offset specified in step 3.
                try self.persistObjectDirectory.seek(dataStream: &dataStream, to: notesPersistAtom.persistIdRef)
        
                /// 5. Read the NotesContainer record at the current offset. Let this record be a live record.
                notesSlides.append(try NotesContainer(dataStream: &dataStream))
                
                /// 6. Repeat steps 3 through 5 for each NotesPersistAtom child record of the NotesListWithTextContainer record identified in step 1.
            }
            
            self.notesSlides = notesSlides
        } else {
            self.notesSlides = []
        }
        
        /// Part 8: Identify the ActiveX control persist objects.
        /// 1. Read the ExObjListContainer record (section 2.10.1), if present, specified by the exObjList field of the DocumentContainer record
        /// identified in step 4 of Part 2. If not present, skip to step 1 of Part 11.
        if let exObjListContainer = documentContainer.exObjList {
            var activeXControls: [ExControlStg] = []

            /// 2. Read the first, if any, ExControlContainer child record (section 2.10.10) of the ExObjListContainer record identified in step 1. If no such
            /// child record exists, skip to step 1 of Part 9.
            for child in exObjListContainer.rgChildRec {
                guard case let .externalOleControl(data: controlContainer) = child else {
                    continue
                }

                /// 3. Lookup the value of the exOleObjAtom.persistIdRef field of the ExControlContainer record previously identified in the persist
                /// object directory constructed in step 8 of Part 1 to find the stream offset of a persist object.
                /// 4. Seek to the stream offset specified in step 3.
                try self.persistObjectDirectory.seek(dataStream: &dataStream, to: controlContainer.exOleObjAtom.persistIdRef)
                
                /// 5. Read the ExControlStg record at the current offset. Let this record be a live record.
                activeXControls.append(try ExControlStg(dataStream: &dataStream))
                
                /// 6. Repeat steps 3 through 5 for each ExControlContainer child record of the ExObjListContainer record identified in step 1.
            }
            
            self.activeXControls = []
            
            var embeddedOleObjects: [ExOleObjStg] = []
            
            /// Part 9: Identify the embedded OLE object persist objects.
            /// 1. Read the first, if any, ExOleEmbedContainer child record (section 2.10.27) of the ExObjListContainer record identified in step 1
            /// of Part 8. If no such child record exists, skip to step 1 of Part 10.
            for child in exObjListContainer.rgChildRec {
                guard case let .externalOleEmbed(data: oleEmbedContainer) = child else {
                    continue
                }
            
                /// 2. Lookup the value of the exOleObjAtom.persistIdRef field of the ExOleEmbedContainer record previously identified in the
                /// persist object directory constructed in step 8 of Part 1 to find the stream offset of a persist object.
                /// 3. Seek to the stream offset specified in step 2.
                try self.persistObjectDirectory.seek(dataStream: &dataStream, to: oleEmbedContainer.exOleObjAtom.persistIdRef)
                
                /// 4. Read the ExOleObjStg record at the current offset. Let this record be a live record.
                embeddedOleObjects.append(try ExOleObjStg(dataStream: &dataStream))
                
                /// 5. Repeat steps 2 through 4 for each ExOleEmbedContainer child record of the ExObjListContainer record identified in step 1
                /// of Part 8.
            }
            
            self.embeddedOleObjects = embeddedOleObjects
            
            var linkedOleObjects: [ExOleObjStg] = []
            
            /// Part 10: Identify the linked OLE object persist objects.
            /// 1. Read the first, if any, ExOleLinkContainer child record (section 2.10.29) of the ExObjListContainer record identified in step 1 of
            /// Part 8. If no such child record exists, skip to step 1 of Part 11.
            for child in exObjListContainer.rgChildRec {
                guard case let .externalOleLink(data: oleLinkContainer) = child else {
                    continue
                }
            
                /// 2. Lookup the value of the exOleObjAtom.persistIdRef field of the ExOleLinkContainer record previously identified in the persist
                /// object directory constructed in step 8 of Part 1 to find the stream offset of a persist object.
                /// 3. Seek to the stream offset specified in step 2.
                try self.persistObjectDirectory.seek(dataStream: &dataStream, to: oleLinkContainer.exOleObjAtom.persistIdRef)
                
                /// 4. Read the ExOleObjStg record at the current offset. Let this record be a live record.
                let exOleObjStg = try ExOleObjStg(dataStream: &dataStream)
                linkedOleObjects.append(exOleObjStg)
                
                /// 5. Repeat steps 2 through 4 for each ExOleLinkContainer child record of the ExObjListContainer record identified in step 1 of
                /// Part 8.
            }
            
            self.linkedOleObjects = linkedOleObjects
        } else {
            self.activeXControls = []
            self.embeddedOleObjects = []
            self.linkedOleObjects = []
        }
        
        /// Part 11: Identify the VBA project persist object.
        /// 1. Read the DocInfoListContainer record (section 2.4.4), if present, specified by the docInfoList field of the DocumentContainer record
        /// identified in step 4 of Part 2. If not present, skip to step 6.
        if let docInfoListContainer = documentContainer.docInfoList {
            /// 2. Read the VBAInfoContainer (section 2.4.10) child record, if present, of the DocInfoListContainer record identified in step 1. If no such
            /// child record exists, skip to step 6.
            var vbaProject: VbaProjectStg?
            for child in docInfoListContainer.rgChildRec {
                guard case let .vbaInfo(data: vbaInfoContainer) = child else {
                    continue
                }
                guard !vbaInfoContainer.vbaInfoAtom.persistIdRef.isNullReference else {
                    continue
                }
            
                /// 3. Lookup the value of the vbaInfoAtom.persistIdRef field of the VBAInfoContainer record identified in step 2 in the persist
                /// object directory constructed in step 8 of Part 1 to find the stream offset of a persist object.
                /// 4. Seek to the stream offset specified in step 3.
                try self.persistObjectDirectory.seek(dataStream: &dataStream, to: vbaInfoContainer.vbaInfoAtom.persistIdRef)
                
                /// 5. Read the VbaProjectStg record at the current offset. Let this record be a live record.
                vbaProject = try VbaProjectStg(dataStream: &dataStream)
                
                /// 6. End of process. All live records have been identified.
                break
            }
            
            self.vbaProject = vbaProject
        } else {
            self.vbaProject = nil
        }
        
        /// Let a dead record be specified as any top-level record in this stream, or any descendant of a top-level record in this stream, that is not
        /// a live record.
        /// All uses of prescriptive terminology (MAY, SHOULD, MUST, SHOULD NOT, MUST NOT) in the specification of records in the following
        /// sections apply only to live records. The contents of all dead records are undefined and MUST be ignored.
    }
}
