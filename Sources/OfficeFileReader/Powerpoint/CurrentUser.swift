//
//  CurrentUser.swift
//  
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import CompoundFileReader

public struct CurrentUser {
    private let storage: CompoundFileStorage
    private let currentUserAtom: CurrentUserAtom
    
    public var userName: String { currentUserAtom.unicodeUserName?.value ?? currentUserAtom.ansiUserName.value }
    
    internal init(storage: CompoundFileStorage) throws {
        self.storage = storage
        
        var dataStream = storage.dataStream
        self.currentUserAtom = try CurrentUserAtom(dataStream: &dataStream, storageSize: dataStream.count)
    }
}
