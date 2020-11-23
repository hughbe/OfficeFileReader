//
//  HyperlinkString.swift
//  
//
//  Created by Hugh Bellamy on 10/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.7.9 HyperlinkString
/// Referenced by: Hyperlink Object
/// This structure specifies a string for a hyperlink.
public struct HyperlinkString {
    public let length: UInt32
    public let string: String
    
    public init(dataStream: inout DataStream) throws {
        /// length (4 bytes): An unsigned integer that specifies the number of Unicode characters in the string field, including the null-terminating
        /// character.
        self.length = try dataStream.read(endianess: .littleEndian)
        
        /// string (variable): A null-terminated array of Unicode characters. The number of characters in the array is specified by the length field.
        self.string = try dataStream.readString(count: Int(self.length - 1), encoding: .utf16LittleEndian)!
        let _: UInt16 = try dataStream.read(endianess: .littleEndian)
    }
}
