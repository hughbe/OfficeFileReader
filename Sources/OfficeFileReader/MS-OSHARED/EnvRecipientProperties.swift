//
//  EnvRecipientProperties.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.8.4 EnvRecipientProperties
/// Referenced by: EnvRecipientCollection
/// An EnvRecipientProperties structure that contains the properties of a single email message recipient.
public struct EnvRecipientProperties {
    public let count: UInt32
    public let ignored: UInt32
    public let properties: [EnvRecipientProperty]
    
    public init(dataStream: inout DataStream) throws {
        /// Count (4 bytes): An unsigned integer that contains the number of properties for this recipient.
        self.count = try dataStream.read(endianess: .littleEndian)
        
        /// Ignored (4 bytes): MUST be ignored.
        self.ignored = try dataStream.read(endianess: .littleEndian)
        
        /// Properties (variable): An array of EnvRecipientProperty (section 2.3.8.5) that has the size of Count.
        var properties: [EnvRecipientProperty] = []
        properties.reserveCapacity(Int(self.count))
        for _ in 0..<self.count {
            properties.append(try EnvRecipientProperty(dataStream: &dataStream))
        }
        
        self.properties = properties
    }
}
