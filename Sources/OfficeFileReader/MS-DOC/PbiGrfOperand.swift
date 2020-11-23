//
//  PbiGrfOperand.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.176 PbiGrfOperand
/// The PbiGrfOperand structure specifies the properties of a picture bullet.
public struct PbiGrfOperand {
    public let fPicBullet: Bool
    public let fNoAutoSize: Bool
    public let fUnused: UInt16
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fPicBullet (1 bit): Specifies whether the bullet is a picture bullet.
        self.fPicBullet = flags.readBit()
        
        /// B - fNoAutoSize (1 bit): Specifies whether the size of the picture changes automatically to match the size of the text that follows the bullet.
        self.fNoAutoSize = flags.readBit()
        
        /// fUnused (14 bits): This field is undefined and MUST be ignored.
        self.fUnused = flags.readRemainingBits()
    }
}
