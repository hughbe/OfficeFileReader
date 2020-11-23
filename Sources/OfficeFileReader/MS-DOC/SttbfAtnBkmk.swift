//
//  SttbfAtnBkmk.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.277 SttbfAtnBkmk
/// The SttbfAtnBkmk structure is an STTB whose strings are all of zero length. The cData field size of this STTB is two bytes. Although this STTB contains no
/// strings, it is an extended STTB, meaning that its cchData field size is two bytes. The extra data that is appended to each string of this STTB is an ATNBE
/// which contains information about an annotation bookmark in the document. In a document, the number of annotation bookmarks MUST NOT exceed 0x3FFB.
public struct SttbfAtnBkmk {
    public let sttb: STTB<String>
    
    public init(dataStream: inout DataStream) throws {
        /// The SttbfAtnBkmk structure is an STTB structure that has the following additional restrictions on its field values:
        /// cbExtra (2 bytes): This value MUST be 0xA.
        /// cData (2 bytes): This value MUST NOT exceed 0x3FFC.
        /// cchData (2 bytes): This value MUST be 0.
        self.sttb = try STTB(dataStream: &dataStream)
        if self.sttb.cbExtra != 0xA {
            throw OfficeFileError.corrupted
        }
        if self.sttb.cData > 0x3FFC {
            throw OfficeFileError.corrupted
        }
        if self.sttb.cchData.contains(where: { $0 != 0 }) {
            throw OfficeFileError.corrupted
        }
    }
}
