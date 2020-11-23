//
//  UserEditAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.3.3 UserEditAtom
/// An atom record that specifies information about a user edit.
public struct UserEditAtom {
    public let rh: RecordHeader
    public let lastSlideIdRef: SlideIdRef
    public let version: UInt16
    public let minorVersion: UInt8
    public let majorVersion: UInt8
    public let offsetLastEdit: UInt32
    public let offsetPersistDirectory: UInt32
    public let docPersistIdRef: PersistIdRef
    public let persistIdSeed: UInt32
    public let lastView: ViewTypeEnum
    public let unused: UInt16
    public let encryptSessionPersistIdRef: PersistIdRef?
    
    public init(dataStream: inout DataStream) throws {
        let offset = dataStream.position
        
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_UserEditAtom (section 2.13.24).
        /// rh.recLen MUST be 0x0000001C or 0x00000020.
        let rh = try RecordHeader(dataStream: &dataStream)
        guard rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard rh.recType == .userEditAtom else {
            throw OfficeFileError.corrupted
        }
        guard rh.recLen == 0x0000001C || rh.recLen == 0x00000020 else {
            throw OfficeFileError.corrupted
        }
        
        self.rh = rh
        
        let startPosition = dataStream.position

        /// lastSlideIdRef (4 bytes): A SlideIdRef (section 2.2.25) that specifies the last slide viewed, if this is the last UserEditAtom record in the
        /// PowerPoint Document Stream (section 2.1.2). In all other cases the value of this field is undefined and MUST be ignored.
        self.lastSlideIdRef = try dataStream.read(endianess: .littleEndian)
        
        /// version (16 bits): An unsigned integer that specifies a build version of the executable that wrote the file. It SHOULD<9> be 0x0000 and
        /// MUST be ignored.
        self.version = try dataStream.read(endianess: .littleEndian)
        
        /// minorVersion (8 bits): An unsigned integer that specifies the minor version of the storage format. It MUST be 0x00.
        self.minorVersion = try dataStream.read()
        guard self.minorVersion == 0x00 else {
            throw OfficeFileError.corrupted
        }
        
        /// majorVersion (8 bits): An unsigned integer that specifies the major version of the storage format. It MUST be 0x03.
        self.majorVersion = try dataStream.read()
        guard self.majorVersion == 0x03 else {
            throw OfficeFileError.corrupted
        }
        
        /// offsetLastEdit (4 bytes): An unsigned integer that specifies an offset, in bytes, from the beginning of the PowerPoint Document Stream to a
        /// UserEditAtom record for the previous user edit. It MUST be less than the offset, in bytes, of this UserEditAtom record. The value 0x00000000
        /// specifies that no previous user edit exists.
        let offsetLastEdit: UInt32 = try dataStream.read(endianess: .littleEndian)
        guard offsetLastEdit < offset else {
            throw OfficeFileError.corrupted
        }
        
        self.offsetLastEdit = offsetLastEdit
        
        /// offsetPersistDirectory (4 bytes): An unsigned integer that specifies an offset, in bytes, from the beginning of the PowerPoint Document
        /// Stream to the PersistDirectoryAtom record (section 2.3.4) for this user edit. It MUST be greater than offsetLastEdit and less than the offset, in
        /// bytes, of this UserEditAtom record.
        let offsetPersistDirectory: UInt32 = try dataStream.read(endianess: .littleEndian)
        guard offsetPersistDirectory > offsetLastEdit && offsetPersistDirectory < offset else {
            throw OfficeFileError.corrupted
        }
        
        self.offsetPersistDirectory = offsetPersistDirectory
        
        /// docPersistIdRef (4 bytes): A PersistIdRef (section 2.2.21) that specifies the value to look up in the persist object directory to find the offset
        /// of the DocumentContainer record (section 2.4.1). It MUST be 0x00000001.
        self.docPersistIdRef = try dataStream.read(endianess: .littleEndian)
        guard self.docPersistIdRef == 0x00000001 else {
            throw OfficeFileError.corrupted
        }
        
        /// persistIdSeed (4 bytes): An unsigned integer that specifies a seed for creating a new persist object identifier. It MUST be greater than or
        /// equal to all persist object identifiers in the file as specified by the PersistDirectoryAtom records.
        self.persistIdSeed = try dataStream.read(endianess: .littleEndian)
        
        /// lastView (2 bytes): A ViewTypeEnum enumeration (section 2.13.42) that specifies the last view used to display the file.
        guard let lastView = ViewTypeEnum(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.lastView = lastView
        
        /// unused (2 bytes): Undefined and MUST be ignored.
        self.unused = try dataStream.read(endianess: .littleEndian)
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.encryptSessionPersistIdRef = nil
            return
        }
        
        /// encryptSessionPersistIdRef (4 bytes): An optional PersistIdRef that specifies the value to look up in the persist object directory to find the
        /// offset of the CryptSession10Container record (section 2.3.7). It MAY<10> be omitted. It MUST exist if the document is an encrypted
        /// document.
        self.encryptSessionPersistIdRef = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
