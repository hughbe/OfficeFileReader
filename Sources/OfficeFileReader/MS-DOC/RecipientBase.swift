//
//  RecipientBase.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.223 RecipientBase
/// The RecipientBase structure contains information about a mail merge recipient followed by a marker (RecipientLast) that specifies where the
/// recipient information ends.
public struct RecipientBase {
    public let recipient: [RecipientDataItem]
    public let recipientLast: RecipientTerminator
    
    public init(dataStream: inout DataStream) throws {
        /// recipient (variable): An array of RecipientDataItem containing data that describes a mail merge recipient. Each recipient MUST have
        /// a RecipientDataItem with a RecipientDataID of 0x0003 or MUST have RecipientDataItem elements that have RecipientDataIDs of
        /// 0x0002 and 0x0004.
        var recipient: [RecipientDataItem] = []
        while try dataStream.peek(endianess: .littleEndian) as UInt32 != 0x0000 {
            recipient.append(try RecipientDataItem(dataStream: &dataStream))
        }
        
        self.recipient = recipient
        
        /// RecipientLast (4 bytes): Contains a RecipientTerminator that specifies that there is no further data to read for the current recipient.
        self.recipientLast = try RecipientTerminator(dataStream: &dataStream)
    }
}
