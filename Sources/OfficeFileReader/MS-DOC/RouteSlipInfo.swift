//
//  RouteSlipInfo.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.233 RouteSlipInfo
/// The RouteSlipInfo structure provides information about a single routing slip recipient.
public struct RouteSlipInfo {
    public let cbEntryID: Int16
    public let cbszName: Int16
    public let rgbEntryId: [UInt8]
    public let szName: String
    
    public init(dataStream: inout DataStream) throws {
        /// cbEntryID (2 bytes): A 16-bit signed integer that specifies the number of bytes in rgbEntryId.
        self.cbEntryID = try dataStream.read(endianess: .littleEndian)
        
        /// cbszName (2 bytes): A 16-bit signed integer that specifies the number of bytes in szName. This value MUST be greater than zero.
        self.cbszName = try dataStream.read(endianess: .littleEndian)
        if self.cbszName <= 0 {
            throw OfficeFileError.corrupted
        }
        
        /// rgbEntryId (variable): An array of bytes that provide a unique identifier for this routing slip recipient.
        self.rgbEntryId = try dataStream.readBytes(count: Int(self.cbEntryID))
        
        /// szName (variable): A narrow string that specifies the name or e-mail alias of the routing slip recipient. The length of the string MUST be equal to
        /// cbszName. The string is encoded by using the operating system code page of the computer that last saved this file.
        self.szName = try dataStream.readString(count: Int(self.cbszName), encoding: .ascii)!
    }
}
