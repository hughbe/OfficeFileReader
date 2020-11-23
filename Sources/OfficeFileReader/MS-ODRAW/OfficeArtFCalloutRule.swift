//
//  OfficeArtFCalloutRule.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.34 OfficeArtFCalloutRule
/// Referenced by: OfficeArtSolverContainerFileBlock
/// The OfficeArtFCalloutRule record specifies a callout rule. One callout rule MUST exist per callout shape.
public struct OfficeArtFCalloutRule {
    public let rh: OfficeArtRecordHeader
    public let ruid: UInt32
    public let spid: MSOSPID
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): An OfficeArtRecordHeader structure, as defined in section 2.2.1, that specifies the header for this record. The following table
        /// specifies the subfields.
        /// Field Meaning
        /// rh.recVer A value that MUST be 0x0.
        /// rh.recInstance A value that MUST be 0x000.
        /// rh.recType A value that MUST be 0xF017.
        /// rh.recLen A value that MUST be 0x00000008.
        self.rh = try OfficeArtRecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == 0xF017 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000008 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// ruid (4 bytes): An unsigned integer that specifies the identifier of this rule.
        self.ruid = try dataStream.read(endianess: .littleEndian)
        
        /// spid (4 bytes): An MSOSPID structure, as defined in section 2.1.2, that specifies the identifier of the callout shape.
        self.spid = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
