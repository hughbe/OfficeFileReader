//
//  VtVecLpwstr.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.3.1.8 VtVecLpwstr
/// Specifies the format of a property for which the value is a list of Unicode strings. This type conforms to the (VT_VECTOR | VT_LPWSTR)
/// TypedPropertyValue type as specified in [MS-OLEPS] section 2.15, except that the format of the strings it contains is as specified in this
/// specification.
public struct VtVecLpwstr {
    public let wType: UInt16
    public let padding: UInt16
    public let vtValue: VtVecLpwstrValue
    
    public init(dataStream: inout DataStream) throws {
        /// wType (2 bytes): An unsigned integer that MUST be equal to VT_VECTOR | VT_LPWSTR (0x101F).
        self.wType = try dataStream.read(endianess: .littleEndian)
        if self.wType != 0x101F {
            throw OfficeFileError.corrupted
        }
        
        /// padding (2 bytes): An unsigned integer that MUST be 0x0000. MUST be ignored.
        self.padding = try dataStream.read(endianess: .littleEndian)
        
        /// vtValue (variable): MUST be a VtVecLpwstrValue (section 2.3.3.1.7) structure.
        self.vtValue = try VtVecLpwstrValue(dataStream: &dataStream)
    }
}
