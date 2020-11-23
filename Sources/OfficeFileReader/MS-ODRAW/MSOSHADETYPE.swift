//
//  MSOSHADETYPE.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.50 MSOSHADETYPE
/// Referenced by: fillShadeType
/// The MSOSHADETYPE record specifies the interpolation of colors between the color/position values that are stated for the fill. The values can be combined
/// to produce compound effects.
public struct MSOSHADETYPE {
    public let msoshadeNone: Bool
    public let msoshadeGamma: Bool
    public let msoshadeSigma: Bool
    public let msoshadeBand: Bool
    public let msoshadeOneColor: Bool
    public let unused1: UInt32
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - msoshadeNone (1 bit): A bit that specifies whether color correction will be performed after interpolation. A value of 0x1 specifies that no
        /// color correction will be performed after interpolation.
        self.msoshadeNone = flags.readBit()
        
        /// B - msoshadeGamma (1 bit): A bit that specifies whether gamma correction will be applied after interpolation.
        self.msoshadeGamma = flags.readBit()
        
        /// C - msoshadeSigma (1 bit): A bit that specifies whether a sigma transfer function will be applied after interpolation.
        self.msoshadeSigma = flags.readBit()
        
        /// D - msoshadeBand (1 bit): A bit that specifies whether a flat band will be added at the start of the interpolation.
        self.msoshadeBand = flags.readBit()
        
        /// E - msoshadeOneColor (1 bit): A bit that specifies whether only one color will be used for the fill color.
        self.msoshadeOneColor = flags.readBit()
        
        /// unused1 (27 bits): A value that is undefined and MUST be ignored.
        self.unused1 = flags.readRemainingBits()
    }
}
