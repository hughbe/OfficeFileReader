//
//  SlideListTableSize10Atom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.20.3 SlideListTableSize10Atom
/// Referenced by: SlideListTable10Container
/// An atom record that specifies the count of the SlideListEntry10Atom records that are contained within the SlideListTable10Container record that
/// contains this SlideListTableSize10Atom record.
public struct SlideListTableSize10Atom {
    public let rh: RecordHeader
    public let count: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_SlideListTableSize10Atom.
        /// rh.recLen MUST be 0x00000004.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .slideListTableSize10Atom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x0000004 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// count (4 bytes): A signed integer that specifies the count of the rgSlideListEntryAtom field of the SlideListTable10Container record that
        /// contains this SlideListTableSize10Atom record. It MUST be greater than or equal to 0x00000000 and MUST be less than or equal to
        /// 0x000F4240.
        self.count = try dataStream.read(endianess: .littleEndian)
        guard self.count >= 0x00000000 && self.count <= 0x000F4240 else {
            throw OfficeFileError.corrupted
        }
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
