//
//  RoundTripOriginalMainMasterId12Atom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.11.20 RoundTripOriginalMainMasterId12Atom
/// Referenced by: RoundTripMainMasterRecord
/// An atom record that specifies the original identifier of a <sldMaster> element in the Slide Master part that conforms to the schema specified by
/// CT_SlideMaster as specified in [ECMA-376] Part 4: Markup Language Reference, section 4.4.1.39.
public struct RoundTripOriginalMainMasterId12Atom {
    public let rh: RecordHeader
    public let mainMasterId: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_RoundTripOriginalMainMasterId12Atom.
        /// rh.recLen MUST be 0x00000004.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .roundTripOriginalMainMasterId12Atom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000004 else {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position

        /// mainMasterId (4 bytes): An unsigned integer that specifies the identifier of the main master slide. This field is equivalent to the ST_SlideMasterId
        /// simple type as specified in [ECMA-376] Part 4: Markup Language Reference, section 4.8.20.
        self.mainMasterId = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
