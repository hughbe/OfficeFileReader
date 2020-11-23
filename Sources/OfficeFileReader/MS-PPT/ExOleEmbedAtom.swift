//
//  ExOleEmbedAtom.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.10.28 ExOleEmbedAtom
/// Referenced by: ExOleEmbedContainer
/// An atom record that specifies preferences for embedding an OLE object.
public struct ExOleEmbedAtom {
    public let rh: RecordHeader
    public let exColorFollow: ExColorFollowEnum
    public let fCantLockServer: bool1
    public let fNoSizeToServer: bool1
    public let fIsTable: UInt8
    public let unused: UInt8
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_ExternalOleEmbedAtom.
        /// rh.recLen MUST be 0x00000008.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .externalOleEmbedAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000008 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// exColorFollow (4 bytes): An ExColorFollowEnum enumeration that specifies how the OLE object follows the color scheme of the containing
        /// document.
        guard let exColorFollow = ExColorFollowEnum(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.exColorFollow = exColorFollow
        
        /// fCantLockServer (1 byte): A bool1 (section 2.2.2) that specifies whether the OLE server for the embedded OLE object cannot be locked.
        self.fCantLockServer = try bool1(dataStream: &dataStream)
        
        /// fNoSizeToServer (1 byte): A byte that specifies whether sending the OLE object dimensions to the OLE server can be omitted. It
        /// SHOULD<108> be a value from the following table.
        /// Value Meaning
        /// 0x00 Do send the dimensions to the OLE server.
        /// 0x01 Do not send the dimension to the OLE server.
        self.fNoSizeToServer = try bool1(dataStream: &dataStream)
        
        /// fIsTable (1 byte): A bool1 that specifies whether the OLE object represents a table created by ProgID (described in [MSDN-COM])
        /// Word.Document. It SHOULD<109> be ignored.
        self.fIsTable = try dataStream.read()
        
        /// unused (1 byte): Undefined and MUST be ignored.
        self.unused = try dataStream.read()
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
