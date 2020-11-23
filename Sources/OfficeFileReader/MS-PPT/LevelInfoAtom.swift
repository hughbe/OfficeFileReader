//
//  LevelInfoAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.10 LevelInfoAtom
/// Referenced by: ParaBuildLevel
/// An atom record that specifies the level for a paragraph.
public struct LevelInfoAtom {
    public let rh: RecordHeader
    public let level: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_LevelInfoAtom.
        /// rh.recLen MUST be 0x00000004
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .levelInfoAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000004 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// level (4 bytes): An unsigned integer that specifies the paragraph level. It MUST be less than or equal to 0x00000009. It SHOULD<106>
        /// be less than or equal to 0x00000005.
        self.level = try dataStream.read(endianess: .littleEndian)
        guard self.level <= 0x00000009 else {
            throw OfficeFileError.corrupted
        }
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
