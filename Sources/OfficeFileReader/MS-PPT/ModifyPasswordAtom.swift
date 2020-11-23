//
//  ModifyPasswordAtom.swift
//
//
//  Created by Hugh Bellamy on 17/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.7 ModifyPasswordAtom
/// Referenced by: PP10DocBinaryTagExtension
/// An atom record that specifies a password used to modify the document.
/// Files with a modify password MUST be encrypted as specified in [MS-OFFCRYPTO] section 2.4.2.3. An application only grants modify access to
/// the presentation if a user provided password matches the modifyPassword field.
public struct ModifyPasswordAtom {
    public let rh: RecordHeader
    public let modifyPassword: PrintableUnicodeString
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recInstance MUST be 0x003.
        /// rh.recType MUST be RT_CString (section 2.13.24).
        /// rh.recLen MUST be an even number. It MUST be less than or equal to 510.
        let rh = try RecordHeader(dataStream: &dataStream)
        guard rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard rh.recInstance == 0x003 else {
            throw OfficeFileError.corrupted
        }
        guard rh.recType == .cString else {
            throw OfficeFileError.corrupted
        }
        guard (rh.recLen % 2) == 0 && rh.recLen <= 510 else {
            throw OfficeFileError.corrupted
        }
        
        self.rh = rh
        
        let startPosition = dataStream.position

        /// modifyPassword (variable): A PrintableUnicodeString (section 2.2.23) that specifies a password used to modify the document. The length,
        /// in bytes, of the field is specified by rh.recLen.
        self.modifyPassword = try PrintableUnicodeString(dataStream: &dataStream, byteCount: Int(self.rh.recLen))
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}

