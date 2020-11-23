//
//  SttbfRMark.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.290 SttbfRMark
/// The SttbfRMark structure is an STTB structure where the strings specify the names of the authors of the revision marks, comments, and e-mail messages
/// in the document. There is no extra data appended to the strings of this STTB. The first entry MUST be "Unknown".
public struct SttbfRMark {
    public let sttb: STTB<String>
    
    public init(dataStream: inout DataStream) throws {
        /// The SttbfRMark structure is an STTB with the following additional restrictions on its field values:
        /// fExtend (2 bytes): This value MUST be 0xFFFF.
        /// cbExtra (2 bytes): This value MUST be 0.
        self.sttb = try STTB(dataStream: &dataStream)
        if !self.sttb.fExtend {
            throw OfficeFileError.corrupted
        }
        if self.sttb.cbExtra != 0 {
            throw OfficeFileError.corrupted
        }
    }
}
