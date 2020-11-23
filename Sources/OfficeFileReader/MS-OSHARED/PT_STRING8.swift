//
//  PT_STRING8.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.8.12 PT_STRING8
/// Referenced by: EnvRecipientPropertyBlob, PT_MV_STRING8
/// A recipient property that is an ANSI character set string as specified in [MS-OXCDATA].
public struct PT_STRING8 {
    public let size: UInt16
    public let value: String
    
    public init(dataStream: inout DataStream) throws {
        /// Size (2 bytes): An unsigned integer that specifies the size, in bytes, of Value.
        self.size = try dataStream.read(endianess: .littleEndian)
        
        /// Value (variable): An array of characters from the ANSI character set as specified in [MS-OXCDATA].
        self.value = try dataStream.readString(count: Int(self.size), encoding: .ascii)!
    }
}
