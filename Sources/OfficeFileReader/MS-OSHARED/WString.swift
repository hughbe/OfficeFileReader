//
//  WString.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.1.4 WString
/// Referenced by: TB, TBCBSpecific, TBCCDData, TBCExtraInfo, TBCGeneralInfo, TBCMenuSpecific
/// String structure that toolbar customization structures use. This structure specifies a non-nullterminated Unicode string.
public struct WString {
    public let cLen: UInt8
    public let data: String
    
    public init(dataStream: inout DataStream) throws {
        /// cLen (1 byte): Unsigned integer that specifies the count of characters in this string.
        self.cLen = try dataStream.read()
        
        /// data (variable): Array of Unicode characters. The number of characters in the array MUST be equal to the value of the cLen field.
        /// Because this is a non-null-terminated Unicode string all of the elements of this string MUST NOT have a value of 0x0000.
        self.data = try dataStream.readString(count: Int(self.cLen) * 2, encoding: .utf16LittleEndian)!
    }
}
