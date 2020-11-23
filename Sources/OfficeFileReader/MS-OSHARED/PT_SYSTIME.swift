//
//  PT_SYSTIME.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream
import WindowsDataTypes

/// [MS-OSHARED] 2.3.8.10 PT_SYSTIME
/// Referenced by: EnvRecipientPropertyBlob
/// A recipient property that is a FILETIME value as specified in [MS-OXCDATA].
public struct PT_SYSTIME {
    public let highValue: UInt32
    public let lowValue: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// HighValue (4 bytes): The first part of the property's value.
        self.highValue = try dataStream.read(endianess: .littleEndian)
        
        /// LowValue (4 bytes): The second part of the property's value.
        self.lowValue = try dataStream.read(endianess: .littleEndian)
    }
}
