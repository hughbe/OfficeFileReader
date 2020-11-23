//
//  BulletFlags.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.22 BulletFlags
/// Referenced by: TextPFException
/// A structure that specifies bullet properties.
public struct BulletFlags {
    public let fHasBullet: Bool
    public let fBulletHasFont: Bool
    public let fBulletHasColor: Bool
    public let fBulletHasSize: Bool
    public let reserved: UInt16
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fHasBullet (1 bit): A bit that specifies whether a bullet exists.
        self.fHasBullet = flags.readBit()
        
        /// B - fBulletHasFont (1 bit): A bit that specifies whether the bullet has a font.
        self.fBulletHasFont = flags.readBit()
        
        /// C - fBulletHasColor (1 bit): A bit that specifies whether the bullet has a color.
        self.fBulletHasColor = flags.readBit()
        
        /// D - fBulletHasSize (1 bit): A bit that specifies whether the bullet has a size.
        self.fBulletHasSize = flags.readBit()
        
        /// reserved (12 bits): MUST be zero and MUST be ignored.
        self.reserved = flags.readRemainingBits()
    }
}
