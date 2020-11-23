//
//  OfficeArtBStoreContainer.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.20 OfficeArtBStoreContainer
/// Referenced by: OfficeArtDggContainer
/// The OfficeArtBStoreContainer record specifies the container for all the BLIPs that are used in all the drawings associated with the parent
/// OfficeArtDggContainer record, as defined in section 2.2.12.
public struct OfficeArtBStoreContainer {
    public let rh: OfficeArtRecordHeader
    public let rgfb: [OfficeArtBStoreContainerFileBlock]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): An OfficeArtRecordHeader structure, as defined in section 2.2.1 that specifies the header for this record. The following table
        /// specifies the subfields.
        /// Field Meaning
        /// rh.recVer A value that MUST be 0xF.
        /// rh.recInstance An unsigned integer that specifies the number of contained OfficeArtBStoreContainerFileBlock records, as defined in
        /// section 2.2.22.
        /// rh.recType A value that MUST be 0xF001.
        /// rh.recLen An unsigned integer that specifies the number of bytes following the header that contain OfficeArtBStoreContainerFileBlock
        /// records. This value MUST be the size, in bytes, of rgfb.
        self.rh = try OfficeArtRecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == 0xF001 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// rgfb (variable): An array of OfficeArtBStoreContainerFileBlock records that specifies the BLIP data.
        var rgfb: [OfficeArtBStoreContainerFileBlock] = []
        while dataStream.position - startPosition < self.rh.recLen {
            rgfb.append(try OfficeArtBStoreContainerFileBlock(dataStream: &dataStream))
        }
        
        self.rgfb = rgfb
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
