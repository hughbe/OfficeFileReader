//
//  Pictures.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import CompoundFileReader

public struct Pictures {
    private let storage: CompoundFileStorage
    private let bStoreDelay: OfficeArtBStoreDelay

    public var data: [OfficeArtBStoreContainerFileBlock] { bStoreDelay.rgfb }
    
    internal init(storage: CompoundFileStorage) throws {
        self.storage = storage
        
        var dataStream = storage.dataStream
        self.bStoreDelay = try OfficeArtBStoreDelay(dataStream: &dataStream, size: dataStream.count)
        if dataStream.remainingCount != 0 {
            throw OfficeFileError.corrupted
        }
    }
}
