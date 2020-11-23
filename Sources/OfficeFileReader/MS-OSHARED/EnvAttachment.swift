//
//  EnvAttachment.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.8.18 EnvAttachment
/// Referenced by: EnvAttachmentCollection
/// A structure that contains the data for a single email message attachment.
public struct EnvAttachment {
    public let attachmentMethod: UInt32
    public let attachmentNameSize: UInt8
    public let attachmentName: String
    public let attachmentSizeLowOrderBits: UInt32
    public let attachmentSizeHighOrderBits: UInt32
    public let data: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        /// AttachmentMethod (4 bytes): An unsigned integer that represents the MAPI property PR_ATTACH_METHOD, as specified in [MS-OXPROPS].
        self.attachmentMethod = try dataStream.read(endianess: .littleEndian)
        
        /// AttachmentNameSize (1 byte): A byte that contains the size, in characters, of AttachmentName.
        self.attachmentNameSize = try dataStream.read()
        
        /// AttachmentName (variable): A Unicode character array that contains the file name of the attachment.
        self.attachmentName = try dataStream.readString(count: Int(self.attachmentNameSize) * 2, encoding: .utf16LittleEndian)!
        
        /// AttachmentSizeLowOrderBits (4 bytes): An unsigned integer that contains the low-order bits for the file size of the attachment.
        self.attachmentSizeLowOrderBits = try dataStream.read(endianess: .littleEndian)
        
        /// AttachmentSizeHighOrderBits (4 bytes): An unsigned integer that contains the high-order bits for the file size of the attachment.
        self.attachmentSizeHighOrderBits = try dataStream.read(endianess: .littleEndian)
        
        /// Data (variable): An array of bytes that contains the content of the attachment.
        let full = (UInt64(self.attachmentSizeHighOrderBits) << 32) + UInt64(self.attachmentSizeLowOrderBits)
        self.data = try dataStream.readBytes(count: Int(full))
    }
}
