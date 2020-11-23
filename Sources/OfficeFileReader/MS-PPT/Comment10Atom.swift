//
//  Comment10Atom.swift
//
//
//  Created by Hugh Bellamy on 17/11/2020.
//

import DataStream

/// [MS-PPT] 2.5.29 Comment10Atom
/// Referenced by: Comment10Container
/// An atom record that specifies the settings for displaying a presentation comment. The presentation comment is specified by the Comment10Container
/// record that contains this Comment10Atom record.
public struct Comment10Atom {
    public let rh: RecordHeader
    public let index: Int32
    public let datetime: DateTimeStruct
    public let anchor: PointStruct
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_Comment10Atom.
        /// rh.recLen MUST be 0x0000001C.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .comment10Atom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x0000001C else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// index (4 bytes): A signed integer that specifies the index of the presentation comment. The index is part of the presentation comment label.
        /// It MUST be greater than or equal to zero.
        self.index = try dataStream.read(endianess: .littleEndian)
        guard self.index >= 0 else {
            throw OfficeFileError.corrupted
        }
        
        /// datetime (16 bytes): A DateTimeStruct structure that specifies the creation time of the presentation comment.
        self.datetime = try DateTimeStruct(dataStream: &dataStream)
        
        /// anchor (8 bytes): A PointStruct structure (section 2.12.5) that specifies the location of the presentation comment label in master units,
        /// relative to the top-left corner of the slide.
        self.anchor = try PointStruct(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}

