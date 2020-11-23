//
//  PBString.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.4.5 PBString
/// Referenced by: FactoidType, PropertyBagStore
/// This structure specifies a null-terminated string encoded either using a Unicode or ANSI character set format.
public struct PBString {
    public let cch: UInt16
    public let fAnsiString: Bool
    public let rgxch: String
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// cch (15 bits): Specifies the count of characters in the string rgxch.
        self.cch = flags.readBits(count: 15)
        
        /// A - fAnsiString (1 bit): If set to 0x1 the string rgxch MUST be an ANSI character set string. If set to 0x0 then it MUST be a Unicode string.
        self.fAnsiString = flags.readBit()
        
        /// rgxch (variable): A null-terminated ANSI character set or a Unicode string depending on the value of fAnsiString field.
        if self.fAnsiString {
            self.rgxch = try dataStream.readString(count: Int(cch), encoding: .ascii)!
            let _: UInt8 = try dataStream.read()
        } else {
            self.rgxch = try dataStream.readString(count: Int(cch * 2), encoding: .utf16LittleEndian)!
            let _: UInt16 = try dataStream.read(endianess: .littleEndian)
        }
    }
}
