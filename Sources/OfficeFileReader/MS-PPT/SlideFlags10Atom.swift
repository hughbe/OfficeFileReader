//
//  SlideFlags10Atom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.5.30 SlideFlags10Atom
/// Referenced by: PP10SlideBinaryTagExtension
/// An atom record that specifies slide-level flags.
public struct SlideFlags10Atom {
    public let rh: RecordHeader
    public let fPreserveMaster: Bool
    public let fOverrideMasterAnimation: Bool
    public let unused: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_SlideFlags10Atom.
        /// rh.recLen MUST be 0x00000004.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .slideFlags10Atom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000004 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fPreserveMaster (1 bit): A bit that specifies whether to preserve the main master slide or title master slide when there is no slide that
        /// follows it. It MUST be ignored if the slide is not a main master slide or title master slide.
        self.fPreserveMaster = flags.readBit()
        
        /// B - fOverrideMasterAnimation (1 bit): A bit that specifies whether the slide does not follow the animations on the main master slide or
        /// title master slide.
        self.fOverrideMasterAnimation = flags.readBit()
        
        /// unused (30 bits): Undefined and MUST be ignored.
        self.unused = flags.readRemainingBits()
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
