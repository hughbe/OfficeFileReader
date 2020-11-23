//
//  MachineName.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-PPT] 2.2.14 MachineName
/// Referenced by: BCNetShowServerNameAtom, BCRexServerNameAtom
/// An array of bytes that specifies a UTF-16 Unicode [RFC2781] string that specifies a computer name.
/// See [MSDN-FILE] for more information about computer naming.
public struct MachineName: ExpressibleByStringLiteral, Hashable {
    public let value: String
    
    public init(stringLiteral value: StringLiteralType) {
        self.value = value
    }
    
    public init(dataStream: inout DataStream, byteCount: Int) throws {
        self.value = try dataStream.readString(count: byteCount, encoding: .utf16LittleEndian)!
    }
}

