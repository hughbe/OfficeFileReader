//
//  UpxRm.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.339 UpxRm
/// The UpxRm structure specifies that the style was revision-marked, and the date and author of the revision. A revision-marked style contains
/// a set of formatting properties that specify the formatting of the style at the time that the style was modified for revision-marking.
public struct UpxRm {
    public let date: DTTM
    public let ibstAuthor: Int16
    
    public init(dataStream: inout DataStream) throws {
        /// date (4 bytes): A DTTM that specifies the date and time at which this style revision occurred.
        self.date = try DTTM(dataStream: &dataStream)
        
        /// ibstAuthor (2 bytes): A signed integer that specifies the index location of the string in the SttbfRMark string table that describes
        /// the author who modified the style.
        self.ibstAuthor = try dataStream.read(endianess: .littleEndian)
    }
}
