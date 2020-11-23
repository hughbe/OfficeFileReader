//
//  VtVecLpwstrValue.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.3.1.7 VtVecLpwstrValue
/// Referenced by: VtVecLpwstr
/// Specifies data for a property containing an array of Unicode strings. This type conforms to the (VT_VECTOR | VT_LPWSTR) TypedPropertyValue
/// value format as specified in [MS-OLEPS] section 2.15, except that the sequence of string structures following the cElements field are of type
/// Lpwstr (section 2.3.3.1.6).
public struct VtVecLpwstrValue {
    public let cElements: UInt32
    public let rgString: [Lpwstr]
    
    public init(dataStream: inout DataStream) throws {
        /// cElements (4 bytes): An unsigned integer specifying the number of elements in rgString.
        self.cElements = try dataStream.read(endianess: .littleEndian)
        
        /// rgString (variable): An array of Lpwstr (section 2.3.3.1.6). Specifies the list of values for the property.
        var rgString: [Lpwstr] = []
        rgString.reserveCapacity(Int(self.cElements))
        for _ in 0..<self.cElements {
            rgString.append(try Lpwstr(dataStream: &dataStream))
        }
        
        self.rgString = rgString
    }
}
