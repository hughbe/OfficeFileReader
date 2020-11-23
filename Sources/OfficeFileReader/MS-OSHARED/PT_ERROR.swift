//
//  PT_ERROR.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream
import WindowsDataTypes

/// [MS-OSHARED] 2.3.8.11 PT_ERROR
/// Referenced by: EnvRecipientPropertyBlob
/// A recipient property that is an unsigned integer as specified in [MS-OXCDATA].
public struct PT_ERROR {
    public let value: HRESULT
    
    public init(dataStream: inout DataStream) throws {
        /// Value (4 bytes): The value of the property as specified in [MS-OXCDATA].
        self.value = try dataStream.read(endianess: .littleEndian)
    }
}
