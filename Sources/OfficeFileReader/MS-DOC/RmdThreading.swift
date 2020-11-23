//
//  RmdThreading.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.230 RmdThreading
/// The RmdThreading structure specifies data about e-mail messages and their authors.
public struct RmdThreading {
    public let sttbMessage: STTB<String>
    public let sttbStyle: STTB<String>
    public let sttbAuthorAttrib: STTB<String>
    public let sttbAuthorValue: STTB<String>
    public let sttbMessageAttrib: STTB<String>
    public let sttbMessageValue: STTB<String>
    
    public init(dataStream: inout DataStream) throws {
        /// SttbMessage (variable): An STTB where each string specifies the message identifier for the corresponding author in the parallel SttbfRMark.
        /// The string is empty if the corresponding author is not the author of an e-mail message. The extra data that is appended to each string is an MDP
        /// that specifies the message display properties. If a string is empty, the extra data that is appended to it MUST be ignored.
        /// SttbMessage is an STTB with the following additional restrictions on its field values:
        /// fExtend (2 bytes): This value MUST be 0xFFFF.
        /// cbExtra (2 bytes): This value MUST be 0x0008.
        self.sttbMessage = try STTB(dataStream: &dataStream)
        if !self.sttbMessage.fExtend {
            throw OfficeFileError.corrupted
        }
        if self.sttbMessage.cbExtra != 0x0008 {
            throw OfficeFileError.corrupted
        }
        
        /// SttbStyle (variable): An STTB where each string specifies the personal style of the corresponding author in the parallel SttbfRMark. The string is
        /// empty if the corresponding author does not have a personal style. There is no extra data appended to the strings of this STTB.
        /// SttbStyle is an STTB with the following additional restrictions on its field values:
        /// fExtend (2 bytes): This value MUST be 0xFFFF.
        /// cbExtra (2 bytes): This value MUST be 0.
        self.sttbStyle = try STTB(dataStream: &dataStream)
        if !self.sttbStyle.fExtend {
            throw OfficeFileError.corrupted
        }
        if self.sttbStyle.cbExtra != 0 {
            throw OfficeFileError.corrupted
        }
        
        /// SttbAuthorAttrib (variable): An STTB in which each string specifies an author attribute. The extra data appended to each string is a 16-bit signed
        /// integer that specifies a zero-based index of an author in the SttbfRMark to which this attribute is related. If a string is an empty string, the data
        /// that is appended to it MUST be ignored, and the corresponding value in the parallel SttbAuthorValue MUST be ignored. SttbAuthorAttrib
        /// SHOULD<234> be ignored.
        /// SttbAuthorAttrib is an STTB with the following additional restrictions on its field values:
        /// fExtend (2 bytes): This value MUST be 0xFFFF.
        /// cbExtra (2 bytes): This value MUST be 0x0002.
        self.sttbAuthorAttrib = try STTB(dataStream: &dataStream)
        if !self.sttbAuthorAttrib.fExtend {
            throw OfficeFileError.corrupted
        }
        if self.sttbAuthorAttrib.cbExtra != 0x0002 {
            throw OfficeFileError.corrupted
        }
        
        /// SttbAuthorValue (variable): An STTB where each string specifies the value of the corresponding author attribute in the parallel SttbAuthorAttrib.
        /// There is no extra data appended to the strings of this STTB. SttbAuthorValue SHOULD<235> be ignored.
        /// SttbAuthorValue is an STTB with the following additional restrictions on its field values:
        /// fExtend (2 bytes): This value MUST be 0xFFFF.
        /// cbExtra (2 bytes): This value MUST be 0.
        self.sttbAuthorValue = try STTB(dataStream: &dataStream)
        if !self.sttbAuthorValue.fExtend {
            throw OfficeFileError.corrupted
        }
        if self.sttbAuthorValue.cbExtra != 0 {
            throw OfficeFileError.corrupted
        }
        
        /// SttbMessageAttrib (variable): An STTB in which each string specifies a message attribute. The extra data that is appended to each string is a
        /// 16-bit signed integer that specifies a zero-based index of a message that this attribute pertains to in SttbMessage. If a string is an empty string,
        /// the data that is appended to it MUST be ignored, and the corresponding value in the parallel SttbMessageValue MUST be ignored.
        /// SttbMessageAttrib SHOULD<236> be ignored.
        /// SttbMessageAttrib is an STTB with the following additional restrictions on its field values:
        /// fExtend (2 bytes): This value MUST be 0xFFFF.
        /// cbExtra (2 bytes): This value MUST be 0x0002.
        self.sttbMessageAttrib = try STTB(dataStream: &dataStream)
        if !self.sttbMessageAttrib.fExtend {
            throw OfficeFileError.corrupted
        }
        if self.sttbMessageAttrib.cbExtra != 0x0002 {
            throw OfficeFileError.corrupted
        }
        
        /// SttbMessageValue (variable): An STTB in which each string specifies the value of the corresponding message attribute in the parallel
        /// SttbMessageAttrib. No extra data is appended to the strings of this STTB. SttbMessageValue SHOULD<237> be ignored.
        /// SttbMessageValue is an STTB with the following additional restrictions on its field values:
        /// fExtend (2 bytes): This value MUST be 0xFFFF.
        /// cbExtra (2 bytes): This value MUST be 0.
        self.sttbMessageValue = try STTB(dataStream: &dataStream)
        if !self.sttbMessageValue.fExtend {
            throw OfficeFileError.corrupted
        }
        if self.sttbMessageValue.cbExtra != 0 {
            throw OfficeFileError.corrupted
        }
    }
}
