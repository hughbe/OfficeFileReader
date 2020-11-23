//
//  RoundTripContentMasterId12Atom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.11.11 RoundTripContentMasterId12Atom
/// Referenced by: RoundTripSlideRecord
/// An atom record that specifies the relation between a slide and its slide layout.
public struct RoundTripContentMasterId12Atom {
    public let rh: RecordHeader
    public let mainMasterId: UInt32
    public let contentMasterInstanceId: UInt16
    public let unused: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recType MUST be an RT_RoundTripContentMasterId12Atom.
        /// rh.recLen MUST be 0x00000004.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .roundTripContentMasterId12Atom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000008 else {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position

        /// mainMasterId (4 bytes): An unsigned integer that specifies the identifier of a main master slide. This field is equivalent to the
        /// ST_SlideMasterId simple type as specified in [ECMA-376] Part 4: Markup Language Reference, section 4.8.20.
        self.mainMasterId = try dataStream.read(endianess: .littleEndian)
        
        /// contentMasterInstanceId (2 bytes): An unsigned integer that specifies the instance identifier of the slide layout. This field is equivalent to the
        /// ST_SlideLayoutId simple type as specified in [ECMA-376] Part 4: Markup Language Reference, section 4.8.18.
        self.contentMasterInstanceId = try dataStream.read(endianess: .littleEndian)
        
        /// unused (2 bytes): Undefined and MUST be ignored.
        self.unused = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
