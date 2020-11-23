//
//  SttbfBkmkFcc.swift
//
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.282 SttbfBkmkFcc
/// The SttbfBkmkFcc structure is an STTB whose strings are DPCID structures. Each DPCID contains information about a format consistency-checker
/// bookmark in the document. The cData field size of this STTB is 2 bytes. This STTB is an extended STTB, which means that its cchData field size is 2
/// bytes. There is no extra data appended to the strings of this STTB. In a document, the number of format consistency-checker bookmark elements MUST
/// NOT exceed 0x7FF0.
public struct SttbfBkmkFcc {
    public let sttb: STTB<DPCID>
    
    public init(dataStream: inout DataStream) throws {
        /// The SttbfBkmkFcc structure is an STTB structure that has the following additional restrictions on its field values:
        /// fExtend (2 bytes): This value MUST be 0xFFFF.
        /// cData (2 bytes): This value MUST NOT exceed 0x7FF0.
        /// cbExtra (2 bytes): This value MUST be 0.
        /// cchData (2 bytes): This value MUST be 0xA.
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
        if self.sttb.cchData.contains(where: { $0 != 0xA }) {
            throw OfficeFileError.corrupted
        }
    }
}
