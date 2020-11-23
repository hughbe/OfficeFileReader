//
//  ExMCIMovieContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.10.25 ExMCIMovieContainer
/// Referenced by: ExObjListSubContainer
/// A container record that specifies information about a movie stored externally as a Media Control Interface (MCI) file.
public struct ExMCIMovieContainer {
    public let rh: RecordHeader
    public let exVideo: ExVideoContainer
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_ExternalMciMovie (section 2.13.24).
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .externalMciMovie else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// exVideo (variable): An ExVideoContainer record that specifies information about the MCI movie. 
        self.exVideo = try ExVideoContainer(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
