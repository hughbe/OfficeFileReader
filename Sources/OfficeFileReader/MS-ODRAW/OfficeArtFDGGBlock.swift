//
//  OfficeArtFDGGBlock.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.48 OfficeArtFDGGBlock
/// Referenced by: OfficeArtDggContainer
/// The OfficeArtFDGGBlock record specifies document-wide information about all of the drawings that have been saved in the file.
public struct OfficeArtFDGGBlock {
    public let rh: OfficeArtRecordHeader
    public let head: OfficeArtFDGG
    public let rgidcl: [OfficeArtIDCL]

    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): An OfficeArtRecordHeader structure, as defined in section 2.2.1, that specifies the header for this record. The following table
        /// specifies the subfields.
        /// Field Meaning
        /// rh.recVer A value that MUST be 0x0.
        /// rh.recInstance A value that MUST be 0x000.
        /// rh.recType A value that MUST be 0xF006.
        /// rh.recLen A value that MUST be 0x00000010 + ((head.cidcl - 1) * 0x00000008)
        self.rh = try OfficeArtRecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == 0xF006 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// head (16 bytes): An OfficeArtFDGG record, as defined in section 2.2.47, that specifies documentwide information.
        self.head = try OfficeArtFDGG(dataStream: &dataStream)
        
        /// Rgidcl (variable): An array of OfficeArtIDCL elements, as defined in section 2.2.46, specifying file identifier clusters that are used in the drawing.
        /// The number of elements in the array is specified by (head.cidcl – 1).
        var rgidcl: [OfficeArtIDCL] = []
        rgidcl.reserveCapacity(Int(self.head.cidcl - 1))
        for _ in 0..<self.head.cidcl - 1 {
            rgidcl.append(try OfficeArtIDCL(dataStream: &dataStream))
        }
        
        self.rgidcl = rgidcl
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
