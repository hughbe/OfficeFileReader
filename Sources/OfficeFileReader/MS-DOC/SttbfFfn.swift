//
//  SttbfFfn.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.286 SttbfFfn
/// The SttbfFfn structure is an STTB whose strings are FFN records that specify details of system fonts. Each font that is used in the document MUST
/// have an entry in this list. There is no extra data appended to the strings of this STTB. Each FFN MUST be completely and accurately filled out with
/// attributes that match the corresponding system font. This table MAY<245> contain fonts that are not referenced in the document.
public struct SttbfFfn {
    public let sttb: STTB<FFN>
    
    public init(dataStream: inout DataStream) throws {
        /// The SttbfFfn structure is a non-extended character STTB that has the following additional restrictions on its field values:
        /// cData (2 bytes): This value MUST NOT exceed 0x7FF0.
        /// cbExtra (2 bytes): This value MUST be 0.
        self.sttb = try STTB(dataStream: &dataStream)
        if self.sttb.cData > 0x7FF0 {
            throw OfficeFileError.corrupted
        }
        if self.sttb.cbExtra != 0 {
            throw OfficeFileError.corrupted
        }
    }
}
