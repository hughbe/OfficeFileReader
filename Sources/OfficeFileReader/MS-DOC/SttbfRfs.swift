//
//  SttbfRfs.swift
//
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.289 SttbfRfs
/// The SttbfRfs structure is an STTB structure that contains the strings for a mail merge. This structure SHOULD<246> contain 5 strings, and MUST contain
/// at least 4 strings, as shown in the following table. There is no extra data appended to the strings of this STTB.
public struct SttbfRfs {
    public let sttb: STTB<String>
    
    public init(dataStream: inout DataStream) throws {
        /// The SttbfRfs structure is an STTB structure that has the following additional restrictions on its field values:
        /// cData (2 bytes): This value MUST NOT exceed 0x7FF0.
        /// fExtend (2 bytes): This value MUST be 0xFFFF.
        /// cData (2 bytes): This value SHOULD<247> be 0x0005, and MUST be either 0x0005 or 0x0004.
        /// cbExtra (2 bytes): This value MUST be 0x0000.
        /// cchData0-4 (2 bytes): An unsigned integer that specifies the count of characters in the corresponding Data fields. This value MUST be less than
        /// 256.
        /// Data0 (variable): A Unicode string that specifies the connection string to the mail merge data source. This string MUST be identical to the string
        /// with id=0x0000 inside ODSOPropertyBase, if neither of these two strings is empty.
        /// Data1 (variable): A Unicode string that specifies the connection string to the source for the field names of the mail merge data. This string MUST
        /// be empty if the field names are from the same data source as Data0.
        /// Data2 (variable): A Unicode string that specifies the e-mail subject line if the mail merge is for email.
        /// Data3 (variable): A Unicode string that specifies the name of the data column that contains either email addresses, if the mail merge is for e-mail, or fax numbers, if the mail merge is for fax.
        /// Data4 (variable): This value MUST be ignored.
        self.sttb = try STTB(dataStream: &dataStream)
        if self.sttb.cData > 0x7FF0 {
            throw OfficeFileError.corrupted
        }
        if !self.sttb.fExtend {
            throw OfficeFileError.corrupted
        }
        if self.sttb.cData != 0x0005 && self.sttb.cData != 0x0004 {
            throw OfficeFileError.corrupted
        }
        if self.sttb.cbExtra != 0x0000 {
            throw OfficeFileError.corrupted
        }
    }
}
