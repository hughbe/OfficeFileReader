//
//  Kcm.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.124 Kcm
/// The Kcm structure specifies a shortcut key combination through a virtual key code and modifiers.
public struct Kcm {
    public let vk: UInt8
    public let fkmShift: Bool
    public let fkmControl: Bool
    public let fkmAlt: Bool
    public let reserved: UInt8
    
    public init(dataStream: inout DataStream) throws {
        /// vk (1 byte): An integer that specifies the Virtual key code for this shortcut key combination.
        self.vk = try dataStream.read()
        
        var flags: BitFieldReader<UInt8> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fkmShift (1 bit): Specifies whether the SHIFT key is pressed in this shortcut key combination.
        self.fkmShift = flags.readBit()
        
        /// B - fkmControl (1 bit): Specifies whether the CTRL key is pressed in this shortcut key combination.
        self.fkmControl = flags.readBit()
        
        /// C - fkmAlt (1 bit): Specifies whether the ALT key is pressed in this shortcut key combination.
        self.fkmAlt = flags.readBit()
        
        /// reserved (5 bits): This value MUST be zero.
        self.reserved = flags.readRemainingBits()
    }
}
