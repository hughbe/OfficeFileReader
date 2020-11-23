//
//  VtVecHeadingPair.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.3.1.15 VtVecHeadingPair
/// Specifies the format for a property representing the headers corresponding to the GKPIDDSI_DOCPARTS property data (section 2.3.3.2.2.1).
/// This type conforms to the (VT_VECTOR | VT_VARIANT) TypedPropertyValue type as specified in [MS-OLEPS] section 2.15, but is presented in
/// additional detail here to specify specific constraints on the type and format of data that can be contained in this type.
/// Refer to the GKPIDDSI_HEADINGPAIR (section 2.3.3.2.2.1) and GKPIDDSI_DOCPARTS (section 2.3.3.2.2.1) properties for additional details.
public struct VtVecHeadingPair {
    public let wType: UInt16
    public let padding: UInt16
    public let vtValue: VtVecHeadingPairValue
    
    public init(dataStream: inout DataStream) throws {
        /// wType (2 bytes): An unsigned integer that MUST be VT_VECTOR | VT_VARIANT (0x100C).
        self.wType = try dataStream.read(endianess: .littleEndian)
        if self.wType != 0x100C {
            throw OfficeFileError.corrupted
        }
        
        /// padding (2 bytes): An unsigned integer that MUST be 0x0000. MUST be ignored.
        self.padding = try dataStream.read(endianess: .littleEndian)
        
        /// vtValue (variable): MUST be a VtVecHeadingPairValue (section 2.3.3.1.14) structure.
        self.vtValue = try VtVecHeadingPairValue(dataStream: &dataStream)
    }
}
