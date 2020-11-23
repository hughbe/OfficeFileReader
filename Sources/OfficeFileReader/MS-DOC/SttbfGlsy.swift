//
//  SttbfGlsy.swift
//
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.287 SttbfGlsy
/// The SttbfGlsy structure is an STTB structure in which the strings specify the names of the AutoText and rich text AutoCorrect items that are defined
/// in this document. These names correspond to their respective entries in the parallel PlcfGlsy. Each string in this STTB MUST have no more than 32
/// characters. The extra data that is appended to each string of this STTB is a LEGOXTR_V11, which specifies additional data about the item with
/// which the string is associated.
public struct SttbfGlsy {
    public let sttb: STTB<String>
    
    public init(dataStream: inout DataStream) throws {
        /// The SttbfGlsy structure is an STTB with the following additional restrictions on its field values:
        /// fExtend (2 bytes): This value MUST be 0xFFFF.
        /// cbExtra (2 bytes): This value MUST be 0x0004.
        /// cchData (2 bytes): This value MUST be less than or equal to 32.
        self.sttb = try STTB(dataStream: &dataStream)
        if !self.sttb.fExtend {
            throw OfficeFileError.corrupted
        }
        if self.sttb.cbExtra != 0x0004 {
            throw OfficeFileError.corrupted
        }
        if self.sttb.cchData.contains(where: { $0 > 32 }) {
            throw OfficeFileError.corrupted
        }
    }
}
