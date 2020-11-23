//
//  FrameTextFlowOperand.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.95 FrameTextFlowOperand
/// The FrameTextFlowOperand structure specifies the direction of text flow for a frame.
public struct FrameTextFlowOperand {
    public let fVertical: Bool
    public let fBackwards: Bool
    public let fRotateFont: Bool
    public let reserved: UInt16
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fVertical (1 bit): A bit that specifies that text flows vertically instead of horizontally.
        self.fVertical = flags.readBit()
        
        /// B - fBackwards (1 bit): A bit that specifies that vertical text flow is from bottom to top. If this bit is set, fVertical MUST also be set.
        self.fBackwards = flags.readBit()
        
        /// C - fRotateFont (1 bit): A bit that specifies that non-Latin text flow is rotated 90 degrees counterclockwise.
        self.fRotateFont = flags.readBit()
        
        /// reserved (13 bits): This value MUST be zero and MUST be ignored.
        self.reserved = flags.readRemainingBits()
    }
}
