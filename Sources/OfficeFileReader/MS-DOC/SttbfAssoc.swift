//
//  SttbfAssoc.swift
//
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.276 SttbfAssoc
/// The SttbfAssoc structure is an STTB that contains strings which are associated with this document.
public struct SttbfAssoc {
    public let sttb: STTB<String>
    
    public init(dataStream: inout DataStream) throws {
        /// This STTB MUST contain 18 strings. No extra data is appended to the strings of this STTB. Unless otherwise noted, each string in this STTB
        /// MUST contain no more than 255 characters. The indexes and meanings of these strings are as follows.
        /// Index Meaning
        /// 0x00 Unused. MUST be ignored.
        /// 0x01 The path of the associated document template, if it is not the default Normal template.
        /// 0x02 The title of the document. This MUST be ignored if title information, as specified in [MSOLEPS] section 3.1.2, exists in the Summary
        /// Information Stream.
        /// 0x03 The subject of the document. This MUST be ignored if subject information, as specified in [MS-OLEPS] section 3.1.3, exists in the
        /// Summary Information Stream.
        /// 0x04 Key words associated with the document. This MUST be ignored if key word information, as specified in [MS-OLEPS] section 3.1.5,
        /// exists in the Summary Information Stream.
        /// 0x05 Unused. This index MUST be ignored.
        /// 0x06 The author of the document. This index MUST be ignored if author information, as specified in [MS-OLEPS] section 3.1.4, exists in
        /// the Summary Information Stream.
        /// 0x07 The user who last revised the document. This index MUST be ignored if last author information, as specified in [MS-OLEPS] section 3.1.8,
        /// exists in the Summary Information Stream.
        /// 0x08 The path of the associated mail merge data source.
        /// 0x09 The path of the associated mail merge header document.
        /// 0x0A Unused. This index MUST be ignored.
        /// 0x0B Unused. This index MUST be ignored.
        /// 0x0C Unused. This index MUST be ignored.
        /// 0x0D Unused. This index MUST be ignored.
        /// 0x0E Unused. This index MUST be ignored.
        /// 0x0F Unused. This index MUST be ignored.
        /// 0x10 Unused. This index MUST be ignored.
        /// 0x11 The write-reservation password of the document. This value MUST NOT exceed 15 characters in length.
        /// The SttbfAssoc structure is an STTB structure that has the following additional restrictions on its field values:
        /// fExtend (2 bytes): This value MUST be 0xFFFF.
        /// cData (2 bytes): This value MUST be 0x0012.
        /// cbExtra (2 bytes): This value MUST be 0.
        self.sttb = try STTB(dataStream: &dataStream)
        if !self.sttb.fExtend {
            throw OfficeFileError.corrupted
        }
        if self.sttb.cData != 0x0012 {
            throw OfficeFileError.corrupted
        }
        if self.sttb.cbExtra != 0 {
            throw OfficeFileError.corrupted
        }
    }
}
