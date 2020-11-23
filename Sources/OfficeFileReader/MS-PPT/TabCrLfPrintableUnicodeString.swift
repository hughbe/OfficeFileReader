//
//  TabCrLfPrintableUnicodeString.swift
//
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-PPT] 2.2.28 TabCrLfPrintableUnicodeString
/// Referenced by: Comment10TextAtom
/// An array of bytes that specifies a UTF-16 Unicode [RFC2781] string. It MUST NOT contain the following characters:
///  0x0000 - 0x0008
///  0x000B
///  0x000C
///  0x000E - 0x001F
///  0x007F - 0x009F
/// The Unicode NULL character (0x0000), if present, terminates the string.
public struct TabCrLfPrintableUnicodeString: ExpressibleByStringLiteral, Hashable {
    public let value: String
    
    public init(stringLiteral value: StringLiteralType) {
        self.value = value
    }
    
    public init(dataStream: inout DataStream, byteCount: Int) throws {
        self.value = try dataStream.readString(count: byteCount, encoding: .utf16LittleEndian)!
    }
}
