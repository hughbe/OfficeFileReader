//
//  Lstsf.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.148 Lstsf
/// The Lstsf structure specifies a list style.
public struct Lstsf {
    public let ilst: UInt16
    public let istdList: UInt16
    public let fStyleDef: Bool
    public let fUnused: UInt8
    
    public init(dataStream: inout DataStream) throws {
        /// ilst (2 bytes): An unsigned integer that specifies a zero-based index into the Plflst.
        self.ilst = try dataStream.read(endianess: .littleEndian)
        
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)

        /// istdList (12 bits): An unsigned integer that specifies the ISTD for the list style. To determine the text properties, see Determining Properties of a
        /// Style (section 2.4.6.5).
        self.istdList = flags.readBits(count: 12)
        
        /// A - fStyleDef (1 bit): A bit flag that specifies the type of this list definition. If fStyleDef is "true", this Lstsf is a list style definition, meaning that a
        /// custom numbered or bulleted list style was defined. In this case, ilst specifies which custom list style is to be used. If fStyleDef is "false", it
        /// means that a standard list style is used. In this case, istdList specifies which standard style to use.
        self.fStyleDef = flags.readBit()
        
        /// B - fUnused (3 bits): This field MUST be zero and MUST be ignored.
        self.fUnused = UInt8(flags.readRemainingBits())
    }
}
