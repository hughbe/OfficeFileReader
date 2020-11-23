//
//  ProgIDAtom.swift
//  
//
//  Created by Hugh Bellamy on 17/11/2020.
//

import DataStream

/// [MS-PPT] 2.10.14 ProgIDAtom
/// Referenced by: ExControlContainer, ExOleEmbedContainer, ExOleLinkContainer
/// An atom record that specifies the programmatic identifier of an OLE object or an ActiveX control.
/// A ProgID (described in [MSDN-COM]), a programmatic identifier, is a string that uniquely identifies a class.
public struct ProgIDAtom {
    public let rh: RecordHeader
    public let progId: PrintableUnicodeString
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x002.
        /// rh.recType MUST be an RT_CString (section 2.13.24).
        /// rh.recLen MUST be even.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x002 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .cString else {
            throw OfficeFileError.corrupted
        }
        guard (self.rh.recLen % 2) == 0 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// progId (variable): A PrintableUnicodeString (section 2.2.23) that specifies the ProgID. The length, in bytes, of the field is specified by rh.recLen.
        self.progId = try PrintableUnicodeString(dataStream: &dataStream, byteCount: Int(self.rh.recLen))
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}

