//
//  PT_BOOLEAN.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.8.9 PT_BOOLEAN
/// Referenced by: EnvRecipientPropertyBlob
/// A recipient property that is an unsigned integer as specified in [MS-OXCDATA].
public struct PT_BOOLEAN {
    public let value: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// Value (2 bytes): The value of the property as specified in [MS-OXCDATA].
        self.value = try dataStream.read(endianess: .littleEndian)
    }
}
