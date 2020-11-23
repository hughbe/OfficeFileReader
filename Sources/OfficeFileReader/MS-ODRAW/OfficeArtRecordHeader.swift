//
//  OfficeArtRecordHeader.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-DOC] 2.2.1 OfficeArtRecordHeader
/// Referenced by: OfficeArtBlipDIB, OfficeArtBlipEMF, OfficeArtBlipJPEG, OfficeArtBlipPICT, OfficeArtBlipPNG, OfficeArtBlipTIFF, OfficeArtBlipWMF,
/// OfficeArtBStoreContainer, OfficeArtChildAnchor, OfficeArtColorMRUContainer, OfficeArtDgContainer, OfficeArtDggContainer, OfficeArtFArcRule,
/// OfficeArtFBSE, OfficeArtFCalloutRule, OfficeArtFConnectorRule, OfficeArtFDG, OfficeArtFDGGBlock, OfficeArtFDGSL, OfficeArtFOPT,
/// OfficeArtFPSPL, OfficeArtFRITContainer, OfficeArtFSP, OfficeArtFSPGR, OfficeArtSecondaryFOPT, OfficeArtSolverContainer, OfficeArtSpContainer,
/// OfficeArtSpgrContainer, OfficeArtSplitMenuColorContainer, OfficeArtTertiaryFOPT
/// The OfficeArtRecordHeader record specifies the common record header for all the OfficeArt records.
public struct OfficeArtRecordHeader {
    public let recVer: UInt8
    public let recInstance: UInt16
    public let recType: UInt16
    public let recLen: UInt32
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// recVer (4 bits): An unsigned integer that specifies the version if the record is an atom. If the record is a container, this field MUST
        /// contain 0xF.
        self.recVer = UInt8(flags.readBits(count: 4))
        
        /// recInstance (12 bits): An unsigned integer that differentiates an atom from the other atoms that are contained in the record.
        self.recInstance = flags.readRemainingBits()
        
        /// recType (2 bytes): An unsigned integer that specifies the type of the record. This value MUST be from 0xF000 through 0xFFFF, inclusive.
        self.recType = try dataStream.read(endianess: .littleEndian)
        if self.recType < 0xF000 {
            throw OfficeFileError.corrupted
        }
        
        /// recLen (4 bytes): An unsigned integer that specifies the length, in bytes, of the record. If the record is an atom, this value specifies
        /// the length of the atom, excluding the header. If the record is a container, this value specifies the sum of the lengths of the atoms that the
        /// record contains, plus the length of the record header for each atom.
        self.recLen = try dataStream.read(endianess: .littleEndian)
    }
}
