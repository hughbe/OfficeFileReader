//
//  CSymbolOperand.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.47 CSymbolOperand
/// The CSymbolOperand structure specifies the properties of a symbol character.
public struct CSymbolOperand {
    public let ftc: UInt16
    public let xchar: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// ftc (2 bytes): A 16-bit unsigned integer that is an index into the font table SttbfFfn and that specifies the font for this symbol.
        self.ftc = try dataStream.read(endianess: .littleEndian)
        
        /// xchar (2 bytes): A 16-bit unsigned integer that specifies the Unicode character code of the specified font.
        self.xchar = try dataStream.read(endianess: .littleEndian)
    }
}
