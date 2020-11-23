//
//  MasterPersistAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.14.2 MasterPersistAtom
/// Referenced by: MasterListWithTextContainer
/// An atom record that specifies a reference to a main master slide or title master slide.
public struct MasterPersistAtom {
    public let rh: RecordHeader
    public let persistIdRef: PersistIdRef
    public let reserved1: UInt8
    public let fNonOutlineData: Bool
    public let reserved2: UInt32
    public let reserved3: UInt32
    public let masterId: MasterId
    public let reserved4: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_SlidePersistAtom.
        /// rh.recLen MUST be 0x00000014.
        let rh = try RecordHeader(dataStream: &dataStream)
        guard rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard rh.recType == .slidePersistAtom else {
            throw OfficeFileError.corrupted
        }
        guard rh.recLen == 0x00000014 else {
            throw OfficeFileError.corrupted
        }
        
        self.rh = rh
        
        let startPosition = dataStream.position

        /// persistIdRef (4 bytes): A PersistIdRef (section 2.2.21) that specifies the value to look up in the persist object directory to find the offset of
        /// the MainMasterContainer record (section 2.5.3) for a main master slide or a SlideContainer record (section 2.5.1) for a title master slide.
        self.persistIdRef = try dataStream.read(endianess: .littleEndian)
        
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - reserved1 (2 bits): MUST be zero and MUST be ignored.
        self.reserved1 = UInt8(flags.readBits(count: 2))
        
        /// B - fNonOutlineData (1 bit): A bit that specifies whether the main master slide or title master slide specified by the persistIdRef field contains
        /// data other than text in a placeholder shape.
        self.fNonOutlineData = flags.readBit()
        
        /// reserved2 (29 bits): MUST be zero and MUST be ignored.
        self.reserved2 = flags.readRemainingBits()
        
        /// reserved3 (4 bytes): MUST be zero and MUST be ignored.
        self.reserved3 = try dataStream.read(endianess: .littleEndian)
        
        /// masterId (4 bytes): A MasterId that specifies the identifier for the main master slide or title master slide specified by the persistIdRef field.
        self.masterId = try MasterId(dataStream: &dataStream)
        
        /// reserved4 (4 bytes): MUST be zero and MUST be ignored.
        self.reserved4 = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
