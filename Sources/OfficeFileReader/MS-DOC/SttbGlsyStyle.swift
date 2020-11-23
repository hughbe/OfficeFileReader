//
//  SttbGlsyStyle.swift
//
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.291 SttbGlsyStyle
/// The SttbGlsyStyle structure is an STTB structure in which the strings specify the names of the styles used by the AutoText and rich text AutoCorrect
/// items that are defined in the parallel SttbfGlsy. The extra data that is appended to each string in this STTB is an unsigned 8-bit integer that specifies
/// how many items use the style indicated by the string and that MUST be less than or equal to 0x32.
public struct SttbGlsyStyle {
    public let sttb: STTB<String>
    
    public init(dataStream: inout DataStream) throws {
        /// The SttbfGlsyStyle structure is an STTB with the following additional restrictions on its field values:
        /// fExtend (2 bytes): This value MUST be 0xFFFF.
        /// cbExtra (2 bytes): This value MUST be 0x0001.
        self.sttb = try STTB(dataStream: &dataStream)
        if !self.sttb.fExtend {
            throw OfficeFileError.corrupted
        }
        if self.sttb.cbExtra != 0x0001 {
            throw OfficeFileError.corrupted
        }
    }
}
