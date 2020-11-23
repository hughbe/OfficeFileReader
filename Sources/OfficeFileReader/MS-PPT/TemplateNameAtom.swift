//
//  TemplateNameAtom.swift
//
//
//  Created by Hugh Bellamy on 17/11/2020.
//

import DataStream

/// [MS-PPT] 2.5.18 TemplateNameAtom
/// Referenced by: MainMasterContainer
/// An atom record that specifies the name of a main master slide design
public struct TemplateNameAtom {
    public let rh: RecordHeader
    public let templateName: UnicodeString
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x002.
        /// rh.recType MUST be an RT_CString (section 2.13.24).
        /// rh.recLen MUST be an even number. It MUST be less than or equal to 4168.
        let rh = try RecordHeader(dataStream: &dataStream)
        guard rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard rh.recInstance == 0x002 else {
            throw OfficeFileError.corrupted
        }
        guard rh.recType == .cString else {
            throw OfficeFileError.corrupted
        }
        guard (rh.recLen % 2) == 0 && rh.recLen <= 4168 else {
            throw OfficeFileError.corrupted
        }
        
        self.rh = rh
        
        let startPosition = dataStream.position

        /// templateName (variable): A UnicodeString that specifies the name of a main master slide design. The length, in bytes, of the field is
        /// specified by rh.recLen.
        self.templateName = try UnicodeString(dataStream: &dataStream, byteCount: Int(self.rh.recLen))
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}

