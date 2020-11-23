//
//  LSD.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.145 LSD
/// The LSD structure specifies the properties to be used for latent application-defined styles (see StshiLsd) when they are created.
public struct LSD {
    public let fLocked: Bool
    public let fSemiHidden: Bool
    public let fUnhideWhenUsed: Bool
    public let fQFormat: Bool
    public let iPriority: UInt16
    public let fReserved: UInt16
    
    public init(dataStream: inout DataStream) throws {
        var rawValue: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fLocked (1 bit): Specifies the value that the fLocked field of GRFSTD is set to when this latent style is instantiated.
        self.fLocked = rawValue.readBit()
        
        /// B - fSemiHidden (1 bit): Specifies the value that the fSemiHidden field of GRFSTD is set to when this latent style is instantiated.
        self.fSemiHidden = rawValue.readBit()
        
        /// C - fUnhideWhenUsed (1 bit): Specifies the value that the fUnhideWhenUsed field of GRFSTD is set to when this latent
        /// style is instantiated.
        self.fUnhideWhenUsed = rawValue.readBit()
        
        /// D - fQFormat (1 bit): Specifies the value that the fQFormat field of GRFSTD is set to when this latent style is instantiated.
        self.fQFormat = rawValue.readBit()
        
        /// iPriority (12 bits): An unsigned integer that specifies the value that the iPriority field of StdfPost2000 is set to when this
        /// latent style is instantiated. This MUST be a value between 0x0000 and 0x0063, inclusive.
        self.iPriority = UInt16(rawValue.readBits(count: 12))
        if self.iPriority > 0x0063 {
            throw OfficeFileError.corrupted
        }
        
        /// fReserved (16 bits): This value MUST be 0 and MUST be ignored.
        self.fReserved = UInt16(rawValue.rawValue)
    }
}
