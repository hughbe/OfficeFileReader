//
//  SttbfCaption.swift
//
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.285 SttbfCaption
/// The SttbfCaption structure is an STTB structure that defines captions. Each string in this STTB structure is the label of a caption, and MUST
/// have less than or equal to 40 characters. The extra data appended to each string is a CAPI structure that specifies addition information about
/// the caption.
public struct SttbfCaption {
    public let sttb: STTB<String>
    
    public init(dataStream: inout DataStream) throws {
        /// The SttbfCaption structure is an STTB structure that has the following additional restrictions on its field values:
        /// fExtend (2 bytes): This value MUST be 0xFFFF.
        /// cbExtra (2 bytes): This value MUST be 0x0006.
        /// cchData (2 bytes): This value MUST be less than or equal to 40.
        self.sttb = try STTB(dataStream: &dataStream, fourByteCData: true)
        if !self.sttb.fExtend {
            throw OfficeFileError.corrupted
        }
        if self.sttb.cbExtra != 0x0006 {
            throw OfficeFileError.corrupted
        }
        if self.sttb.cchData.contains(where: { $0 > 40 }) {
            throw OfficeFileError.corrupted
        }
    }
}
