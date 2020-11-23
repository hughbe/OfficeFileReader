//
//  OfficeArtFSPGR.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.38 OfficeArtFSPGR
/// Referenced by: OfficeArtSpContainer
/// The OfficeArtFSPGR record specifies the coordinate system of the group shape that the anchors of the child shape are expressed in. This record is
/// present only for group shapes.
public struct OfficeArtFSPGR {
    public let rh: OfficeArtRecordHeader
    public let xLeft: Int32
    public let yTop: Int32
    public let xRight: Int32
    public let yBottom: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): An OfficeArtRecordHeader structure, as defined in section 2.2.1, that specifies the header for this record. The following table
        /// specifies the subfields.
        /// Field Meaning
        /// rh.recVer A value that MUST be 0x1.
        /// rh.recInstance A value that MUST be 0x000.
        /// rh.recType A value that MUST be 0xF009.
        /// rh.recLen A value that MUST be 0x00000010.
        self.rh = try OfficeArtRecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x1 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == 0xF009 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000010 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// xLeft (4 bytes): A signed integer that specifies the left boundary of the coordinate system of the group.
        self.xLeft = try dataStream.read(endianess: .littleEndian)
        
        /// yTop (4 bytes): A signed integer that specifies the top boundary of the coordinate system of the group.
        self.yTop = try dataStream.read(endianess: .littleEndian)
        
        /// xRight (4 bytes): A signed integer that specifies the right boundary of the coordinate system of the group.
        self.xRight = try dataStream.read(endianess: .littleEndian)
        
        /// yBottom (4 bytes): A signed integer that specifies the bottom boundary of the coordinate system of the group.
        self.yBottom = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
