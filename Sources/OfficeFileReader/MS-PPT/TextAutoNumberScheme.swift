//
//  TextAutoNumberScheme.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.27 TextAutoNumberScheme
/// Referenced by: TextPFException9
/// A structure that specifies the automatic numbering scheme for text paragraphs.
public struct TextAutoNumberScheme {
    public let scheme: TextAutoNumberSchemeEnum
    public let startNum: Int16
    
    public init(dataStream: inout DataStream) throws {
        /// scheme (2 bytes): A TextAutoNumberSchemeEnum enumeration that specifies the scheme. The scheme describes the style of the number bullets.
        let schemeRaw: UInt16 = try dataStream.read(endianess: .littleEndian)
        guard let scheme = TextAutoNumberSchemeEnum(rawValue: schemeRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.scheme = scheme
        
        /// startNum (2 bytes): A signed integer that specifies the numeric value of the first number assigned. It MUST be greater than or equal to 0x0001.
        self.startNum = try dataStream.read(endianess: .littleEndian)
        if self.startNum < 0x0001 {
            throw OfficeFileError.corrupted
        }
    }
}
