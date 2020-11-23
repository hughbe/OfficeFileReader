//
//  OfficeArtFRITContainer.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.41 OfficeArtFRITContainer
/// Referenced by: OfficeArtDgContainer
/// The OfficeArtFRITContainer record specifies a container for the table of group identifiers that are used for regrouping ungrouped shapes.
public struct OfficeArtFRITContainer {
    public let rh: OfficeArtRecordHeader
    public let rgfrit: [OfficeArtFRIT]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): An OfficeArtRecordHeader structure, as defined in section 2.2.1 that specifies the header for this record. The following table
        /// specifies the subfields.
        /// Field Meaning
        /// rh.recVer A value that MUST be 0x0.
        /// rh.recInstance An unsigned integer that specifies the number of contained OfficeArtFRIT records, as defined in section 2.2.42.
        /// rh.recType A value that MUST be 0xF118.
        /// rh.recLen An unsigned integer that specifies the number of bytes following the header that contain OfficeArtFRIT records. This value MUST be
        /// the size, in bytes, of rgfrit.
        self.rh = try OfficeArtRecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == 0xF118 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// rgfrit (variable): An array of OfficeArtFRIT records, as defined in section 2.2.42, that specifies the table of group identifiers. The size of the array
        /// MUST equal the value of rh.recInstance.
        var rgfrit: [OfficeArtFRIT] = []
        rgfrit.reserveCapacity(Int(self.rh.recInstance))
        for _ in 0..<self.rh.recInstance {
            rgfrit.append(try OfficeArtFRIT(dataStream: &dataStream))
        }
        
        self.rgfrit = rgfrit
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
