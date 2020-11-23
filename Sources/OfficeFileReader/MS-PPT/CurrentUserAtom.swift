//
//  CurrentUserAtom.swift
//  
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.3.2 CurrentUserAtom
/// An atom record that specifies information about the last user to modify the file and where the most recent user edit is located. This is the only record in the
/// Current User Stream (section 2.1.1).
public struct CurrentUserAtom {
    public let rh: RecordHeader
    public let size: UInt32
    public let headerToken: UInt32
    public let offsetToCurrentEdit: UInt32
    public let lenUserName: UInt16
    public let docFileVersion: UInt16
    public let majorVersion: UInt8
    public let minorVersion: UInt8
    public let unused: UInt16
    public let ansiUserName: PrintableAnsiString
    public let relVersion: UInt32
    public let unicodeUserName: PrintableUnicodeString?
    
    public init(dataStream: inout DataStream, storageSize: Int) throws {
        let position = dataStream.position
        
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_CurrentUserAtom (section 2.13.24).
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .currentUserAtom else {
            throw OfficeFileError.corrupted
        }
        
        /// size (4 bytes): An unsigned integer that specifies the length, in bytes, of the fixed-length portion of the record, which begins after the rh field and
        /// ends before the ansiUserName field. It MUST be 0x00000014.
        self.size = try dataStream.read(endianess: .littleEndian)
        guard self.size == 0x00000014 else {
            throw OfficeFileError.corrupted
        }
        
        /// headerToken (4 bytes): An unsigned integer that specifies a token used to identify whether the file is encrypted. It MUST be a value from the
        /// following table.
        /// 0xE391C05F The file SHOULD NOT<6> be an encrypted document.
        /// 0xF3D1C4DF The file MUST be an encrypted document.
        let headerToken: UInt32 = try dataStream.read(endianess: .littleEndian)
        guard headerToken == 0xE391C05F || headerToken == 0xF3D1C4DF else {
            throw OfficeFileError.corrupted
        }
        
        self.headerToken = headerToken
        
        /// offsetToCurrentEdit (4 bytes): An unsigned integer that specifies an offset, in bytes, from the beginning of the PowerPoint Document Stream
        /// (section 2.1.2) to the UserEditAtom record (section 2.3.3) for the most recent user edit.
        self.offsetToCurrentEdit = try dataStream.read(endianess: .littleEndian)
        
        /// lenUserName (2 bytes): An unsigned integer that specifies the length, in bytes, of the ansiUserName field. It MUST be less than or equal to 255.
        self.lenUserName = try dataStream.read(endianess: .littleEndian)
        guard self.lenUserName <= 255 else {
            throw OfficeFileError.corrupted
        }
        
        /// docFileVersion (2 bytes): An unsigned integer that specifies the document file version of the file. It MUST be 0x03F4.
        self.docFileVersion = try dataStream.read(endianess: .littleEndian)
        guard self.docFileVersion == 0x03F4 else {
            throw OfficeFileError.corrupted
        }
        
        /// majorVersion (1 byte): An unsigned integer that specifies the major version of the storage format. It MUST be 0x03.
        self.majorVersion = try dataStream.read(endianess: .littleEndian)
        guard self.majorVersion == 0x03 else {
            throw OfficeFileError.corrupted
        }
        
        /// minorVersion (1 byte): An unsigned integer that specifies the minor version of the storage format. It MUST be 0x00.
        self.minorVersion = try dataStream.read(endianess: .littleEndian)
        guard self.minorVersion == 0x00 else {
            throw OfficeFileError.corrupted
        }
        
        /// unused (2 bytes): Undefined and MUST be ignored.
        self.unused = try dataStream.read(endianess: .littleEndian)
        
        /// ansiUserName (variable): A PrintableAnsiString (section 2.2.22) that specifies the user name of the last user to modify the file. The length, in bytes,
        /// of the field is specified by the lenUserName field.
        self.ansiUserName = try PrintableAnsiString(dataStream: &dataStream, byteCount: Int(self.lenUserName))
        
        /// relVersion (4 bytes): An unsigned integer that specifies the release version of the file format. It MUST be a value from the following table.
        /// Value Meaning
        /// 0x00000008 The file contains one or more main master slide.
        /// 0x00000009 The file contains more than one main master slide. It SHOULD NOT<7> be used
        let relVersion: UInt32 = try dataStream.read(endianess: .littleEndian)
        guard relVersion == 0x00000008 || relVersion == 0x00000009 else {
            throw OfficeFileError.corrupted
        }
        
        self.relVersion = relVersion
        
        if dataStream.position - position == storageSize {
            self.unicodeUserName = nil
            return
        }
        
        /// unicodeUserName (variable): An optional PrintableUnicodeString (section 2.2.23) that specifies the user name of the last user to modify the file.
        /// The length, in bytes, of the field is specified by 2 * lenUserName. This user name supersedes that specified by the ansiUserName field. It
        /// MAY<8> be omitted.
        self.unicodeUserName = try PrintableUnicodeString(dataStream: &dataStream, byteCount: Int(2 * self.lenUserName))
    }
}
