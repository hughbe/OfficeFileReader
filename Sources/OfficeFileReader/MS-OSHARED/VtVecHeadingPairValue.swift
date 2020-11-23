//
//  VtVecHeadingPairValue.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.3.1.14 VtVecHeadingPairValue
/// Referenced by: VtVecHeadingPair
/// Specifies data for the heading pair property. This type conforms to the (VT_VECTOR | VT_VARIANT) TypedPropertyValue value format as specified
/// in [MS-OLEPS] section 2.15, but this section specifies additional detail specifically applicable to this type.
public struct VtVecHeadingPairValue {
    public let cElements: UInt32
    public let rgHeadingPairs: [VtHeadingPair]
    
    public init(dataStream: inout DataStream) throws {
        /// cElements (4 bytes): An unsigned integer specifying the count of elements in the rgHeadingPairs field. The number of elements in
        /// rgHeadingPairs MUST be half of this value. This value MUST be even.
        self.cElements = try dataStream.read(endianess: .littleEndian)
        if (self.cElements % 2) != 0 {
            throw OfficeFileError.corrupted
        }
        
        /// rgHeadingPairs (variable): An array of VtHeadingPair (section 2.3.3.1.13). Specifies the list of heading pairs for the property.
        var rgHeadingPairs: [VtHeadingPair] = []
        let count = self.cElements / 2
        rgHeadingPairs.reserveCapacity(Int(count))
        for _ in 0..<count  {
            rgHeadingPairs.append(try VtHeadingPair(dataStream: &dataStream))
        }
        
        self.rgHeadingPairs = rgHeadingPairs
    }
}
