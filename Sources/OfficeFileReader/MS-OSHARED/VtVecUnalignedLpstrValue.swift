//
//  VtVecUnalignedLpstrValue.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.3.1.9 VtVecUnalignedLpstrValue
/// Referenced by: VtVecUnalignedLpstr
/// Specifies data for a property containing an array of single-byte character strings. This type conforms to the (VT_VECTOR | VT_LPSTR)
/// TypedPropertyValue value format as specified in [MS-OLEPS] section 2.15, except that the sequence of string structures following the cElements
/// field are of type UnalignedLpstr (section 2.3.3.1.5).
public struct VtVecUnalignedLpstrValue {
    public let cElements: UInt32
    public let rgString: [UnalignedLpstr]
    
    public init(dataStream: inout DataStream) throws {
        /// cElements (4 bytes): An unsigned integer specifying the number of elements in rgString.
        self.cElements = try dataStream.read(endianess: .littleEndian)
        
        /// rgString (variable): An array of UnalignedLpstr (section 2.3.3.1.5). Specifies the list of values for the property.
        var rgString: [UnalignedLpstr] = []
        rgString.reserveCapacity(Int(self.cElements))
        for _ in 0..<self.cElements {
            rgString.append(try UnalignedLpstr(dataStream: &dataStream))
        }
        
        self.rgString = rgString
    }
}
