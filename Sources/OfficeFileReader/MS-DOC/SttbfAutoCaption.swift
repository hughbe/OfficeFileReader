//
//  SttbfAutoCaption.swift
//
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.278 SttbfAutoCaption
/// The SttbfAutoCaption structure is an STTB that contains AutoCaption information. Each string is the ProgID of an OLE object that, when inserted into
/// the document, automatically has a caption inserted with it. The extra data which is appended to each string is an unsigned 16-bit integer that specifies
/// a zero-based index into SttbfCaption. The data at that index defines the caption that is inserted.
public struct SttbfAutoCaption {
    public let sttb: STTB<String>
    
    public init(dataStream: inout DataStream) throws {
        /// The SttbfAutoCaption structure is an STTB structure that has following additional restrictions on its field values:
        /// fExtend (2 bytes): This value MUST be 0xFFFF.
        /// cbExtra (2 bytes): This value MUST be 0x0002.
        self.sttb = try STTB(dataStream: &dataStream)
        if !self.sttb.fExtend {
            throw OfficeFileError.corrupted
        }
        if self.sttb.cbExtra != 0x0002 {
            throw OfficeFileError.corrupted
        }
    }
}
