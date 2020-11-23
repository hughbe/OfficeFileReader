//
//  OfficeArtFPSPL.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.37 OfficeArtFPSPL
/// Referenced by: OfficeArtSpContainer
/// The OfficeArtFPSPL record specifies the former hierarchical position of the containing object that is either a shape or a group of shapes. This record
/// MUST be present only if the OfficeArtFSP record, as defined in section 2.2.40, of the containing OfficeArtSpContainer, as defined in section 2.2.14,
/// has a value of 0x1 for fDeleted and a value of 0x0 for fChild. This record’s containing object was formerly subsequent or antecedent to the object
/// that is referenced by spid, as a member of the container directly containing that object. This record MAY<9> be used in some documents. If spid
/// equals zero or specifies the containing shape, this record MUST be ignored.
public struct OfficeArtFPSPL {
    public let rh: OfficeArtRecordHeader
    public let spid: MSOSPID
    public let reserved1: Bool
    public let fLast: Bool
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): An OfficeArtRecordHeader structure, as defined in section 2.2.1, that specifies the header for this record. The following table
        /// specifies the subfields.
        /// Field Meaning
        /// rh.recVer A value that MUST be 0x0.
        /// rh.recInstance A value that MUST be 0x000.
        /// rh.recType A value that MUST be 0xF11D.
        /// rh.recLen A value that MUST be 0x00000004.
        self.rh = try OfficeArtRecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == 0xF11D else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000004 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// spid (30 bits): An MSOSPID structure, as defined in section 2.1.2, that specifies another shape or group of shapes that is contained
        /// in the same OfficeArtDgContainer record, as defined in section 2.2.13. This other object contains an OfficeArtFSP record, as defined
        /// in section 2.2.40, with an equivalently valued spid field.
        self.spid = flags.readBits(count: 30)
        
        /// A - reserved1 (1 bit): A value that MUST be zero and MUST be ignored.
        self.reserved1 = flags.readBit()
        
        /// B - fLast (1 bit): A bit that specifies the ordering of this record’s containing object and the object that is specified by spid. The following
        /// table specifies the meaning of each value for this bit.
        /// Value Meaning
        /// 0 This record’s containing object was formerly antecedent to the object that is referenced by spid, in the container directly containing
        /// that object.
        /// 1 This record’s containing object was formerly subsequent to the object that is referenced by spid, in the container directly containing
        /// that object.
        self.fLast = flags.readBit()
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
