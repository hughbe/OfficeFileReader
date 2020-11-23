//
//  PT_UNICODE.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.8.13 PT_UNICODE
/// Referenced by: EnvRecipientPropertyBlob
/// A recipient property that is a Unicode string as specified in [MS-OXCDATA].
public struct PT_UNICODE {
    public let size: UInt16
    public let value: String
    
    public init(dataStream: inout DataStream) throws {
        /// Size (2 bytes): An unsigned integer that specifies the size, in bytes, of Value.
        self.size = try dataStream.read(endianess: .littleEndian)
        
        /// Value (variable): A Unicode string as specified in [MS-OXCDATA].
        self.value = try dataStream.readString(count: Int(self.size), encoding: .utf16LittleEndian)!
    }
}
