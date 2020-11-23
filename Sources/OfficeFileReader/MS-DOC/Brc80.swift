//
//  Brc80.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.17 Brc80
/// The Brc80 structure describes a border.
public struct Brc80 {
    public let dptLineWidth: UInt8
    public let brcType: BrcType
    public let ico: Ico
    public let dptSpace: UInt8
    public let fShadow: Bool
    public let fFrame: Bool
    public let reserved: Bool
    
    public init(dataStream: inout DataStream) throws {
        /// dptLineWidth (8 bits): An unsigned integer that specifies the width of the border in 1/8-point increments. Values of less than 2 are considered
        /// to be equivalent to 2.
        self.dptLineWidth = try dataStream.read(endianess: .littleEndian)
        
        /// brcType (1 byte): A BrcType that specifies the type of this border. This value MUST NOT be 0x1A or 0x1B.
        let brcTypeRaw: UInt8 = try dataStream.read()
        guard let brcType = BrcType(rawValue: brcTypeRaw) else {
            throw OfficeFileError.corrupted
        }
        guard brcType != .outset && brcType != .inst else {
            throw OfficeFileError.corrupted
        }
        
        self.brcType = brcType
        
        /// ico (1 byte): An Ico that specifies the color of this border.
        self.ico = try Ico(dataStream: &dataStream)
        
        var flags: BitFieldReader<UInt8> = try dataStream.readBits(endianess: .littleEndian)
        
        /// dptSpace (5 bits): An unsigned integer that specifies the distance from the text to the border, in points.
        self.dptSpace = flags.readBits(count: 5)
        
        /// A - fShadow (1 bit): If this bit is set, the border has an additional shadow effect. For top and logical left borders, this bit has no visual effect.
        self.fShadow = flags.readBit()
        
        /// B - fFrame (1 bit): Specifies whether the specified border is modified to create a frame effect by reversing the appearance of the border from
        /// the edge nearest the text to the edge furthest from the text. The frame effect shall only be applied to right and bottom borders.
        self.fFrame = flags.readBit()
        
        /// C - reserved (1 bit): This bit MUST be zero, and MUST be ignored.
        self.reserved = flags.readBit()
    }
}
