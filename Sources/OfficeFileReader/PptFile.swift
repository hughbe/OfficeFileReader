//
//  PptFile.swift
//
//
//  Created by Hugh Bellamy on 05/11/2020.
//

import CompoundFileReader
import DataStream
import Foundation

/// [MS-PPT] 2.1 File Streams and Storages
/// As an OLE compound file, this file format specification is organized as a hierarchy of storages and streams as specified in [MS-CFB]. The following
/// sections list the top-level storages and streams found in a file.
public class PptFile {
    public let compoundFile: CompoundFile
    public let currentUser: CurrentUser
    public let powerPointDocumentStream: PowerPointDocumentStream
    
    public init(data: Data) throws {
        self.compoundFile = try CompoundFile(data: data)
        
        /// [MS-PPT] 2.1.1 Current User Stream
        /// A required stream whose name MUST be "Current User".
        /// The contents of this stream are specified by the CurrentUserAtom record (section 2.3.2).
        guard let currentUserStorage = self.compoundFile.rootStorage.children["Current User"] else {
            throw OfficeFileError.corrupted
        }
        
        self.currentUser = try CurrentUser(storage: currentUserStorage)

        /// [MS-PPT] 2.1.2 PowerPoint Document Stream
        /// A required stream whose name MUST be "PowerPoint Document".
        /// Let a top-level record be specified as any one of the following: DocumentContainer (section 2.4.1), MasterOrSlideContainer (section 2.5.5),
        /// HandoutContainer (section 2.5.8), SlideContainer (section 2.5.1), NotesContainer (section 2.5.6), ExOleObjStg (section 2.10.34), ExControlStg
        /// (section 2.10.37), VbaProjectStg (section 2.10.40), PersistDirectoryAtom (section 2.3.4), or UserEditAtom (section 2.3.3) record.
        /// The contents of this stream are specified by a sequence of top-level records. Partial ordering restrictions on the record sequence are
        /// specified in the PersistDirectoryAtom and UserEditAtom records.
        /// As container records, the DocumentContainer, MainMasterContainer (section 2.5.3), HandoutContainer (section 2.5.8), SlideContainer
        /// (section 2.5.1), and NotesContainer (section 2.5.6) records are each the root of a tree of container records and atom records. Inside any
        /// container record, other records can exist that are not explicitly listed as child records. Unknown records are identified when the recType
        /// field of the RecordHeader structure (section 2.3.1) contains a value not specified by the RecordType enumeration (section 2.13.24). These
        /// unknown records, if encountered, MUST be ignored, and MAY<1> be preserved. Unknown records can be ignored by seeking forward
        /// recLen bytes from the end of the RecordHeader structure.
        /// Each time this stream is written, new top-level records, a user edit, can be appended to the existing stream, or the entire stream contents
        /// can be replaced with an updated sequence of top-level records. If the entire stream is not replaced, any previously existing top-level
        /// records that comprised any previous user edit, can be made obsolete by the subsequently appended top-level records that comprise the
        /// current user edit.
        /// Let a live record be specified as any top-level record in this stream, or any descendant of a top-level record in this stream, identified by the
        /// following process:
        guard let powerPointDocumentStreamStorage = self.compoundFile.rootStorage.children["PowerPoint Document"] else {
            throw OfficeFileError.corrupted
        }
        
        self.powerPointDocumentStream = try PowerPointDocumentStream(storage: powerPointDocumentStreamStorage, currentUser: currentUser)
    }
    
    public lazy var pictures: Pictures? = try? {
        guard let storage = self.compoundFile.rootStorage.children["Pictures"] else {
            return nil
        }
        
        return try Pictures(storage: storage)
    }()
}
