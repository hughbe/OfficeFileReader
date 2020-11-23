//
//  Brc.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.16 Brc
/// The Brc structure specifies a border.
public struct Brc {
    public let cv: COLORREF
    public let dptLineWidth: UInt8
    public let brcType: BrcType
    public let dptSpace: UInt8
    public let fShadow: Bool
    public let fFrame: Bool
    public let fReserved: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// cv (4 bytes): A COLORREF that specifies the color of this border.
        self.cv = try COLORREF(dataStream: &dataStream)
        
        /// dptLineWidth (8 bits): Specifies the width of the border. Different meanings based on brcType.
        self.dptLineWidth = try dataStream.read(endianess: .littleEndian)
        
        /// brcType (1 byte): A BrcType that specifies the type of this border.
        let brcTypeRaw: UInt8 = try dataStream.read()
        guard let brcType = BrcType(rawValue: brcTypeRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.brcType = brcType
        
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// dptSpace (5 bits): An unsigned integer that specifies the distance from the text to the border, in points. For page borders, sprmSPgbProp can
        /// specify that this value shall specify the distance from the edge of the page to the border.
        self.dptSpace = UInt8(flags.readBits(count: 5))
        
        /// A - fShadow (1 bit): If this bit is set, the border has an additional shadow effect. For top, logical left, and between borders, this has no visual effect.
        self.fShadow = flags.readBit()
        
        /// B - fFrame (1 bit): If this bit is set, then the border has a three-dimensional effect. For top, logical left, and between borders, this has no visual
        /// effect. For visually symmetric border types, this has no visual effect.
        self.fFrame = flags.readBit()
        
        /// fReserved (9 bits): This value is unused and MUST be ignored.
        self.fReserved = flags.readRemainingBits()
    }
}
