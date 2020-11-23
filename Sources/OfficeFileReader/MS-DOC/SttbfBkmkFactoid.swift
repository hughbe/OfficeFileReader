//
//  SttbfBkmkFactoid.swift
//
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.281 SttbfBkmkFactoid
/// The SttbfBkmkFactoid structure is an STTB whose strings are FACTOIDINFO structures, each of which contains information about a smart tag bookmark
/// in the document. The cData field size of this STTB is 2 bytes. This STTB is an extended STTB, meaning that its cchData field size is 2 bytes.
/// There is no extra data appended to the strings of this STTB. In a document, the number of smart tag bookmarks MUST NOT exceed 0x7FF0.
public struct SttbfBkmkFactoid {
    public let sttb: STTB<FACTOIDINFO>
    
    public init(dataStream: inout DataStream) throws {
        /// The SttbfBkmkFactoid structure is an STTB structure that has the following additional restrictions on its field values:
        /// fExtend (2 bytes): This value MUST be 0xFFFF.
        /// cData (2 bytes): This value MUST NOT exceed 0x7FF0.
        /// cbExtra (2 bytes): This value MUST be 0.
        /// cchData (2 bytes): This value MUST be 0x6
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
        if self.sttb.cchData.contains(where: { $0 != 0x6 }) {
            throw OfficeFileError.corrupted
        }
    }
}
