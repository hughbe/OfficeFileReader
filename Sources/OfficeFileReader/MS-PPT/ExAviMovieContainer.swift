//
//  ExAviMovieContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.10.4 ExAviMovieContainer
/// Referenced by: ExObjListSubContainer
/// A container record that specifies information about an AVI movie.
public struct ExAviMovieContainer {
    public let rh: RecordHeader
    public let exVideo: ExVideoContainer
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_ExternalAviMovie.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .externalAviMovie else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// exVideo (variable): An ExVideoContainer record that specifies information about the AVI movie.
        self.exVideo = try ExVideoContainer(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
