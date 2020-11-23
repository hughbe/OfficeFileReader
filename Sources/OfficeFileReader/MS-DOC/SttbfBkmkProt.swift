//
//  SttbfBkmkProt.swift
//
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.283 SttbfBkmkProt
/// The SttbfBkmkProt structure is an STTB whose strings are all of length zero. The cData field of this STTB is four bytes. Although this STTB contains no
/// strings, it is an extended STTB, which means that its cchData fields are two bytes in size. The extra data that is appended to each string of this STTB is
/// a PRTI which contains information about the range-level protection bookmarks in the document. In a document, the number of range-level protection
/// bookmarks MUST NOT exceed 0x00007FF0.
public struct SttbfBkmkProt {
    public let sttb: STTB<String>
    
    public init(dataStream: inout DataStream) throws {
        /// The SttbfBkmkProt structure is an STTB structure that has the following additional restrictions on its field values:
        /// fExtend (2 bytes): This value MUST be 0xFFFF.
        /// cData (4 bytes): This value MUST NOT exceed 0x00007FF0.
        /// cbExtra (2 bytes): This value MUST be 0x8.
        /// cchData (2 bytes): This value MUST be 0.
        /// ExtraData (8 bytes): A PRTI.
        self.sttb = try STTB(dataStream: &dataStream)
        if !self.sttb.fExtend {
            throw OfficeFileError.corrupted
        }
        if self.sttb.cData > 0x00007FF0 {
            throw OfficeFileError.corrupted
        }
        if self.sttb.cbExtra != 0x8 {
            throw OfficeFileError.corrupted
        }
        if self.sttb.cchData.contains(where: { $0 != 0 }) {
            throw OfficeFileError.corrupted
        }
    }
}
