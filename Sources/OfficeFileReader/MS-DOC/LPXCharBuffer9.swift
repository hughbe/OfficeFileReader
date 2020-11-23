//
//  LPXCharBuffer9.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.144 LPXCharBuffer9
/// The LPXCharBuffer9 structure is a length-prefixed buffer for up to 9 Unicode characters. The text is not null-terminated.
public struct LPXCharBuffer9 {
    public let cch: UInt16
    public let xcharArray: [UInt8]
    
    public var stringValue: String {
        if self.cch == 0 {
            return ""
        }

        return String(bytes: xcharArray[0..<Int(cch)], encoding: .utf16LittleEndian)!
    }
    
    public init(dataStream: inout DataStream) throws {
        /// cch (2 bytes): An unsigned integer that specifies the number of characters from the buffer that are actually used. This value MUST be less than
        /// or equal to 9.
        self.cch = try dataStream.read(endianess: .littleEndian)
        if self.cch > 9 {
            throw OfficeFileError.corrupted
        }
        
        /// xcharArray (18 bytes): An array of 16-bit Unicode characters. The first cch characters make a Unicode string. The remaining characters MUST
        /// be ignored.
        self.xcharArray = try dataStream.readBytes(count: 18)
    }
}
