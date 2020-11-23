//
//  VtThumbnail.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.3.1.3 VtThumbnail
/// Specifies the format for the thumbnail property. This type conforms to the VT_CF TypedPropertyValue type as specified in [MS-OLEPS] section
/// 2.15, but is presented in additional detail here to specify specific constraints on the type of data that can be contained in this type.
public struct VtThumbnail {
    public let wType: UInt16
    public let padding: UInt16
    public let vtValue: VtThumbnailValue

    public init(dataStream: inout DataStream) throws {
        /// wType (2 bytes): An unsigned integer that MUST be VT_CF (0x0047).
        self.wType = try dataStream.read(endianess: .littleEndian)
        if self.wType != 0x0047 {
            throw OfficeFileError.corrupted
        }
        
        /// padding (2 bytes): An unsigned integer that MUST be 0x0000. MUST be ignored.
        self.padding = try dataStream.read(endianess: .littleEndian)
        
        /// vtValue (variable): MUST be a VtThumbnailValue (section 2.3.3.1.2) structure.
        self.vtValue = try VtThumbnailValue(dataStream: &dataStream)
    }
}
