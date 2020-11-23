//
//  Record.swift
//  
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

internal extension DataStream {
    mutating func peekRecordHeader() throws -> RecordHeader {
        let originalPosition = position
        let rh = try RecordHeader(dataStream: &self)
        position = originalPosition
        
        return rh
    }
    
    mutating func peekOfficeArtRecordHeader() throws -> OfficeArtRecordHeader {
        let originalPosition = position
        let rh = try OfficeArtRecordHeader(dataStream: &self)
        position = originalPosition
        
        return rh
    }
    
    mutating func skipUnknownRecords(startPosition: Int, length: Int, includeAny: Bool = false) throws {
        while position - startPosition < length {
            let rec = try peekRecordHeader()
            guard includeAny || rec.recType == .unknown else {
                break
            }
            
            position += Int(8 + rec.recLen)
        }
    }
}

