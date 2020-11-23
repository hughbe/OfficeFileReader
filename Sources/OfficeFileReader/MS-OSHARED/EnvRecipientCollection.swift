//
//  EnvRecipientCollection.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.8.3 EnvRecipientCollection
/// Referenced by: MsoEnvelope
/// A collection that contains information about recipients for an email message.
public struct EnvRecipientCollection {
    public let recipientCollTag: UInt32
    public let recipientCollVer: UInt32
    public let count: UInt32
    public let recipients: [EnvRecipientProperties]
    
    public init(dataStream: inout DataStream) throws {
        /// RecipientCollTag (4 bytes): An unsigned integer that contains a version tag for the recipient collection. MUST be 0xDCCA0123.
        self.recipientCollTag = try dataStream.read(endianess: .littleEndian)
        if self.recipientCollTag != 0xDCCA0123 {
            throw OfficeFileError.corrupted
        }
        
        /// RecipientCollVer (4 bytes): An unsigned integer that contains a version for the recipient collection. MUST be 1.
        self.recipientCollVer = try dataStream.read(endianess: .littleEndian)
        if self.recipientCollVer != 1 {
            throw OfficeFileError.corrupted
        }
        
        /// Count (4 bytes): An unsigned integer that contains the number of recipients in the Recipients array.
        self.count = try dataStream.read(endianess: .littleEndian)
        
        /// Recipients (variable): An array of EnvRecipientProperties (section 2.3.8.4) that contains the properties for each recipient.
        var recipients: [EnvRecipientProperties] = []
        recipients.reserveCapacity(Int(self.count))
        for _ in 0..<self.count {
            recipients.append(try EnvRecipientProperties(dataStream: &dataStream))
        }
        
        self.recipients = recipients
    }
}
