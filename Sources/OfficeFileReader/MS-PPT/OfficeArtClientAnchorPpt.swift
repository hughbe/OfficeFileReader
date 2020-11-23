//
//  OfficeArtClientAnchorPpt.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.7.1 OfficeArtClientAnchor
/// An atom record that specifies the location of a shape.
public struct OfficeArtClientAnchorPpt {
    public let rh: OfficeArtRecordHeader
    public let clientAnchorData: OfficeArtClientAnchorData
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): An OfficeArtRecordHeader ([MS-ODRAW] section 2.2.1) that specifies the header for this record. Sub-fields are further
        /// specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be 0xF010.
        /// rh.recLen MUST be 0x00000008 or 0x00000010.
        let rh: OfficeArtRecordHeader = try OfficeArtRecordHeader(dataStream: &dataStream)
        guard rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard rh.recType == 0xF010 else {
            throw OfficeFileError.corrupted
        }
        guard rh.recLen == 0x00000008 || rh.recLen == 0x00000010 else {
            throw OfficeFileError.corrupted
        }
        
        self.rh = rh
        
        let startPosition = dataStream.position
        
        /// clientAnchorData (variable): An OfficeArtClientAnchorData structure that specifies the location.
        self.clientAnchorData = try OfficeArtClientAnchorData(dataStream: &dataStream, length: Int(self.rh.recLen))
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
