//
//  SlideTime10Atom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream
import WindowsDataTypes

/// [MS-PPT] 2.5.31 SlideTime10Atom
/// Referenced by: PP10SlideBinaryTagExtension
/// An atom record that specifies the slide creation time stamp.
public struct SlideTime10Atom {
    public let rh: RecordHeader
    public let fileTime: FILETIME
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_SlideTime10Atom.
        /// rh.recLen MUST be 0x00000008.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .slideTime10Atom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000008 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// fileTime (8 bytes): A FILETIME structure, as specified in [MS-DTYP] section 2.3.3, that specifies the time of slide creation.
        self.fileTime = try FILETIME(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
