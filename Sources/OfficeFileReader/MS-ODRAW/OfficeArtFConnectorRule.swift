//
//  OfficeArtFConnectorRule.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.36 OfficeArtFConnectorRule
/// Referenced by: OfficeArtSolverContainerFileBlock
/// The OfficeArtFConnectorRule record specifies the connection between two shapes that exists via a connector shape. This record MAY<8> be ignored.
public struct OfficeArtFConnectorRule {
    public let rh: OfficeArtRecordHeader
    public let ruid: UInt32
    public let spidA: MSOSPID
    public let spidB: MSOSPID
    public let spidC: MSOSPID
    public let cptiA: UInt32
    public let cptiB: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): An OfficeArtRecordHeader structure, as defined in section 2.2.1, that specifies the header for this record. The following table
        /// specifies the subfields.
        /// Field Meaning
        /// rh.recVer A value that MUST be 0x1.
        /// rh.recInstance A value that MUST be 0x000.
        /// rh.recType A value that MUST be 0xF012.
        /// rh.recLen A value that MUST be 0x00000018.
        self.rh = try OfficeArtRecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x1 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == 0xF012 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000018 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// ruid (4 bytes): An unsigned integer that specifies the identifier of this rule.
        self.ruid = try dataStream.read(endianess: .littleEndian)
        
        /// spidA (4 bytes): An MSOSPID structure, as defined in section 2.1.2, that specifies the identifier of the shape where the connector shape starts.
        self.spidA = try dataStream.read(endianess: .littleEndian)
        
        /// spidB (4 bytes): An MSOSPID structure, as defined in section 2.1.2, that specifies the identifier of the shape where the connector shape ends.
        self.spidB = try dataStream.read(endianess: .littleEndian)
        
        /// spidC (4 bytes): An MSOSPID structure, as defined in section 2.1.2, that specifies the identifier of the connector shape.
        self.spidC = try dataStream.read(endianess: .littleEndian)
        
        /// cptiA (4 bytes): An unsigned integer that specifies the connection site index of the shape where the connector shape starts. If the shape is
        /// available, this value MUST be within its range of valid connection site indexes. Otherwise, this value is ignored.
        self.cptiA = try dataStream.read(endianess: .littleEndian)
        
        /// cptiB (4 bytes): An unsigned integer that specifies the connection site index of the shape where the connector shape ends. If the shape is
        /// available, this value MUST be within its range of valid connection site indexes. Otherwise, this value is ignored.
        self.cptiB = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
