//
//  RecipientTerminator.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.226 RecipientTerminator
/// The RecipientTerminator structure marks the end of the RecipientDataItem elements that pertain to a recipient.
public struct RecipientTerminator {
    public let recipientDataId: UInt16
    public let cbRecipientData: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// RecipientDataId (2 bytes): An unsigned integer value that specifies there is no further data to read for the current recipient. This value
        /// MUST be zero.
        self.recipientDataId = try dataStream.read(endianess: .littleEndian)

        /// cbRecipientData (2 bytes): This value MUST be zero.
        self.cbRecipientData = try dataStream.read(endianess: .littleEndian)
    }
}
