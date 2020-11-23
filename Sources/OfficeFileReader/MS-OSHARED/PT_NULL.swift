//
//  PT_NULL.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.8.8 PT_NULL
/// Referenced by: EnvRecipientPropertyBlob
/// A recipient property that is an unsigned integer as specified in [MS-OXCDATA].
public struct PT_NULL {
    public let value: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// Value (4 bytes): The value for this property as specified in [MS-OXCDATA].
        self.value = try dataStream.read(endianess: .littleEndian)
    }
}
