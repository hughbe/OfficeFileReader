//
//  ExCDAudioContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.10.8 ExCDAudioContainer
/// Referenced by: ExObjListSubContainer
/// A container record that specifies information about compact disc (CD) audio.
public struct ExCDAudioContainer {
    public let rh: RecordHeader
    public let exMediaAtom: ExMediaAtom
    public let exCDAudioAtom: ExCDAudioAtom
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_ExternalCdAudio.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .externalCdAudio else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// exMediaAtom (16 bytes): An ExMediaAtom record (section 2.10.6) that specifies information about the CD audio.
        self.exMediaAtom = try ExMediaAtom(dataStream: &dataStream)
        
        /// exCDAudioAtom (16 bytes): An ExCDAudioAtom record that specifies start and end information for the CD audio.
        self.exCDAudioAtom = try ExCDAudioAtom(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
