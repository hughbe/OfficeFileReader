//
//  RoundTripCompositeMasterId12Atom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.11.10 RoundTripCompositeMasterId12Atom
/// Referenced by: RoundTripMainMasterRecord, RoundTripSlideRecord
/// An atom record that specifies that a slide is a slide layout merged with its main master slide. The corresponding main master slide has a
/// RoundTripOriginalMainMasterId12Atom record with the same identifier.
public struct RoundTripCompositeMasterId12Atom {
    public let rh: RecordHeader
    public let compositeMasterId: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_RoundTripCompositeMasterId12Atom.
        /// rh.recLen MUST be 0x00000004.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .roundTripCompositeMasterId12Atom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000004 else {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position

        /// compositeMasterId (4 bytes): An unsigned integer that specifies the identifier for the main master slide this slide was merged with. This
        /// field is equivalent to the ST_SlideMasterId simple type as specified in [ECMA-376] Part 4: Markup Language Reference, section 4.8.20.
        self.compositeMasterId = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
