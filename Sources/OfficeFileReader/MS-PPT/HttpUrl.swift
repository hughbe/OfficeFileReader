//
//  HttpUrl.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-PPT] 2.2.12 HttpUrl
/// Referenced by: BCChatUrlAtom, SlideLibUrlAtom
/// An array of bytes that specifies a UTF-16 Unicode [RFC2781] string. It MUST be a valid URI [RFC3986] with the HTTP scheme.
public struct HttpUrl: ExpressibleByStringLiteral, Hashable {
    public let value: String
    
    public init(stringLiteral value: StringLiteralType) {
        self.value = value
    }
    
    public init(dataStream: inout DataStream, byteCount: Int) throws {
        self.value = try dataStream.readString(count: byteCount, encoding: .utf16LittleEndian)!
    }
}
