//
//  PowerPointDocumentStream.swift
//  
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import CompoundFileReader

public struct PowerPointDocumentStream {
    private let storage: CompoundFileStorage
    public let documentContainer: DocumentContainer?
    public let slides: [MasterOrSlideContainer]
    public let notes: [NotesContainer]
    public let handouts: [HandoutContainer]
    
    internal init(storage: CompoundFileStorage) throws {
        self.storage = storage
        
        var dataStream = storage.dataStream
        let startPosition = dataStream.position
        
        var documentContainer: DocumentContainer?
        var slides: [MasterOrSlideContainer] = []
        var notes: [NotesContainer] = []
        var handouts: [HandoutContainer] = []
        while dataStream.position - startPosition < dataStream.count {
            let position = dataStream.position
            let rh = try RecordHeader(dataStream: &dataStream)
            guard rh.recType != .end else {
                break
            }
            
            let startPosition = dataStream.position
            
            switch rh.recType {
            case .document:
                dataStream.position = position
                documentContainer = try DocumentContainer(dataStream: &dataStream)
            case .mainMaster, .slide:
                dataStream.position = position
                slides.append(try MasterOrSlideContainer(dataStream: &dataStream))
            case .notes:
                dataStream.position = position
                notes.append(try NotesContainer(dataStream: &dataStream))
            case .handout:
                dataStream.position = position
                handouts.append(try HandoutContainer(dataStream: &dataStream))
            case .persistDirectoryAtom:
                dataStream.position = position
                let _ = try PersistDirectoryAtom(dataStream: &dataStream)
            case .userEditAtom:
                dataStream.position = position
                let _ = try UserEditAtom(dataStream: &dataStream)
            case .externalOleObjectStg:
                dataStream.position = position
                let _ = try ExOleObjStg(dataStream: &dataStream)
            default:
                print("NYI: \(rh.recType)")
                dataStream.position += Int(rh.recLen)
            }
            
            guard dataStream.position - startPosition == rh.recLen else {
                throw OfficeFileError.corrupted
            }
        }
        
        self.documentContainer = documentContainer
        self.slides = slides
        self.notes = notes
        self.handouts = handouts
    }
}

