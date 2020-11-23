//
//  OfficeArtFDG.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.49 OfficeArtFDG
/// Referenced by: OfficeArtDgContainer
/// The OfficeArtFDG record specifies the number of shapes, the drawing identifier, and the shape identifier of the last shape in a drawing.
public struct OfficeArtFDG {
    public let rh: OfficeArtRecordHeader
    public let csp: UInt32
    public let spidCur: MSOSPID
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): An OfficeArtRecordHeader structure, as defined in section 2.2.1, that specifies the header for this record. The following table
        /// specifies the subfields.
        /// Field Meaning
        /// rh.recVer A value that MUST be 0x0.
        /// rh.recInstance A value that specifies the drawing identifier and that MUST be less than or equal to 0xFFE.
        /// rh.recType A value that MUST be 0xF008.
        /// rh.recLen A value that MUST be 0x00000008.
        self.rh = try OfficeArtRecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance <= 0xFFE else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == 0xF008 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000008 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// csp (4 bytes): An unsigned integer that specifies the number of shapes in this drawing.
        self.csp = try dataStream.read(endianess: .littleEndian)
        
        /// spidCur (4 bytes): An MSOSPID structure, as defined in section 2.1.2, that specifies the shape identifier of the last shape in this drawing.
        self.spidCur = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
