//
//  LSPD.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.146 LSPD
/// The LSPD structure specifies the spacing between lines in a paragraph.
public struct LSPD {
    public let dyaLine: UInt16
    public let fMultLinespace: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// dyaLine (16 bits): An integer that specifies the spacing between lines, based on the following rules:
        ///  dyaLine MUST either be between 0x0000 and 0x7BC0 or between 0x8440 and 0xFFFF.
        ///  When dyaLine is between 0x8440 and 0xFFFF, the line spacing, in twips, is exactly 0x10000 minus dyaLine.
        ///  When fMultLinespace is 0x0001 and dyaLine is between 0x0000 and 0x7BC0, a spacing multiplier is used to determine line spacing for
        /// this paragraph. The spacing multiplier is dyaLine/240. For example, a spacing multiplier value of 1 specifies single spacing; a spacing
        /// multiplier value of 2 specifies double spacing; and so on. The actual line spacing, in twips, is the
        /// spacing multiplier times the font size, in twips.
        ///  When fMultLinespace is 0x0000 and dyaLine is between 0x0000 and 0x7BC0, the line spacing, in twips, is dyaLine or the number of twips
        /// necessary for single spacing, whichever value is greater.
        let dyaLine: UInt16 = try dataStream.read(endianess: .littleEndian)
        if dyaLine > 0x7BC0 && dyaLine < 0x8440 {
            throw OfficeFileError.corrupted
        }
        
        self.dyaLine = dyaLine
        
        /// fMultLinespace (16 bits): An integer which MUST be either 0x0000 or 0x0001.
        self.fMultLinespace = try dataStream.read(endianess: .littleEndian)
        if self.fMultLinespace != 0x0000 && self.fMultLinespace != 0x0001 {
            throw OfficeFileError.corrupted
        }
    }
}
