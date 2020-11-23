//
//  EnvRecipientProperty.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.8.5 EnvRecipientProperty
/// Referenced by: EnvRecipientProperties
/// A single property for an email message recipient. These properties are specified in [MS-OXCDATA].
/// Only the sizes of the properties are described here.
public struct EnvRecipientProperty {
    public let propTag: UInt32
    public let propData: EnvRecipientPropertyBlob
    
    public init(dataStream: inout DataStream) throws {
        /// PropTag (4 bytes): An unsigned integer that contains the property identifier tag.
        self.propTag = try dataStream.read(endianess: .littleEndian)
        
        let propType = UInt16(propTag & 0b1111111111111111)
        
        /// PropData (variable): An EnvRecipientPropertyBlob (section 2.3.8.6), the type of which is specified by PropTag.
        self.propData = try EnvRecipientPropertyBlob(dataStream: &dataStream, propType: propType)
    }
}
