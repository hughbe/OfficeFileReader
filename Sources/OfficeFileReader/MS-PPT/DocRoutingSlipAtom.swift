//
//  DocRoutingSlipAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.11.1 DocRoutingSlipAtom
/// Referenced by: DocumentContainer
/// An atom record that specifies information about a document routing slip.
public struct DocRoutingSlipAtom {
    public let rh: RecordHeader
    public let length: UInt32
    public let unused1: UInt32
    public let recipientCount: UInt32
    public let currentRecipient: UInt32
    public let fOneAfterAnother: Bool
    public let fReturnWhenDone: Bool
    public let fTrackStatus: Bool
    public let reserved1: Bool
    public let fDocumentRouted: Bool
    public let fCycleCompleted: Bool
    public let reserved2: UInt32
    public let unused2: UInt32
    public let originatorString: DocRoutingSlipString
    public let rgRecipientRoutingSlipStrings: [DocRoutingSlipString]
    public let subjectString: DocRoutingSlipString
    public let messageString: DocRoutingSlipString
    public let unused3: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_DocRoutingSlipAtom.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .docRoutingSlipAtom else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// length (4 bytes): An unsigned integer that specifies the length, in bytes, of the data contained in the document routing slip, including this field.
        /// It MUST be less than or equal to rh.recLen.
        self.length = try dataStream.read(endianess: .littleEndian)
        if self.length > self.rh.recLen {
            throw OfficeFileError.corrupted
        }
        
        /// unused1 (4 bytes): Undefined and MUST be ignored.
        self.unused1 = try dataStream.read(endianess: .littleEndian)
        
        /// recipientCount (4 bytes): An unsigned integer that specifies the count of strings in the collection of recipients specified by
        /// rgRecipientRoutingSlipStrings.
        self.recipientCount = try dataStream.read(endianess: .littleEndian)
        
        /// currentRecipient (4 bytes): An unsigned integer that specifies the addressee of the document routing slip. It MUST be less than or equal
        /// to recipientCount+1. A value of 0x00000000 or a value of recipientCount+1 specifies the originator identified by originatorString. A value
        /// greater than 0x00000000 and less than recipientCount+1 specifies a 1-based index into the collection of recipients specified by
        /// rgRecipientRoutingSlipStrings.
        self.currentRecipient = try dataStream.read(endianess: .littleEndian)
        if self.currentRecipient > self.recipientCount + 1 {
            throw OfficeFileError.corrupted
        }
        
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fOneAfterAnother (1 bit): A bit that specifies how a document is sent to recipients. It MUST be a value from the following table.
        /// FALSE The document is sent from the originator to all recipients simultaneously.
        /// TRUE The document is sent sequentially to one recipient after another. After a recipient is finished processing the document, the document is
        /// sent to the next recipient.
        self.fOneAfterAnother = flags.readBit()
        
        /// B - fReturnWhenDone (1 bit): A bit that specifies whether a document is sent back to the originator after all recipients have processed the
        /// document.
        self.fReturnWhenDone = flags.readBit()
        
        /// C - fTrackStatus (1 bit): A bit that specifies whether progress of a document routing slip is tracked. If progress is tracked, the originator is notified
        /// after a recipient finishes processing the document.
        self.fTrackStatus = flags.readBit()
        
        /// D - reserved1 (1 bit): MUST be zero, and MUST be ignored.
        self.reserved1 = flags.readBit()
        
        /// E - fDocumentRouted (1 bit): A bit that specifies whether the document-routing is in progress and the document is being processed by recipients.
        self.fDocumentRouted = flags.readBit()
        
        /// F - fCycleCompleted (1 bit): A bit that specifies whether all recipients have finished processing the document.
        self.fCycleCompleted = flags.readBit()
        
        /// reserved2 (26 bits): MUST be ignored and MUST be 0.
        self.reserved2 = flags.readRemainingBits()
        
        /// unused2 (4 bytes): Undefined and MUST be ignored.
        self.unused2 = try dataStream.read(endianess: .littleEndian)
        
        /// originatorString (variable): A DocRoutingSlipString structure that specifies the originator of a document routing slip. The originatorString.stringType
        /// field MUST be 0x0001.
        self.originatorString = try DocRoutingSlipString(dataStream: &dataStream)
        if self.originatorString.stringType != .originator {
            throw OfficeFileError.corrupted
        }
        
        /// rgRecipientRoutingSlipStrings (variable): An array of DocRoutingSlipString structures that specifies recipients of a document routing slip. The
        /// count of items in the array is specified by recipientCount. The stringType field of each DocRoutingSlipString item MUST be 0x0002.
        var rgRecipientRoutingSlipStrings: [DocRoutingSlipString] = []
        rgRecipientRoutingSlipStrings.reserveCapacity(Int(self.recipientCount))
        for _ in 0..<self.recipientCount {
            let value = try DocRoutingSlipString(dataStream: &dataStream)
            if value.stringType != .recipient {
                throw OfficeFileError.corrupted
            }
            
            rgRecipientRoutingSlipStrings.append(value)
        }
        
        self.rgRecipientRoutingSlipStrings = rgRecipientRoutingSlipStrings
        
        /// subjectString (variable): A DocRoutingSlipString structure that specifies the subject of a document routing slip. The subjectString.stringType field
        /// MUST be 0x0003.
        self.subjectString = try DocRoutingSlipString(dataStream: &dataStream)
        if self.subjectString.stringType != .subject {
            throw OfficeFileError.corrupted
        }
        
        /// messageString (variable): A DocRoutingSlipString structure that specifies the message of a document routing slip. The messageString.stringType
        /// field MUST be 0x0004.
        self.messageString = try DocRoutingSlipString(dataStream: &dataStream)
        if self.messageString.stringType != .messageBody {
            throw OfficeFileError.corrupted
        }
        
        /// unused3 (variable): Undefined and MUST be ignored. The length, in bytes, of the field is specified by the following formula: 8 + rh.recLen – length
        let unused3Length = 8 + self.rh.recLen - self.length
        self.unused3 = try dataStream.readBytes(count: Int(unused3Length))
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
