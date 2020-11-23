//
//  CSSA.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.45 CSSA
/// The CSSA structure specifies a cell spacing SPRM argument used by many Table SPRMs to define table cell margins and cell spacing.
public struct CSSA {
    public let itc: ItcFirstLim
    public let grfbrc: CellMarginOrSpacingSide
    public let ftsWidth: Fts
    public let wWidth: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// itc (2 bytes): An ItcFirstLim that specifies which cells this CSSA structure applies to.
        self.itc = try ItcFirstLim(dataStream: &dataStream)
        
        /// grfbrc (1 byte): A bit field that specifies which cell sides this cell margin or cell spacing applies to. The bit values and their meanings are as follows.
        self.grfbrc = CellMarginOrSpacingSide(rawValue: try dataStream.read())
        
        /// ftsWidth (1 byte): An Fts that specifies how wWidth is defined.
        let ftsWidthRaw: UInt8 = try dataStream.read()
        guard let ftsWidth = Fts(rawValue: ftsWidthRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.ftsWidth = ftsWidth
        
        /// wWidth (2 bytes): An unsigned integer value that specifies the cell margin or cell spacing that is applied to cells itc.itcFirst through itc.itcLim – 1.
        /// The interpretation of this value depends on the value of ftsWidth. If ftsWidth is ftsNil (0x00), then wWidth MUST be zero.
        self.wWidth = try dataStream.read(endianess: .littleEndian)
        if ftsWidth == .nil && self.wWidth != 0 {
            throw OfficeFileError.corrupted
        }
    }
    
    /// grfbrc (1 byte): A bit field that specifies which cell sides this cell margin or cell spacing applies to.
    /// The bit values and their meanings are as follows.
    public struct CellMarginOrSpacingSide: OptionSet {
        public let rawValue: UInt8
        
        public init(rawValue: UInt8) {
            self.rawValue = rawValue
        }
        
        /// fbrcTop 0x01 Specifies the top side.
        public static let top = CellMarginOrSpacingSide(rawValue: 0x01)
        
        /// fbrcLeft 0x02 Specifies the left side.
        public static let left = CellMarginOrSpacingSide(rawValue: 0x02)
        
        /// fbrcBottom 0x04 Specifies the bottom side.
        public static let bottom = CellMarginOrSpacingSide(rawValue: 0x04)
        
        /// fbrcRight 0x08 Specifies the right side.
        public static let right = CellMarginOrSpacingSide(rawValue: 0x08)
        
        /// Setting all four side bits results in fBrcSidesOnly (0x0F). All other bits MUST be 0
        public static let sidesOnly = CellMarginOrSpacingSide(rawValue: 0x0F)
        
        public static let all: CellMarginOrSpacingSide = [.top, .left, .bottom, .right, .sidesOnly]
    }
}
