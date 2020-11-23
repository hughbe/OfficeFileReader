//
//  RouteSlip.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.232 RouteSlip
/// The RouteSlip structure contains information about the routing slip of the document.
public struct RouteSlip {
    public let fRouted: UInt16
    public let fReturnOrig: UInt16
    public let fTrackStatus: UInt16
    public let fDirty: UInt16
    public let nProtect: RouteSlipProtectionEnum
    public let iStage: Int16
    public let delOption: DocumentRouteType
    public let cRecip: Int16
    public let szSubject: String
    public let szMessage: String
    public let szStatus: String
    public let szTitle: String
    public let rgRouteSlips: [RouteSlipInfo]
    
    public init(dataStream: inout DataStream) throws {
        /// fRouted (2 bytes): A 16-bit Boolean value that specifies whether the document was sent out for review.
        self.fRouted = try dataStream.read(endianess: .littleEndian)
        
        /// fReturnOrig (2 bytes): A 16-bit Boolean value that specifies whether the document is returned to the original sender after the review route is
        /// complete.
        self.fReturnOrig = try dataStream.read(endianess: .littleEndian)
        
        /// fTrackStatus (2 bytes): A 16-bit Boolean value that specifies whether status tracking e-mail is sent to the original sender.
        self.fTrackStatus = try dataStream.read(endianess: .littleEndian)
        
        /// fDirty (2 bytes): This value MUST be zero, and MUST be ignored.
        self.fDirty = try dataStream.read(endianess: .littleEndian)
        
        /// nProtect (2 bytes): An unsigned integer value that specifies the kinds of changes allowed to the document being routed. This MUST be one of the
        /// values that are defined in RouteSlipProtectionEnum.
        let nProtectRaw: UInt16 = try dataStream.read(endianess: .littleEndian)
        guard let nProtect = RouteSlipProtectionEnum(rawValue: nProtectRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.nProtect = nProtect
        
        /// iStage (2 bytes): A 16-bit signed integer value that specifies the index of the current routing recipient. This value MUST be greater or equal
        /// to zero, and less than the value of cRecip.
        let iStage: Int16 = try dataStream.read(endianess: .littleEndian)
        guard iStage >= 0 else {
            throw OfficeFileError.corrupted
        }
        
        self.iStage = iStage
        
        /// delOption (2 bytes): A 16-bit signed integer value that specifies how the document is routed. This value MUST be 0 or 1. A value of 0 means the
        /// document is sent to reviewers in serial order. A value of 1 means the document is sent to all reviewers in parallel order.
        guard let delOption = DocumentRouteType(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.delOption = delOption
        
        /// cRecip (2 bytes): A 16-bit signed integer that specifies the number of recipients of the routing slip. This is the size of the rgRouteSlips array.
        let cRecip: Int16 = try dataStream.read(endianess: .littleEndian)
        guard cRecip >= 0 && iStage < cRecip else {
            throw OfficeFileError.corrupted
        }
        
        self.cRecip = cRecip
        
        /// szSubject (variable): A length-prefixed string containing ANSI characters that represent the subject to be mailed with the route slip. This string
        /// MUST be less than 256 characters in length. The string is encoded by using the system code page of the computer that saved the file.
        let szSubjectLength: UInt16 = try dataStream.read(endianess: .littleEndian)
        self.szSubject = try dataStream.readString(count: Int(szSubjectLength), encoding: .ascii)!
        guard self.szSubject.count < 256 else {
            throw OfficeFileError.corrupted
        }
        
        /// szMessage (variable): A length-prefixed string containing ANSI characters that represent the message body to be mailed with the route slip.
        /// This string MUST be less than 256 characters in length. The string is encoded by using the system code page of the computer that saved the file.
        let szMessageLength: UInt16 = try dataStream.read(endianess: .littleEndian)
        self.szMessage = try dataStream.readString(count: Int(szMessageLength), encoding: .ascii)!
        guard self.szMessage.count < 256 else {
            throw OfficeFileError.corrupted
        }
        
        /// szStatus (variable): A length-prefixed string containing ANSI characters that represent status information about the document to be mailed with
        /// the route slip. This string MUST be less than 256 characters in length. The string is encoded by using the system code page of the computer
        /// that saved the file.
        let szStatusLength: UInt16 = try dataStream.read(endianess: .littleEndian)
        self.szStatus = try dataStream.readString(count: Int(szStatusLength), encoding: .ascii)!
        guard self.szStatus.count < 256 else {
            throw OfficeFileError.corrupted
        }
        
        /// szTitle (variable): A length-prefixed string containing ANSI characters that represent a title for the route slip. This string MUST be less than 256
        /// characters long. The string is encoded by using the system code page of the computer that saved the file.
        let szTitleLength: UInt16 = try dataStream.read(endianess: .littleEndian)
        self.szTitle = try dataStream.readString(count: Int(szTitleLength), encoding: .ascii)!
        guard self.szTitle.count < 256 else {
            throw OfficeFileError.corrupted
        }
        
        /// rgRouteSlips (variable): An array of cRecip RouteSlipInfo structures that contains all the routing slips.
        var rgRouteSlips: [RouteSlipInfo] = []
        rgRouteSlips.reserveCapacity(Int(self.cRecip))
        for _ in 0..<self.cRecip {
            rgRouteSlips.append(try RouteSlipInfo(dataStream: &dataStream))
        }
        
        self.rgRouteSlips = rgRouteSlips
    }
    
    /// delOption (2 bytes): A 16-bit signed integer value that specifies how the document is routed. This value MUST be 0 or 1. A value of 0 means the
    /// document is sent to reviewers in serial order. A value of 1 means the document is sent to all reviewers in parallel order.
    public enum DocumentRouteType: Int16 {
        case sentInSerialOrder = 0
        case sentInParallelOrder = 1
    }
}
