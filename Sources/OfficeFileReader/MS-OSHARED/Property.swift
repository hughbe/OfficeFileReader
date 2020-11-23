//
//  Property.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.3.4.4 Property
/// Referenced by: PropertyBag
/// This structure specifies the indexes into the string table entries of the stringTable field in the PropertyBagStore (section 2.3.4.1) to form a key/value
/// pair. It is used by the smart tag recognizer to store additional information that relates to the smart tag in a collection of key/value pairs, known as
/// a property bag. This information can be later used to perform common tasks for the data type.
public struct Property {
    public let keyIndex: UInt32
    public let valueIndex: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// keyIndex (4 bytes): Unsigned integer specifying the key index.
        self.keyIndex = try dataStream.read(endianess: .littleEndian)
        
        /// valueIndex (4 bytes): Unsigned integer specifying the value index.
        self.valueIndex = try dataStream.read(endianess: .littleEndian)
    }
}
