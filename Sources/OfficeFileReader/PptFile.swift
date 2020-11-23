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
    
    public init(data: Data) throws {
        self.compoundFile = try CompoundFile(data: data)
        print(self.compoundFile)
    }
    
    public lazy var currentUser: CurrentUser? = try? {
        guard let storage = self.compoundFile.rootStorage.children["Current User"] else {
            return nil
        }
        
        return try CurrentUser(storage: storage)
    }()
    
    public lazy var pictures: Pictures? = try? {
        guard let storage = self.compoundFile.rootStorage.children["Pictures"] else {
            return nil
        }
        
        return try Pictures(storage: storage)
    }()
    
    public lazy var powerPointDocumentStream: PowerPointDocumentStream? = try? {
        guard let storage = self.compoundFile.rootStorage.children["PowerPoint Document"] else {
            return nil
        }
        
        return try PowerPointDocumentStream(storage: storage)
    }()
}
