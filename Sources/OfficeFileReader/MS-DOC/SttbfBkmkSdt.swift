//
//  SttbfBkmkSdt.swift
//
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.284 SttbfBkmkSdt
/// The SttbfBkmkSdt structure is an STTB whose strings are SDTI structures, each of which contains information about a structured document tag
/// bookmark in the document. The cData field size of this STTB is 4 bytes. This STTB is an extended STTB, which means that its cchData field
/// size is 2 bytes. There is no extra data appended to the strings of this STTB. In a document, the number of structured document tag bookmarks
/// MUST NOT exceed 0x7FFFFFFF.
public struct SttbfBkmkSdt {
    public let sttb: STTB<SDTI>
    
    public init(dataStream: inout DataStream) throws {
        /// The SttbfBkmkSdt structure is an STTB structure that has the following additional constraints on its field values:
        /// fExtend (2 bytes): This value MUST be 0xFFFF.
        /// cData (4 bytes): This value MUST NOT exceed 0x7FFFFFFF.
        /// cbExtra (2 bytes): This value MUST be 0.
        /// cchData (2 bytes): This value MUST be 0x000C.
        /// Data (variable): An SDTI. The size of this field is 2 * cchData bytes, incremented by the value of the cbPlaceholder of this SDTI plus the
        /// size, in bytes, of the fsdaparray of this SDTI.
        self.sttb = try STTB(dataStream: &dataStream, fourByteCData: true)
        if !self.sttb.fExtend {
            throw OfficeFileError.corrupted
        }
        if self.sttb.cData > 0x7FFFFFFF {
            throw OfficeFileError.corrupted
        }
        if self.sttb.cbExtra != 0 {
            throw OfficeFileError.corrupted
        }
        if self.sttb.cchData.contains(where: { $0 != 0x000C }) {
            throw OfficeFileError.corrupted
        }
    }
}
