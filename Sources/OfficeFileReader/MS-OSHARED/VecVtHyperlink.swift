//
//  VecVtHyperlink.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.3.1.19 VecVtHyperlink
/// Referenced by: VtHyperlinkValue
/// Specifies the data format for an array of hyperlinks. This type conforms to the (VT_VECTOR | VT_VARIANT) TypedPropertyValue value format as
/// specified in [MS-OLEPS] section 2.15, but this section specifies additional details specific to this type.
public struct VecVtHyperlink {
    public let cElements: UInt32
    public let rgHyperlink: [VtHyperlink]
    
    public init(dataStream: inout DataStream) throws {
        /// cElements (4 bytes): An unsigned integer specifying the count of elements in the rgHyperlink field. The number of elements in rgHyperlink
        /// MUST be 1/6 of this value. This value MUST be evenly divisible by 6.
        self.cElements = try dataStream.read(endianess: .littleEndian)
        if (cElements % 6) != 0 {
            throw OfficeFileError.corrupted
        }
        
        /// rgHyperlink (variable): An array of VtHyperlink (section 2.3.3.1.18). Specifies the list of hyperlinks for the property.
        var rgHyperlink: [VtHyperlink] = []
        let count = self.cElements / 6
        rgHyperlink.reserveCapacity(Int(count))
        for _ in 0..<count {
            rgHyperlink.append(try VtHyperlink(dataStream: &dataStream))
        }
        
        self.rgHyperlink = rgHyperlink
    }
}
