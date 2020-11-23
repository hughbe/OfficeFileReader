//
//  OfficeArtChildAnchor.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.39 OfficeArtChildAnchor
/// Referenced by: OfficeArtSpContainer
/// The OfficeArtChildAnchor record specifies four signed integers that specify the anchor for the shape that contains this record. For this record to
/// exist, the containing shape MUST be a member of a group of shapes. The four integers specify the offset from the origin of the coordinate system
/// that is specified by the OfficeArtFSPGR record, as defined in section 2.2.38, contained in the same OfficeArtSpgrContainer record, as defined in
/// section 2.2.16, that contains this record. The integers are in units of the coordinate system that is specified by the OfficeArtFSPGR.
public struct OfficeArtChildAnchor {
    public let rh: OfficeArtRecordHeader
    public let xLeft: Int32
    public let yTop: Int32
    public let xRight: Int32
    public let yBottom: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): An OfficeArtRecordHeader structure, as defined in section 2.2.1, that specifies the header for this record. The following table
        /// specifies the subfields.
        /// Field Meaning
        /// rh.recVer A value that MUST be 0x0.
        /// rh.recInstance A value that MUST be 0x000.
        /// rh.recType A value that MUST be 0xF00F.
        /// rh.recLen A value that MUST be 0x00000010.
        self.rh = try OfficeArtRecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == 0xF00F else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000010 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// xLeft (4 bytes): A signed integer that specifies the left offset for the shape that contains this record.
        self.xLeft = try dataStream.read(endianess: .littleEndian)
        
        /// yTop (4 bytes): A signed integer that specifies the top offset for the shape that contains this record.
        self.yTop = try dataStream.read(endianess: .littleEndian)
        
        /// xRight (4 bytes): A signed integer that specifies the right offset for the shape that contains this record.
        self.xRight = try dataStream.read(endianess: .littleEndian)
        
        /// yBottom (4 bytes): A signed integer that specifies the bottom offset for the shape that contains this record.
        self.yBottom = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
