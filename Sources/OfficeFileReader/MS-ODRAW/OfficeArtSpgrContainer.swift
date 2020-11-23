//
//  OfficeArtSpgrContainer.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.16 OfficeArtSpgrContainer
/// Referenced by: OfficeArtDgContainer, OfficeArtSpgrContainerFileBlock
/// The OfficeArtSpgrContainer record specifies a container for groups of shapes. The group container contains a variable number of shape containers and
/// other group containers. Each group is a shape.
/// The first container MUST be an OfficeArtSpContainer record, as defined in section 2.2.14, which MUST contain shape information for the group.
public struct OfficeArtSpgrContainer {
    public let rh: OfficeArtRecordHeader
    public let rgfb: [OfficeArtSpgrContainerFileBlock]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): An OfficeArtRecordHeader structure, as defined in section 2.2.1 that specifies the header for this record. The following table
        /// specifies the subfields.
        /// Field Meaning
        /// rh.recVer A value that MUST be 0xF.
        /// rh.recInstance A value that MUST be 0x000.
        /// rh.recType A value that MUST be 0xF003.
        /// rh.recLen An unsigned integer that specifies the number of bytes following the header that contain group or shape container records. This value
        /// MUST be the size, in bytes, of rgfb.
        self.rh = try OfficeArtRecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == 0xF003 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// rgfb (variable): An array of OfficeArtSpgrContainerFileBlock records, as defined in section 2.2.17, that specifies the groups or shapes that are
        /// contained within this group.
        var rgfb: [OfficeArtSpgrContainerFileBlock] = []
        while dataStream.position - startPosition < self.rh.recLen {
            rgfb.append(try OfficeArtSpgrContainerFileBlock(dataStream: &dataStream))
        }
        
        self.rgfb = rgfb
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
