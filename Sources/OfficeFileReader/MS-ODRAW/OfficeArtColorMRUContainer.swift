//
//  OfficeArtColorMRUContainer.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.43 OfficeArtColorMRUContainer
/// Referenced by: OfficeArtDggContainer
/// The OfficeArtColorMRUContainer record specifies the most recently used custom colors.
public struct OfficeArtColorMRUContainer {
    public let rh: OfficeArtRecordHeader
    public let rgmsocr: [MSOCR]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): An OfficeArtRecordHeader structure, as defined in section 2.2.1 that specifies the header for this record. The following table
        /// specifies the subfields.
        /// Field Meaning
        /// rh.recVer A value that MUST be 0x0.
        /// rh.recInstance An unsigned integer that specifies the number of contained MSOCR records, as defined in section 2.2.44.
        /// rh.recType A value that MUST be 0xF11A.
        /// rh.recLen An unsigned integer that specifies the number of bytes following the header that contain MSOCR records. This value MUST be
        /// the size, in bytes, of rgmsocr.
        self.rh = try OfficeArtRecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == 0xF11A else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// rgmsocr (variable): An array of MSOCR elements, as defined in section 2.2.44, that specifies the most recently used custom colors.
        var rgmsocr: [MSOCR] = []
        rgmsocr.reserveCapacity(Int(self.rh.recInstance))
        for _ in 0..<self.rh.recInstance {
            rgmsocr.append(try MSOCR(dataStream: &dataStream))
        }
        
        self.rgmsocr = rgmsocr
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
