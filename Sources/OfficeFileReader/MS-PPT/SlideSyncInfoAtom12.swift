//
//  SlideSyncInfoAtom12.swift
//
//
//  Created by Hugh Bellamy on 17/11/2020.
//

import DataStream

/// [MS-PPT] 2.11.26 SlideSyncInfoAtom12
/// Referenced by: RoundTripSlideSyncInfo12Container
/// An atom record that specifies timestamps for a slide that synchronizes with a version of the slide stored in a slide library.
public struct SlideSyncInfoAtom12 {
    public let rh: RecordHeader
    public let dateTimeModified: DateTimeStruct
    public let dateTimeInserted: DateTimeStruct
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_RoundTripSlideSyncInfoAtom12.
        /// rh.recLen MUST be 0x00000020.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .roundTripSlideSyncInfoAtom12 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000020 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// dateTimeModified (16 bytes): A DateTimeStruct structure that specifies the time stamp the slide was last modified on the server. This field
        /// is equivalent to the serverSldModified attribute as specified in [ECMA-376] Part 4: Markup Language Reference, section 4.7.1.
        self.dateTimeModified = try DateTimeStruct(dataStream: &dataStream)
        
        /// dateTimeInserted (16 bytes): A DateTimeStruct structure that specifies the time stamp the slide was inserted in the document. This field is
        /// equivalent to the clientInsertedTime attribute as specified in [ECMA-376] Part 4: Markup Language Reference, section 4.7.1.
        self.dateTimeInserted = try DateTimeStruct(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}

