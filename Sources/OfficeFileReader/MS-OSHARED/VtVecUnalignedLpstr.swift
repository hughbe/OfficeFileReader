//
//  VtVecUnalignedLpstr.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.3.1.10 VtVecUnalignedLpstr
/// Specifies the format of a property for which the value is a list of single-byte character strings. This type conforms to the (VT_VECTOR | VT_LPSTR)
/// TypedPropertyValue type as specified in [MSOLEPS] section 2.15, except that the format of the strings it contains is as specified in this specification.
public struct VtVecUnalignedLpstr {
    public let wType: UInt16
    public let padding: UInt16
    public let vtValue: VtVecUnalignedLpstrValue
    
    public init(dataStream: inout DataStream) throws {
        /// wType (2 bytes): An unsigned integer that MUST be VT_VECTOR | VT_LPSTR (0x101E).
        self.wType = try dataStream.read(endianess: .littleEndian)
        if self.wType != 0x101E {
            throw OfficeFileError.corrupted
        }
        
        /// padding (2 bytes): An unsigned integer that MUST be 0x0000. MUST be ignored.
        self.padding = try dataStream.read(endianess: .littleEndian)
        
        /// vtValue (variable): MUST be a VtVecUnalignedLpstrValue (section 2.3.3.1.9) structure.
        self.vtValue = try VtVecUnalignedLpstrValue(dataStream: &dataStream)
    }
}
