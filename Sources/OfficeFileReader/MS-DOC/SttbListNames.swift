//
//  SttbListNames.swift
//
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.292 SttbListNames
/// The SttbListNames structure is an STTB structure whose strings are the names used by the LISTNUM field, as specified by LISTNUM in flt, for each of
/// the LSTF structures in the document. There is no extra data appended to the strings of this STTB structure. This STTB is parallel to PlfLst.rgLstf. If this
/// STTB has more entries than PlfLst.rgLstf, the extra entries in this STTB MUST be ignored. If a list does not have a name, its corresponding string is an
/// empty string. All non-empty strings in this STTB structure MUST be unique. Each string in this STTB structure MUST contain no more than 255 characters.
public struct SttbListNames {
    public let sttb: STTB<String>
    
    public init(dataStream: inout DataStream) throws {
        /// The SttbListNames structure is an STTB structure that has the following additional restrictions on its field values:
        /// fExtend (2 bytes): This value MUST be 0xFFFF.
        /// cbExtra (2 bytes): This value MUST be 0x0000.
        /// cchData (2 bytes): This value MUST be less than or equal to 0x00FF.
        self.sttb = try STTB(dataStream: &dataStream)
        if !self.sttb.fExtend {
            throw OfficeFileError.corrupted
        }
        if self.sttb.cbExtra != 0x0000 {
            throw OfficeFileError.corrupted
        }
        if self.sttb.cbExtra > 0x00FF {
            throw OfficeFileError.corrupted
        }
    }
}
