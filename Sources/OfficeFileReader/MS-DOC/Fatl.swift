//
//  Fatl.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.69 Fatl
/// The Fatl structure is a bit field that SHOULD<212> specify which optional formats from a table style or table auto-format are enabled.
/// Not all formatting categories are available for every table style or table auto-format.
public struct Fatl {
    public let fatlBorders: Bool
    public let fatlShading: Bool
    public let fatlFont: Bool
    public let fatlColor: Bool
    public let fatlBestFit: Bool
    public let fatlHdrRows: Bool
    public let fatlLastRow: Bool
    public let fatlHdrCols: Bool
    public let fatlLastCol: Bool
    public let fatlNoRowBands: Bool
    public let fatlNoColBands: Bool
    public let padding: UInt8
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fatlBorders (1 bit): This bit MAY<213> specify that the border formats of a table auto-format were applied by the last table auto-format.
        self.fatlBorders = flags.readBit()
        
        /// B - fatlShading (1 bit): This bit MAY<214> specify that the background shading formats of a table auto-format were applied by the
        /// last table auto-format.
        self.fatlShading = flags.readBit()
        
        /// C - fatlFont (1 bit): This bit MAY<215> specify that the text font formats of a table auto-format were applied by the last table auto-format.
        self.fatlFont = flags.readBit()
        
        /// D - fatlColor (1 bit): This bit MAY<216> specify that a color variant of a table auto-format was applied by the last table auto-format.
        /// When this bit is not set, the monochrome variant was applied.
        self.fatlColor = flags.readBit()
        
        /// E - fatlBestFit (1 bit): This bit MAY<217> specify that the columns of the table were resized to best fit their contents during the last
        /// table auto-format.
        self.fatlBestFit = flags.readBit()
        
        /// F - fatlHdrRows (1 bit): This bit SHOULD<218> specify that the top row of the table receives special formatting.
        self.fatlHdrRows = flags.readBit()
        
        /// G - fatlLastRow (1 bit): This bit SHOULD<219> specify that the bottom row of the table receives special formatting.
        self.fatlLastRow = flags.readBit()
        
        /// H - fatlHdrCols (1 bit): This bit SHOULD<220> specify that the logically leftmost column receives special formatting.
        self.fatlHdrCols = flags.readBit()
        
        /// I - fatlLastCol (1 bit): This bit SHOULD<221> specify that the logically rightmost column receives special formatting.
        self.fatlLastCol = flags.readBit()
        
        /// J - fatlNoRowBands (1 bit): This bit SHOULD<222> specify that odd numbered rows do not receive different formatting than even
        /// numbered rows.
        self.fatlNoRowBands = flags.readBit()
        
        /// K - fatlNoColBands (1 bit): This bit SHOULD<223> specify that odd numbered columns do not receive different formatting than even
        /// numbered columns.
        self.fatlNoColBands = flags.readBit()
        
        /// padding (5 bits): This MUST be zero and MUST be ignored.
        self.padding = UInt8(flags.readRemainingBits())
    }
}
