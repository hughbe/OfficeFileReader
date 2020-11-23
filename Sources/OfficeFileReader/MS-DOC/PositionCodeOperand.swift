//
//  PositionCodeOperand.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.208 PositionCodeOperand
/// The PositionCodeOperand structure is an operand that specifies the location of an anchor point for an absolutely positioned table or frame.
public struct PositionCodeOperand {
    public let padding: UInt8
    public let pcVert: VerticalPosition
    public let pcHorz: HorizontalPosition
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt8> = try dataStream.readBits(endianess: .littleEndian)
        
        /// padding (4 bits): This value MUST be zero and MUST be ignored.
        self.padding = flags.readBits(count: 4)
        
        /// A - pcVert (2 bits): An unsigned integer that MUST be one of the following values.
        let pcVertRaw = flags.readBits(count: 2)
        guard let pcVert = VerticalPosition(rawValue: pcVertRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.pcVert = pcVert
        
        /// B - pcHorz (2 bits): An unsigned integer that MUST be one of the following values.
        /// Note that all horizontal position measurements are made from the physical left.
        let pcHorzRaw = flags.readBits(count: 2)
        guard let pcHorz = HorizontalPosition(rawValue: pcHorzRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.pcHorz = pcHorz
    }
    
    /// A - pcVert (2 bits): An unsigned integer that MUST be one of the following values.
    public enum VerticalPosition: UInt8 {
        /// 0 The vertical position of the table or frame is relative to the top page margin.
        case relativeToTopPageMargin = 0
        
        /// 1 The vertical position of the table or frame is relative to the top edge of the page.
        case relativeToTopEdgeOfPage = 1
        
        /// 2 The vertical position of the table or frame is relative to the paragraph bottom of the paragraph that precedes it.
        case relativeToParagraphBottomOfPrecedingParagraph = 2
        
        /// 3 None. The table or frame is not absolutely positioned.
        case none = 3
    }
    
    /// B - pcHorz (2 bits): An unsigned integer that MUST be one of the following values.
    /// Note that all horizontal position measurements are made from the physical left.
    public enum HorizontalPosition: UInt8 {
        /// 0 The horizontal position of the table or frame is relative to the left edge of the current column.
        case relativeToLeftEdgeOfCurrentColumn = 0
        
        /// 1 The horizontal position of the table or frame is relative to the left page margin.
        case relativeToLeftPageMargin = 1
        
        /// 2 The horizontal position of the table or frame is relative to the left edge of the page.
        case relativeToLeftEdgeOfPage = 2
        
        /// 3 None. The table or frame is not absolutely positioned.
        case none = 3
    }
}
