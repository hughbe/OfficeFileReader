//
//  EnvAttachmentCollection.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.8.17 EnvAttachmentCollection
/// Referenced by: MsoEnvelope
/// A collection that contains the data for each of the attachments for an email message.
public struct EnvAttachmentCollection {
    public let count: UInt32
    public let attachments: [EnvAttachment]
    
    public init(dataStream: inout DataStream) throws {
        /// Count (4 bytes): An unsigned integer that contains the number of attachments for an email message.
        self.count = try dataStream.read(endianess: .littleEndian)
        
        /// Attachments (variable): An array of EnvAttachment (section 2.3.8.18) of size Count that contains the data for each attachment.
        var attachments: [EnvAttachment] = []
        attachments.reserveCapacity(Int(self.count))
        for _ in 0..<self.count {
            attachments.append(try EnvAttachment(dataStream: &dataStream))
        }
        
        self.attachments = attachments
    }
}
