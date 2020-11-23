//
//  MenuNameAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.10.13 MenuNameAtom
/// Referenced by: ExControlContainer, ExOleEmbedContainer, ExOleLinkContainer
/// An atom record that specifies the short name of an OLE object or an ActiveX control.
public struct MenuNameAtom {
    public let rh: RecordHeader
    public let menuName: UnicodeString
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x001.
        /// rh.recType MUST be an RT_CString (section 2.13.24).
        /// rh.recLen MUST be even.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x001 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .cString else {
            throw OfficeFileError.corrupted
        }
        guard (self.rh.recLen % 2) == 0 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// menuName (variable): A UnicodeString that specifies the name. The length, in bytes, of the field is specified by rh.recLen.
        self.menuName = try UnicodeString(dataStream: &dataStream, byteCount: Int(self.rh.recLen))
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
