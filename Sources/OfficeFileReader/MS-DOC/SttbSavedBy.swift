//
//  SttbSavedBy.swift
//
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.295 SttbSavedBy
/// The SttbSavedBy structure is an STTB structure that specifies the save history of this document. The strings in the STTB structure are arranged in pairs:
/// A string that specifies the name of the author who saved the document, followed by a string that specifies the path and name of the saved file. These
/// pairs are in order from the earliest saved file to the latest saved file. This STTB structure MUST have an even number of strings, and MUST have less than
/// or equal to 20 strings. There is no extra data appended to the strings of this STTB.
public struct SttbSavedBy {
    public let sttb: STTB<String>
    
    public init(dataStream: inout DataStream) throws {
        /// The SttbSavedBy structure is an STTB structure that has the following additional restrictions on its field values:
        /// fExtend (2 bytes): This value MUST be 0xFFFF.
        /// cData (2 bytes): This value MUST be even and MUST be less than or equal to 0x0014.
        /// cbExtra (2 bytes): This value MUST be 0x0000.
        self.sttb = try STTB(dataStream: &dataStream)
        if !self.sttb.fExtend {
            throw OfficeFileError.corrupted
        }
        if (self.sttb.cData % 2) != 0 || self.sttb.cData > 0x0014 {
            throw OfficeFileError.corrupted
        }
        if self.sttb.cbExtra != 0 {
            throw OfficeFileError.corrupted
        }
    }
}
