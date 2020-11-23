//
//  Utf8UnicodeString.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-PPT] 2.2.36 Utf8UnicodeString
/// Referenced by: RoundTripColorMappingAtom
/// An array of bytes that specifies a UTF-8 Unicode [RFC3629] string. It MUST be valid XML as defined in [XML10/5].
public struct Utf8UnicodeString: ExpressibleByStringLiteral, Hashable {
    public let value: String
    
    public init(stringLiteral value: StringLiteralType) {
        self.value = value
    }
    
    public init(dataStream: inout DataStream, byteCount: Int) throws {
        self.value = try dataStream.readString(count: byteCount, encoding: .utf8)!
    }
}

