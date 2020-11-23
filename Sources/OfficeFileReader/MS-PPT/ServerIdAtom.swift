//
//  ServerIdAtom.swift
//
//
//  Created by Hugh Bellamy on 17/11/2020.
//

import DataStream

/// [MS-PPT] 2.11.24 ServerIdAtom
/// Referenced by: RoundTripSlideSyncInfo12Container
/// An atom record that specifies a unique identifier for a slide in a slide library.
public struct ServerIdAtom {
    public let rh: RecordHeader
    public let serverId: PrintableUnicodeString
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_CString (section 2.13.24).
        /// rh.recLen MUST be even.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .cString else {
            throw OfficeFileError.corrupted
        }
        guard (self.rh.recLen % 2) == 0 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// serverId (variable): A PrintableUnicodeString (section 2.2.23) that specifies the unique identifier for the slide. This field is equivalent to the
        /// serverSldId attribute specified in [ECMA-376] Part 4: Markup Language Reference, section 4.7.1.
        self.serverId = try PrintableUnicodeString(dataStream: &dataStream, byteCount: Int(self.rh.recLen))
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}

