//
//  PrintableAnsiString.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.2.22 PrintableAnsiString
/// Referenced by: CurrentUserAtom, DocRoutingSlipString
/// An array of bytes that specifies an ANSI string. It MUST NOT contain the following characters:
/// 0x00 - 0x1F
/// 0x7F - 0x9F
/// The ANSI NULL character (0x00), if present, terminates the string.
public struct PrintableAnsiString {
    public let value: String
    
    public init(dataStream: inout DataStream, byteCount: Int) throws {
        guard let value = try dataStream.readString(count: byteCount, encoding: .ascii) else {
            throw OfficeFileError.corrupted
        }
        
        self.value = value
    }
}
