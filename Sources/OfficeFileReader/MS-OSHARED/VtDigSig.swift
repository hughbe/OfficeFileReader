//
//  VtDigSig.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.3.1.17 VtDigSig
/// Specifies the format for a property representing a VBA digital signature. This type conforms to the VT_BLOB TypedPropertyValue type as specified
/// in [MS-OLEPS] section 2.15, but is presented in additional detail here to further specify the content of the property.
public struct VtDigSig {
    public var wType: UInt16
    public var padding: UInt16
    public var vtValue: VtDigSigValue
    
    public init(dataStream: inout DataStream) throws {
        /// wType (2 bytes): An unsigned integer that MUST be equal to VT_BLOB (0x0041).
        self.wType = try dataStream.read(endianess: .littleEndian)
        if self.wType != 0x0041 {
            throw OfficeFileError.corrupted
        }
        
        /// padding (2 bytes): An unsigned integer that MUST be 0x0000. MUST be ignored.
        self.padding = try dataStream.read(endianess: .littleEndian)
        
        /// vtValue (variable): MUST be a VtDigSigValue (section 2.3.3.1.16) structure.
        self.vtValue = try VtDigSigValue(dataStream: &dataStream)
    }
}
