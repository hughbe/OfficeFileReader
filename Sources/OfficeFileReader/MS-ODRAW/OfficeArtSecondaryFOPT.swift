//
//  OfficeArtSecondaryFOPT.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.10 OfficeArtSecondaryFOPT
/// Referenced by: OfficeArtSpContainer
/// The OfficeArtSecondaryFOPT record specifies a table of OfficeArtRGFOPTE records, as defined in section 2.3.1. The Blip:movie property can
/// be specified in this table.
public struct OfficeArtSecondaryFOPT {
    public let rh: OfficeArtRecordHeader
    public let fopt: OfficeArtRGFOPTE
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): An OfficeArtRecordHeader structure, as defined in section 2.2.1, that specifies the header for this record. The following table
        /// specifies the subfields.:
        /// Field Meaning
        /// rh.recVer A value that MUST be 0x3.
        /// rh.recInstance An unsigned integer that specifies the number of properties in the table.
        /// rh.recType A value that MUST be 0xF121.
        /// rh.recLen An unsigned integer that specifies the number of bytes following the header that contain property records. This value equals
        /// the number of properties multiplied by the size of the OfficeArtFOPTE type, as defined in section 2.2.7, plus the size of the complex
        /// property data.
        self.rh = try OfficeArtRecordHeader(dataStream: &dataStream)
        if self.rh.recVer != 0x3 {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == 0xF121 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
                
        /// fopt (variable): The OfficeArtRGFOPTE record, as defined in section 2.3.1, table that specifies the property data.
        self.fopt = try OfficeArtRGFOPTE(dataStream: &dataStream, count: Int(self.rh.recLen))
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
