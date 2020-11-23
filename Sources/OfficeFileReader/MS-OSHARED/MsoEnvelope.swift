//
//  MsoEnvelope.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.8.2 MsoEnvelope
/// A structure that contains information about the email message being sent.
public struct MsoEnvelope {
    public let ver: UInt32
    public let lastSentTime: Int32
    public let flagStatus: UInt32
    public let replyTime: Int32
    public let requestStrSize: UInt16
    public let requestStr: String
    public let sentRepresentingEntryIdSize: UInt16
    public let sentRepresentingEntryId: [UInt8]
    public let sentRepresentingNameSize: UInt16
    public let sentRepresentingName: String
    public let inetAcctStampSize: UInt16
    public let inetAcctStamp: String
    public let inetAcctNameSize: UInt16
    public let inetAcctName: String
    public let expiryTime: Int32
    public let deferredDeliveryTime: Int32
    public let deleteAfterSubmit: UInt32
    public let securityFlags: UInt32
    public let originatorDeliveryReportRequested: UInt32
    public let readReceiptRequested: UInt32
    public let categoriesStrSize: UInt16
    public let categoriesStr: String
    public let sensitivity: UInt32
    public let importance: UInt32
    public let subjectSize: UInt16
    public let subject: String
    public let votingOptionsSize: UInt32
    public let votingOptions: String
    public let replyRecipients: EnvRecipientCollection
    public let contactLinkRecipients: EnvRecipientCollection?
    public let recipients: EnvRecipientCollection
    public let attachments: EnvAttachmentCollection
    public let introText: IntroText?
    
    public init(dataStream: inout DataStream) throws {
        /// Ver (4 bytes): An unsigned integer that specifies the version of this envelope.
        self.ver = try dataStream.read(endianess: .littleEndian)
        
        /// LastSentTime (4 bytes): A signed integer that specifies the last time this email message was sent. Time is represented as the number of minutes
        /// since 12:00 AM January 1, 1601. The value MUST be greater than or equal to 0 and less than or equal to 0x5AE980E0. The default value is
        /// 0x5AE980E0, which means no time was specified.
        self.lastSentTime = try dataStream.read(endianess: .littleEndian)
        if self.lastSentTime < 0 {
            throw OfficeFileError.corrupted
        }
        
        /// FlagStatus (4 bytes): An unsigned integer that specifies the follow-up status of this email message. Values are zero for not flagged for follow-up,
        /// 1 for flagged for follow-up, and 2 for completed follow-up.
        self.flagStatus = try dataStream.read(endianess: .littleEndian)
        
        /// ReplyTime (4 bytes): A signed integer that specifies when the last reply was received for this email message. The time is represented as the
        /// number of minutes since 12:00 AM January 1, 1601. The value MUST be greater than or equal to zero and less than or equal to 0x5AE980E0.
        /// The default value is 0x5AE980E0, which means no time was specified.
        self.replyTime = try dataStream.read(endianess: .littleEndian)
        if self.replyTime < 0 {
            throw OfficeFileError.corrupted
        }
        
        /// RequestStrSize (2 bytes): An unsigned integer that contains the size, in characters, of RequestStr.
        self.requestStrSize = try dataStream.read(endianess: .littleEndian)
        
        /// RequestStr (variable): A character array that contains the request string. For example, if the sender has set a flag on this email message with "No
        /// Response Necessary", this string contains "No Response Necessary". If Ver is 6, this is an ANSI character set array. If Ver is 8, this is a
        /// Unicode character array.
        if self.ver == 6 {
            self.requestStr = try dataStream.readString(count: Int(self.requestStrSize), encoding: .ascii)!
        } else {
            self.requestStr = try dataStream.readString(count: Int(self.requestStrSize) * 2, encoding: .utf16LittleEndian)!
        }
        
        /// SentRepresentingEntryIdSize (4 bytes): An unsigned integer that contains the size, in bytes, of SentRepresentingEntryId.
        self.sentRepresentingEntryIdSize = try dataStream.read(endianess: .littleEndian)
        
        /// SentRepresentingEntryId (variable): An array of bytes that specifies the PR_SENT_REPRESENTING_ENTRYID as specified in [MS-OXPROPS].
        self.sentRepresentingEntryId = try dataStream.readBytes(count: Int(self.sentRepresentingEntryIdSize))
        
        /// SentRepresentingNameSize (2 bytes): An unsigned integer that contains the size, in characters, of SentRepresentingName.
        self.sentRepresentingNameSize = try dataStream.read(endianess: .littleEndian)
        
        /// SentRepresentingName (variable): A character array that specifies the PR_SENT_REPRESENTING_NAME as specified in [MS-OXPROPS].
        /// If Ver is 6, this is an ANSI character set array. If Ver is 8, this is a Unicode character array.
        if self.ver == 6 {
            self.sentRepresentingName = try dataStream.readString(count: Int(self.requestStrSize), encoding: .ascii)!
        } else {
            self.sentRepresentingName = try dataStream.readString(count: Int(self.requestStrSize) * 2, encoding: .utf16LittleEndian)!
        }
        
        /// InetAcctStampSize (2 bytes): An unsigned integer that contains the size, in characters, of InetAcctStamp.
        self.inetAcctStampSize = try dataStream.read(endianess: .littleEndian)
        
        /// InetAcctStamp (variable): A character array that specifies the dispidInetAcctStamp as specified in [MS-OXPROPS]. If Ver is 6, this is an ANSI
        /// character set array. If Ver is 8, this is a Unicode character array.
        if self.ver == 6 {
            self.inetAcctStamp = try dataStream.readString(count: Int(self.inetAcctStampSize), encoding: .ascii)!
        } else {
            self.inetAcctStamp = try dataStream.readString(count: Int(self.inetAcctStampSize) * 2, encoding: .utf16LittleEndian)!
        }
        
        /// InetAcctNameSize (2 bytes): An unsigned integer that contains the size, in characters, of InetAcctName.
        self.inetAcctNameSize = try dataStream.read(endianess: .littleEndian)
        
        /// InetAcctName (variable): A character array that contains the dispidInetAcctName as specified in [MS-OXPROPS]. If Ver is 6, this is an ANSI
        /// character set array. If Ver is 8, this is a Unicode character array.
        if self.ver == 6 {
            self.inetAcctName = try dataStream.readString(count: Int(self.inetAcctNameSize), encoding: .ascii)!
        } else {
            self.inetAcctName = try dataStream.readString(count: Int(self.inetAcctNameSize) * 2, encoding: .utf16LittleEndian)!
        }
        
        /// ExpiryTime (4 bytes): A signed integer that specifies the time this email message expires. The time is represented as the number of minutes
        /// since 12:00 AM January 1, 1601. The value MUST be greater than or equal to 0 and less than or equal to 0x5AE980E0. The default value is
        /// 0x5AE980E0, which means no time was specified.
        self.expiryTime = try dataStream.read(endianess: .littleEndian)
        if self.expiryTime < 0 {
            throw OfficeFileError.corrupted
        }
        
        /// DeferredDeliveryTime (4 bytes): A signed integer that specifies the time to send this email message. The time is represented as the number of
        /// minutes since 12:00 AM January 1, 1601. The value MUST be greater than or equal to 0 and less than or equal to 0x5AE980E0. The default value
        /// is 0x5AE980E0, which means no time was specified.
        self.deferredDeliveryTime = try dataStream.read(endianess: .littleEndian)
        if self.deferredDeliveryTime < 0 {
            throw OfficeFileError.corrupted
        }
        
        /// DeleteAfterSubmit (4 bytes): An unsigned integer that specifies whether to delete the message after a recipient has submitted a reply. Values are
        /// zero for no, and 1 for yes. MUST be zero or 1.
        self.deleteAfterSubmit = try dataStream.read(endianess: .littleEndian)
        
        /// SecurityFlags (4 bytes): A bit field that specifies the security settings for this email message. The least significant bit specifies whether the email
        /// message is signed, and the next bit specifies whether the email message is encrypted. All other bits MUST be zero.
        self.securityFlags = try dataStream.read(endianess: .littleEndian)
        
        /// OriginatorDeliveryReportRequested (4 bytes): An unsigned integer that specifies whether to send a delivery receipt to the sender. Values are
        /// zero for no and 1 for yes. MUST be zero or 1.
        self.originatorDeliveryReportRequested = try dataStream.read(endianess: .littleEndian)
        
        /// ReadReceiptRequested (4 bytes): An unsigned integer that specifies whether to send a read receipt to the sender. Values are zero for no and 1
        /// for yes. MUST be zero or 1.
        self.readReceiptRequested = try dataStream.read(endianess: .littleEndian)
        
        /// CategoriesStrSize (2 bytes): An unsigned integer that contains the size, in characters, of CategoriesStr.
        self.categoriesStrSize = try dataStream.read(endianess: .littleEndian)
        
        /// CategoriesStr (variable): A character array that contains the category for this email message. For example, "Business" or "Favorites". If Ver is 6,
        /// this is an ANSI character set array. If Ver is 8, this is a Unicode character array.
        if self.ver == 6 {
            self.categoriesStr = try dataStream.readString(count: Int(self.categoriesStrSize), encoding: .ascii)!
        } else {
            self.categoriesStr = try dataStream.readString(count: Int(self.categoriesStrSize) * 2, encoding: .utf16LittleEndian)!
        }
        
        /// Sensitivity (4 bytes): An unsigned integer that specifies the sensitivity of the email message. Values are zero for Normal, 1 for Personal, 2 for
        /// Private, and 3 for Confidential. MUST be less than 4.
        self.sensitivity = try dataStream.read(endianess: .littleEndian)
        
        /// Importance (4 bytes): An unsigned integer that specifies the importance flag of the email message. Values are 0 for Low, 1 for Normal, and 2 for
        /// High. MUST be less than 3.
        self.importance = try dataStream.read(endianess: .littleEndian)
        
        /// SubjectSize (2 bytes): An unsigned integer that contains the size, in characters, of Subject.
        self.subjectSize = try dataStream.read(endianess: .littleEndian)
        
        /// Subject (variable): A character array that contains the subject of the email message. If Ver is 6, this is an ANSI character set array. If Ver is 8,
        /// this is a Unicode character array.
        if self.ver == 6 {
            self.subject = try dataStream.readString(count: Int(self.subjectSize), encoding: .ascii)!
        } else {
            self.subject = try dataStream.readString(count: Int(self.subjectSize) * 2, encoding: .utf16LittleEndian)!
        }
        
        /// VotingOptionsSize (2 bytes): An unsigned integer that contains the size, in characters, of the VotingOptions.
        self.votingOptionsSize = try dataStream.read(endianess: .littleEndian)
        
        /// VotingOptions (variable): An ANSI character array that contains the voting option choices separated by a semicolon. For example, "Yes;No;Maybe".
        self.votingOptions = try dataStream.readString(count: Int(self.votingOptionsSize), encoding: .ascii)!
        
        /// ReplyRecipients (variable): An EnvRecipientCollection (section 2.3.8.3) that contains the recipients of replies to this email message.
        self.replyRecipients = try EnvRecipientCollection(dataStream: &dataStream)
        
        /// ContactLinkRecipients (variable): An EnvRecipientCollection (section 2.3.8.3) that contains the sender contacts to whom the email message is to
        /// be sent. This is not present if Ver does not equal 8.
        if self.ver == 8 {
            self.contactLinkRecipients = try EnvRecipientCollection(dataStream: &dataStream)
        } else {
            self.contactLinkRecipients = nil
        }
        
        /// Recipients (variable): An EnvRecipientCollection (section 2.3.8.3) that contains the recipients to receive this email message.
        self.recipients = try EnvRecipientCollection(dataStream: &dataStream)
        
        /// Attachments (variable): An EnvAttachmentCollection (section 2.3.8.17) that contains information about attachments for this email message.
        self.attachments = try EnvAttachmentCollection(dataStream: &dataStream)
        
        /// IntroText (variable): If Ver equals 8, this is an IntroText (section 2.3.8.19). This is not present if Ver does not equal 8.
        if self.ver == 8 {
            self.introText = try IntroText(dataStream: &dataStream)
        } else {
            self.introText = nil
        }
    }
}
