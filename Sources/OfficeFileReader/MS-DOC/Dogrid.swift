//
//  Dogrid.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.7.15 Dogrid
/// The Dogrid structure specifies parameters for the drawn object properties of the document.
public struct Dogrid {
    public let xaGrid: XAS_nonNeg
    public let yaGrid: YAS_nonNeg
    public let dxaGrid: XAS_nonNeg
    public let dyaGrid: YAS_nonNeg
    public let dyGridDisplay: UInt8
    public let unused: Bool
    public let dxGridDisplay: UInt8
    public let fFollowMargins: Bool
    
    public init(dataStream: inout DataStream) throws {
        /// xaGrid (2 bytes): An XAS_nonNeg that specifies horizontal origin point of the drawing grid. See [ECMA-376] Part 4, Section 2.15.1.43
        /// (drawingGridHorizontalOrigin), where doNotUseMarginsForDrawingGridOrigin has the opposite meaning of fFollowMargins. The default value
        /// is 1701.
        self.xaGrid = try XAS_nonNeg(dataStream: &dataStream)
        
        /// yaGrid (2 bytes): A YAS_nonNeg that specifies the vertical origin point of the drawing grid. See [ECMA-376] Part 4, Section 2.15.1.45
        /// (drawingGridVerticalOrigin), where doNotUseMarginsForDrawingGridOrigin has the opposite meaning of fFollowMargins. The default value is
        /// 1984.
        self.yaGrid = try YAS_nonNeg(dataStream: &dataStream)
        
        /// dxaGrid (2 bytes): An XAS_nonNeg that specifies the horizontal grid unit size of the drawing grid. See [ECMA-376] Part 4, Section 2.15.1.44
        /// (drawingGridHorizontalSpacing). The default value is 180.
        self.dxaGrid = try XAS_nonNeg(dataStream: &dataStream)
        
        /// dyaGrid (2 bytes): A YAS_nonNeg that specifies the vertical grid unit size of the drawing grid. See [ECMA-376] Part 4, Section 2.15.1.46
        /// (drawingGridVerticalSpacing). The default value is 180.
        self.dyaGrid = try YAS_nonNeg(dataStream: &dataStream)
        
        var flags1: BitFieldReader<UInt8> = try dataStream.readBits(endianess: .littleEndian)
        
        /// dyGridDisplay (7 bits): A positive value, in units specified by dyaGrid, that specifies the distance between vertical gridlines. See [ECMA-376]
        /// Part 4, Section 2.15.1.27 (displayVerticalDrawingGridEvery) where drawingGridVerticalSpacing refers to dyaGrid. The default value is 1.
        self.dyGridDisplay = flags1.readBits(count: 7)
        
        /// A - unused (1 bit): This value is undefined, and MUST be ignored.
        self.unused = flags1.readBit()
        
        var flags2: BitFieldReader<UInt8> = try dataStream.readBits(endianess: .littleEndian)
        
        /// dxGridDisplay (7 bits): A positive value, in units specified by dxaGrid, that specifies the distance between horizontal gridlines. See [ECMA-376]
        /// Part 4, Section 2.15.1.26. (displayHorizontalDrawingGridEvery) where drawingGridHorizontalSpacing refers to dxaGrid. The default value is 1.
        self.dxGridDisplay = flags2.readBits(count: 7)
        
        /// B - fFollowMargins (1 bit): A value that specifies whether to use margins for drawing grid origin. See [ECMA-376] Part 4, Section 2.15.1.41
        /// (doNotUseMarginsForDrawingGridOrigin), where the meaning is the opposite of fFollowMargins. The default is 1.
        self.fFollowMargins = flags2.readBit()
    }
}
