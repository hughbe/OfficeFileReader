//
//  PT_BINARY.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.8.14 PT_BINARY
/// Referenced by: EnvRecipientPropertyBlob, PT_MV_BINARY
/// A recipient property that is an array of bytes as specified in [MS-OXCDATA].
public struct PT_BINARY {
    public let size: UInt16
    public let data: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        /// Size (2 bytes): An unsigned integer that contains the size, in bytes, of Data.
        self.size = try dataStream.read(endianess: .littleEndian)
        
        /// Data (variable): An array of bytes as specified in [MS-OXCDATA]
        self.data = try dataStream.readBytes(count: Int(self.size))
    }
}
