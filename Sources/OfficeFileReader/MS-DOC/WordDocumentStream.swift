//
//  WordDocumentStream.swift
//  
//
//  Created by Hugh Bellamy on 05/11/2020.
//

import CompoundFileReader
import DataStream
import Foundation

/// [MS-DOC] 2.1.1 WordDocument Stream
/// The WordDocument stream MUST be present in the file and MUST have an FIB at offset 0. It also contains the document text and other
/// information referenced from other parts of the file. The stream has no predefined structure other than the FIB at the beginning.
/// In the context of Word Binary Files, the delay stream that is referenced in [MS-ODRAW] is the WordDocument stream.
/// The WordDocument stream MUST NOT be larger than 0x7FFFFFFF bytes.
public struct WordDocumentStream {
    public let storage: CompoundFileStorage
    public let data: Data
    public let fib: Fib
    
    public var dataStream: DataStream { DataStream(data: data) }
    
    public init(storage: CompoundFileStorage) throws {
        self.storage = storage
        self.data = storage.data
        
        var dataStream = DataStream(data: self.data)
        self.fib = try Fib(dataStream: &dataStream)
    }
}
