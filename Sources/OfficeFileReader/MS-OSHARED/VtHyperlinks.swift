//
//  VtHyperlinks.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.3.1.21 VtHyperlinks
/// Specifies the format for a property representing a set of hyperlinks. This type conforms to the VT_BLOB TypedPropertyValue type as specified
/// in [MS-OLEPS] section 2.15, but is presented in more detail here to further specify the contents of the data in this type.
public struct VtHyperlinks {
    public let wType: UInt16
    public let padding: UInt16
    public let vtValue: VtHyperlinkValue
    
    public init(dataStream: inout DataStream) throws {
        /// wType (2 bytes): An unsigned integer that MUST be equal to VT_BLOB (0x0041).
        self.wType = try dataStream.read(endianess: .littleEndian)
        
        /// padding (2 bytes): An unsigned integer that MUST be 0x0000. MUST be ignored.
        self.padding = try dataStream.read(endianess: .littleEndian)
        
        /// vtValue (variable): MUST be a VtHyperlinkValue structure (section 2.3.3.1.20).
        self.vtValue = try VtHyperlinkValue(dataStream: &dataStream)
    }
}
