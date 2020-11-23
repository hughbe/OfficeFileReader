//
//  FriendlyNameAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.10.18 FriendlyNameAtom
/// Referenced by: ExHyperlinkContainer
/// An atom record that specifies the user-readable name of a hyperlink.
public struct FriendlyNameAtom {
    public let rh: RecordHeader
    public let friendlyName: UnicodeString
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_CString (section 2.13.24).
        /// rh.recLen MUST be even.
        let rh = try RecordHeader(dataStream: &dataStream)
        guard rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard rh.recType == .cString else {
            throw OfficeFileError.corrupted
        }
        guard (rh.recLen % 2) == 0 else {
            throw OfficeFileError.corrupted
        }
        
        self.rh = rh
        
        let startPosition = dataStream.position

        /// friendlyName (variable): A UnicodeString that specifies the user-readable name. The length, in bytes, of the field is specified by rh.recLen.
        self.friendlyName = try UnicodeString(dataStream: &dataStream, byteCount: Int(self.rh.recLen))
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
