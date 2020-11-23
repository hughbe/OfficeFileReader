//
//  FSDAP.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.96 FSDAP
/// The FSDAP structure specifies information about an attribute on a structured document tag in the document.
public struct FSDAP {
    public let tiq: TIQ
    public let cch: UInt16
    public let rgValue: String
    
    public init(dataStream: inout DataStream) throws {
        /// tiq (8 bytes): A TIQ that specifies further information about the attribute represented by this FSDAP.
        self.tiq = try TIQ(dataStream: &dataStream)
        
        /// cch (2 bytes): An unsigned integer that specifies the count of characters in rgValue, not including its null terminator.
        self.cch = try dataStream.read(endianess: .littleEndian)
        
        /// rgValue (variable): A null-terminated sequence of Unicode characters that specifies the value of the attribute represented by this FSDAP.
        self.rgValue = try dataStream.readString(count: Int(self.cch * 2), encoding: .utf16LittleEndian)!
        
        let nullTerminator: UInt16 = try dataStream.read(endianess: .littleEndian)
        if nullTerminator != 0x0000 {
            throw OfficeFileError.corrupted
        }
    }
}
