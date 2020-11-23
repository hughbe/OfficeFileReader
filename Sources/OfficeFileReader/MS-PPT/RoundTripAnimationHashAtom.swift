//
//  RoundTripOriginalMainMasterId12Atom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.11.8 RoundTripAnimationHashAtom
/// Referenced by: RoundTripMainMasterRecord, RoundTripSlideRecord
/// An atom record that specifies a checksum for animation data
public struct RoundTripAnimationHashAtom {
    public let rh: RecordHeader
    public let animationChecksum: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_RoundTripAnimationHashAtom12Atom.
        /// rh.recLen MUST be 0x00000004.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .roundTripAnimationHashAtom12Atom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000004 else {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position

        /// animationChecksum (4 bytes): An unsigned integer that specifies the checksum of the animation data.
        /// Let corresponding slide be specified as the SlideContainer record (section 2.5.1) that contains this RoundTripAnimationHashAtom record.
        /// The data used to calculate the checksum is all fields in the VisualSoundAtom record contained within the corresponding slide, computed
        /// sequentially in 4-byte pieces. The other input to the checksum calculation is all of the bytes of the spid field of the OfficeArtFSP record
        /// ([MSODRAW] section 2.2.40) that specify the shape identifier of each shape on the corresponding slide. The checksum value is a cyclic
        /// redundancy check (CRC) logical exclusive or (XOR) hash of each consecutive 4-byte sequence in the specified data.
        self.animationChecksum = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
