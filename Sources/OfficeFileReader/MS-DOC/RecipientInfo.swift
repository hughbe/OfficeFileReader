//
//  RecipientInfo.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.225 RecipientInfo
/// The RecipientInfo structure specifies which recipients in the data source are excluded from the mail merge. It also provides data to uniquely
/// identify each recipient in case the data source was altered after the last read operation.
public struct RecipientInfo {
    public let countMarker: UInt16
    public let cbCount: UInt16
    public let cRecipients: UInt32
    public let recipientListSizeMarker: UInt16
    public let cbRecipientList: UInt16
    public let cbRecipientListOverflow: UInt32?
    public let recipients: [RecipientBase]
    
    public init(dataStream: inout DataStream) throws {
        /// countMarker (2 bytes): An unsigned integer that specifies that the count of recipients follows. This value MUST be zero.
        self.countMarker = try dataStream.read(endianess: .littleEndian)
        if self.countMarker != 0 {
            throw OfficeFileError.corrupted
        }
        
        /// cbCount (2 bytes): An unsigned integer that specifies the size, in bytes, of cRecipients. This value MUST be 0x0004.
        self.cbCount = try dataStream.read(endianess: .littleEndian)
        if self.cbCount != 0x0004 {
            throw OfficeFileError.corrupted
        }
        
        /// cRecipients (4 bytes): An unsigned integer that specifies the number of elements in the Recipients array.
        self.cRecipients = try dataStream.read(endianess: .littleEndian)
        
        /// RecipientListSizeMarker (2 bytes): An unsigned integer that specifies that the size, in bytes, of the Recipients array follows.
        /// This value MUST be 0x0001.
        self.recipientListSizeMarker = try dataStream.read(endianess: .littleEndian)
        if self.recipientListSizeMarker != 0x0001 {
            throw OfficeFileError.corrupted
        }
        
        /// cbRecipientList (2 bytes): An unsigned integer that specifies the size, in bytes, of the Recipients array, or, if the size is greater than
        /// 0xFFFE, this value MUST be 0xFFFF.
        self.cbRecipientList = try dataStream.read(endianess: .littleEndian)
        
        /// cbRecipientListOverflow (4 bytes): An unsigned integer that specifies the size, in bytes, of the Recipients array. This value is present
        /// only if cbRecipientList is set to 0xFFFF.
        if self.cbRecipientList == 0xFFFF {
            self.cbRecipientListOverflow = try dataStream.read(endianess: .littleEndian)
        } else {
            self.cbRecipientListOverflow = nil
        }
        
        /// Recipients (variable): An array of RecipientBase. An array that contains information about the recipients in the mail merge data source.
        let startPosition = dataStream.position
        var recipients: [RecipientBase]  = []
        recipients.reserveCapacity(Int(self.cRecipients))
        for _ in 0..<self.cRecipients {
            recipients.append(try RecipientBase(dataStream: &dataStream))
        }

        self.recipients = recipients
        
        if self.cbRecipientList != 0xFFFF {
            if dataStream.position - startPosition != self.cbRecipientList {
                throw OfficeFileError.corrupted
            }
        } else {
            if dataStream.position - startPosition != self.cbRecipientListOverflow! {
                throw OfficeFileError.corrupted
            }
        }
    }
}
