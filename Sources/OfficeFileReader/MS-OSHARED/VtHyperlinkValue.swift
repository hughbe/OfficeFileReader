//
//  VtHyperlinkValue.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.3.1.20 VtHyperlinkValue
/// Referenced by: VtHyperlinks
/// Specifies the data for a hyperlinks property. This type conforms to the VT_BLOB TypedPropertyValue value format as specified in [MS-OLEPS]
/// section 2.15, but this section specifies additional detail applicable to this type.
public struct VtHyperlinkValue {
    public let cbData: UInt32
    public let vecHyperlink: VecVtHyperlink
    
    public init(dataStream: inout DataStream) throws {
        /// cbData (4 bytes): An unsigned integer that specifies the size in bytes of vecHyperlink.
        self.cbData = try dataStream.read(endianess: .littleEndian)
        
        let startPosition = dataStream.position
        
        /// vecHyperlink (variable): MUST be a VecVtHyperlink structure (section 2.3.3.1.19).
        self.vecHyperlink = try VecVtHyperlink(dataStream: &dataStream)
        
        if dataStream.position - startPosition != self.cbData {
            throw OfficeFileError.corrupted
        }
    }
}
