//
//  FileCharacterPosition.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

public struct FileCharacterPosition {
    public let dataPosition: UInt32
    public let compressed: Bool
    public let count: UInt32
    public let prls: [Prl]
    
    public var dataCount: UInt32 {
        return compressed ? dataPosition + count : dataPosition + count * 2
    }
}
