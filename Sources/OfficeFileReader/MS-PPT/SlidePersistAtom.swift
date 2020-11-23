//
//  SlidePersistAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.14.5 SlidePersistAtom
/// Referenced by: SlideListWithTextSubContainerOrAtom
/// An atom record that specifies a reference to a presentation slide.
/// Let the corresponding slide be as specified by the persistIdRef field.
public struct SlidePersistAtom {
    public let rh: RecordHeader
    public let persistIdRef: PersistIdRef
    public let reserved1: Bool
    public let fShouldCollapse: Bool
    public let fNonOutlineData: Bool
    public let reserved2: UInt32
    public let cTexts: Int32
    public let slideId: SlideId
    public let reserved3: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_SlidePersistAtom.
        /// rh.recLen MUST be 0x00000014.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .slidePersistAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000014 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// persistIdRef (4 bytes): A PersistIdRef (section 2.2.21) that specifies the value to look up in the persist object directory to find the offset of
        /// the SlideContainer record (section 2.5.1) for a presentation slide.
        self.persistIdRef = try dataStream.read(endianess: .littleEndian)
        
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - reserved1 (1 bit): MUST be zero and MUST be ignored.
        self.reserved1 = flags.readBit()
        
        /// B - fShouldCollapse (1 bit): A bit that specifies whether the corresponding slide is collapsed.
        self.fShouldCollapse = flags.readBit()
        
        /// C - fNonOutlineData (1 bit): A bit that specifies whether the corresponding slide contains data other than text in a placeholder shape.
        self.fNonOutlineData = flags.readBit()
        
        /// reserved2 (29 bits): MUST be zero and MUST be ignored.
        self.reserved2 = flags.readRemainingBits()
        
        /// cTexts (4 bytes): A signed integer that specifies the number of text placeholder shapes on the corresponding slide. It MUST be greater than
        /// or equal to 0x00000000. It SHOULD be less than or equal to 0x00000005 and MUST be less than or equal to 0x00000008.
        let cTexts: Int32 = try dataStream.read(endianess: .littleEndian)
        guard cTexts >= 0x00000000 && cTexts <= 0x00000008 else {
            throw OfficeFileError.corrupted
        }
        
        self.cTexts = cTexts
        
        /// slideId (4 bytes): A SlideId that specifies the identifier for the corresponding slide.
        self.slideId = try SlideId(dataStream: &dataStream)
        
        /// reserved3 (4 bytes): MUST be zero and MUST be ignored.
        self.reserved3 = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
