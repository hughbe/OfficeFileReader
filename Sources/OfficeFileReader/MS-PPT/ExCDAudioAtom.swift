//
//  ExCDAudioAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.10.9 ExCDAudioAtom
/// Referenced by: ExCDAudioContainer
/// An atom record that specifies start and end information for a CD audio clip.
public struct ExCDAudioAtom {
    public let rh: RecordHeader
    public let start: TmsfTimeStruct
    public let end: TmsfTimeStruct
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_ExternalCdAudioAtom (section 2.13.24).
        /// rh.recLen MUST be 0x00000008.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .externalCdAudioAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000008 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// start (4 bytes): A TmsfTimeStruct structure that specifies the beginning of the CD audio clip. It MUST be less than or equal to the value
        /// specified by end.
        self.start = try TmsfTimeStruct(dataStream: &dataStream)
        
        /// end (4 bytes): A TmsfTimeStruct structure that specifies the end of the CD audio clip. It MUST be greater than or equal to the value specified
        /// by start.
        self.end = try TmsfTimeStruct(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
