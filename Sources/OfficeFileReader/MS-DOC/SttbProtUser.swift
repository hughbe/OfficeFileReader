//
//  SttbProtUser.swift
//
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.293 SttbProtUser
/// The SttbProtUser structure is an STTB structure in which the strings specify the usernames of users who have different roles with respect to a protected
/// range of content in the document.
public struct SttbProtUser {
    public let sttb: STTB<String>
    
    public init(dataStream: inout DataStream) throws {
        /// Each string is either the name of a mapped Windows user or group account that MUST be in the form "DOMAIN\NAME" or a valid e-mail
        /// address as defined in [RFC2822]. Each string in this STTB MUST be unique, and MUST have less than or equal to 255 characters. The
        /// extra data that is appended to each string of this STTB is a signed 16-bit integer that specifies the role for the username and MUST be one
        /// of the following values.
        /// Value Meaning
        /// 0x0000 There is no role specified for the user name.
        /// 0xFFFC The username specifies an owner.
        /// 0xFFFB The username specifies an editor.
        /// The SttbProtUser structure is an STTB structure that has the following additional restrictions on its field values:
        /// fExtend (2 bytes): This value MUST be 0xFFFF.
        /// cbExtra (2 bytes): This value MUST be 0x0002.
        /// cchData (2 bytes): This value MUST be less than or equal to 0x00FF.
        self.sttb = try STTB(dataStream: &dataStream)
        if !self.sttb.fExtend {
            throw OfficeFileError.corrupted
        }
        if self.sttb.cbExtra != 0x0002 {
            throw OfficeFileError.corrupted
        }
        if self.sttb.cbExtra > 0x00FF {
            throw OfficeFileError.corrupted
        }
    }
}
