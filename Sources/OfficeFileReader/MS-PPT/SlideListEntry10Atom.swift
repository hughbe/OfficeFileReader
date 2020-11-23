//
//  SlideListEntry10Atom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.20.4 SlideListEntry10Atom
/// Referenced by: SlideListTable10Container
/// An atom record that specifies the creation time of a presentation slide in the document that contains this SlideListEntry10Atom record.
public struct SlideListEntry10Atom {
    public let rh: RecordHeader
    public let slideIdRef: SlideIdRef
    public let dwHighDateTime: UInt32
    public let dwLowDateTime: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_SlideListEntry10Atom.
        /// rh.recLen MUST be 0x0000000C.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .slideListEntry10Atom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x000000C else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// slideIdRef (4 bytes): A SlideIdRef (section 2.2.25) that specifies the presentation slide. Its creation time is specified by the dwHighDateTime
        /// and dwLowDateTime fields of this SlideListEntry10Atom record.
        self.slideIdRef = try dataStream.read(endianess: .littleEndian)
        
        /// dwHighDateTime (4 bytes): An unsigned integer that specifies the high-order part of the file time, as specified in [MS-DTYP] section 2.3.3.
        self.dwHighDateTime = try dataStream.read(endianess: .littleEndian)
        
        /// dwLowDateTime (4 bytes): An unsigned integer that specifies the low-order part of the file time, as specified in [MS-DTYP] section 2.3.3.
        self.dwLowDateTime = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
