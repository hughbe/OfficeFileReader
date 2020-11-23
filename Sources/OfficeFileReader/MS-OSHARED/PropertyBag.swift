//
//  PropertyBag.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.4.3 PropertyBag
/// This structure specifies the smart tag data
public struct PropertyBag {
    public let id: UInt16
    public let cProp: UInt16
    public let cbUnknown: UInt16
    public let properties: [Property]
    
    public init(dataStream: inout DataStream) throws {
        /// id (2 bytes): Unsigned integer specifying the id of FactoidType (section 2.3.4.2) in the factoidTypes list of the PropertyBagStore (section
        /// 2.3.4.1).
        self.id = try dataStream.read(endianess: .littleEndian)
        
        /// cProp (2 bytes): Unsigned integer specifying the count of elements in the properties field.
        self.cProp = try dataStream.read(endianess: .littleEndian)
        
        /// cbUnknown (2 bytes): Unused, reserved for future use. MUST be 0x0 and MUST be ignored.
        self.cbUnknown = try dataStream.read(endianess: .littleEndian)
        
        /// properties (variable): An array of Property (section 2.3.4.4). It is a list of key/value indexes into the stringTable field of the PropertyBagStore
        /// (section 2.3.4.1) structure.
        var properties: [Property] = []
        properties.reserveCapacity(Int(self.cProp))
        for _ in 0..<self.cProp {
            properties.append(try Property(dataStream: &dataStream))
        }

        self.properties = properties
    }
}
