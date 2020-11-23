//
//  TCGRF.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.317 TCGRF
/// A TCGRF structure specifies the text layout and cell merge properties for a single cell in a table.
public struct TCGRF {
    public let horzMerge: HorizontalMerge
    public let textFlow: TextFlow
    public let vertAlign: VerticalAlign
    public let ftsWidth: Fts
    public let fFitText: Bool
    public let fNoWrap: Bool
    public let fHideMark: Bool
    public let fUnused: Bool
    
    public init() {
        self.horzMerge = .notMerged
        self.textFlow = .rtb
        self.vertAlign = .top
        self.ftsWidth = .nil
        self.fFitText = false
        self.fNoWrap = false
        self.fHideMark = false
        self.fUnused = false
    }
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - horzMerge (2 bits): A value that specifies how this cell merges horizontally with the neighboring cells in the same row. This value
        /// MUST be one of the following.
        let horzMergeRaw = UInt8(flags.readBits(count: 2))
        guard let horzMerge = HorizontalMerge(rawValue: horzMergeRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.horzMerge = horzMerge
        
        /// B - textFlow (3 bits): A value from the TextFlow enumeration that specifies rotation settings for the text in the cell.
        let textFlowRaw = UInt8(flags.readBits(count: 3))
        guard let textFlow = TextFlow(rawValue: UInt16(textFlowRaw)) else {
            throw OfficeFileError.corrupted
        }
        
        self.textFlow = textFlow
        
        /// D - vertAlign (2 bits): A value from the VerticalAlign enumeration that specifies how contents inside this cell are aligned.
        let vertAlignRaw = UInt8(flags.readBits(count: 2))
        guard let vertAlign = VerticalAlign(rawValue: vertAlignRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.vertAlign = vertAlign
        
        /// E - ftsWidth (3 bits): An Fts value that specifies the unit of measurement for the wWidth field in the TC80 structure.
        let ftsWidthRaw = UInt8(flags.readBits(count: 3))
        guard let ftsWidth = Fts(rawValue: ftsWidthRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.ftsWidth = ftsWidth
        
        /// F - fFitText (1 bit): Specifies whether the contents of the cell are to be stretched out such that the full cell width is used.
        self.fFitText = flags.readBit()
        
        /// G - fNoWrap (1 bit): When set, specifies that the preferred layout of the contents of this cell is as a single line and that cell widths can
        /// be adjusted to accommodate long lines. This preference is ignored when the preferred width of this cell is set to ftsDxa.
        self.fNoWrap = flags.readBit()
        
        /// H - fHideMark (1 bit): When set, specifies that this cell is rendered with no height if all cells in the row are empty.
        self.fHideMark = flags.readBit()
        
        /// I - fUnused (1 bit): This bit MUST be ignored.
        self.fUnused = flags.readBit()
    }
    
    /// A - horzMerge (2 bits): A value that specifies how this cell merges horizontally with the neighboring cells in the same row. This value
    /// MUST be one of the following.
    public enum HorizontalMerge: UInt8 {
        /// 0 The cell is not merged with the cells on either side of it.
        case notMerged = 0
        
        /// 1 The cell is one of a set of horizontally merged cells. It contributes its layout region to the set and its own contents are not rendered.
        case oneOfSetOfHorizontallyMergedCells = 1
        
        /// 2, 3 The cell is the first cell in a set of horizontally merged cells. The contents and formatting of this cell extend into any consecutive
        /// cells following it that are designated as part of the merged set.
        case firstCellInSetOfHorizontallyMergedCells1 = 2
    
        /// 2, 3 The cell is the first cell in a set of horizontally merged cells. The contents and formatting of this cell extend into any consecutive
        /// cells following it that are designated as part of the merged set.
        case firstCellInSetOfHorizontallyMergedCells2 = 3
    }
}
