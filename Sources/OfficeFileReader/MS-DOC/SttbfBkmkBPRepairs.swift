//
//  SttbfBkmkBPRepairs.swift
//
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.280 SttbfBkmkBPRepairs
/// The SttbfBkmkBPRepairs structure is an STTB structure whose strings specify the descriptions of repair bookmarks in the document. The cData field
/// size of this STTB structure is 2 bytes. The strings of this STTB structure contain extended (two-byte) characters, and there is no extra data appended
/// to them—in other words, it is equivalent to an SttbfBkmk. The strings of this table are not null-terminated. In a document, the number of repair bookmarks
/// MUST NOT exceed 0x7FF0.
public struct SttbfBkmkBPRepairs {
    public let sttb: STTB<String>
    
    public init(dataStream: inout DataStream) throws {
        /// The SttbfBkmkBPRepairs structure is an STTB structure with the following additional restrictions on its field values:
        /// fExtend (2 bytes): This value MUST be 0xFFFF.
        /// cData (2 bytes): This value MUST NOT exceed 0x7FF0.
        /// cbExtra (2 bytes): This value MUST be 0.
        self.sttb = try STTB(dataStream: &dataStream)
        if !self.sttb.fExtend {
            throw OfficeFileError.corrupted
        }
        if self.sttb.cData > 0x7FF0 {
            throw OfficeFileError.corrupted
        }
        if self.sttb.cbExtra != 0 {
            throw OfficeFileError.corrupted
        }
    }
}
