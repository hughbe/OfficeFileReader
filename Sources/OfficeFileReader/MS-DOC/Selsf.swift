//
//  Selsf.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.244 Selsf
/// The Selsf structure specifies the last selection that was made to the document.
public struct Selsf {
    public let fRightward: Bool
    public let unused1: Bool
    public let fWithinCell: Bool
    public let fTableAnchor: Bool
    public let fTableSelNonShrink: Bool
    public let unused2: Bool
    public let fDiscontiguous: Bool
    public let fPrefix: Bool
    public let fShape: Bool
    public let fFrame: Bool
    public let fColumn: Bool
    public let fTable: Bool
    public let fGraphics: Bool
    public let fBlock: Bool
    public let unused3: Bool
    public let fIns: Bool
    public let fForward: UInt8
    public let fPrefixW2007: Bool
    public let fInsEnd: UInt8
    public let cpFirst: Int32
    public let cpLim: Int32
    public let unused4: UInt32
    public let blktblSel: UInt32
    public let cpAnchor: Int32
    public let sty: Sty
    public let unused5: UInt16
    public let cpAnchorShrink: Int32
    public let xaTableLeft: Int16
    public let xaTableRight: Int16
    
    public init(dataStream: inout DataStream) throws {
        var flags1: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fRightward (1 bit): A bit that specifies whether the selection was made from the physical left to the physical right. If fBlock is 0, this bit is
        /// undefined and MUST be ignored.
        self.fRightward = flags1.readBit()
        
        /// B - unused1 (1 bit): This bit is undefined and MUST be ignored.
        self.unused1 = flags1.readBit()
        
        /// C - fWithinCell (1 bit): A bit that specifies that the selection is content within a table cell. This value MUST be 0 if the selection contains only
        /// whole table cells.
        self.fWithinCell = flags1.readBit()
        
        /// D - fTableAnchor (1 bit): If this bit is 1, then the selection began with either table content or table cells.
        self.fTableAnchor = flags1.readBit()
        
        /// E - fTableSelNonShrink (1 bit): If this bit is 1, then the selection began with the use of the mouse to select the whole table cell and that the
        /// selection contains only whole table cells.
        self.fTableSelNonShrink = flags1.readBit()
        
        /// F - unused2 (1 bit): This bit is undefined and MUST be ignored.
        self.unused2 = flags1.readBit()
        
        /// G - fDiscontiguous (1 bit): If this bit is 1, then the selection was made of two or more ranges within the document. The Selsf structure describes
        /// only the most recent range that was selected.
        self.fDiscontiguous = flags1.readBit()
        
        /// H - fPrefix (1 bit): If this bit is 1, then the selection is a bullet in a bulleted list or a number in a numbered list.
        self.fPrefix = flags1.readBit()
        
        /// I - fShape (1 bit): A bit that specifies that the selection is a shape or floating picture. This value MUST be 0 if the selection is a textbox or inline
        /// picture.
        self.fShape = flags1.readBit()
        
        /// J - fFrame (1 bit): A bit that specifies that the selection is a text frame. This value MUST be 0 if the selection is a textbox.
        self.fFrame = flags1.readBit()
        
        /// K - fColumn (1 bit): If this bit is 1, then the selection contains one or more whole table cells. This bit MUST be 0 if the selection was made strictly
        /// of whole table rows or the entire table.
        self.fColumn = flags1.readBit()
        
        /// L - fTable (1 bit): If this bit is 1, then the selection contains one or more whole table cells.
        self.fTable = flags1.readBit()
        
        /// M - fGraphics (1 bit): A bit that specifies that the selection is an inline picture. This value MUST be 0 if the selection is a floating picture.
        self.fGraphics = flags1.readBit()
        
        /// N - fBlock (1 bit): A bit that specifies that the selection was made of a rectangular block. If fTable is 0, the selection is a block of text and MUST
        /// NOT contain table content. If fTable is 1, the selection is a block of table cells; fBlock MUST be 0 if the table selection is restricted to
        /// whole table rows or is the entire table.
        self.fBlock = flags1.readBit()
        
        /// O - unused3 (1 bit): This bit is undefined and MUST be 0.
        self.unused3 = flags1.readBit()
        
        /// P - fIns (1 bit): A bit that specifies that the selection is an insertion point. If fIns is 1, cpFirst MUST equal cpLim.
        let fIns = flags1.readBit()
        self.fIns = fIns
        
        var flags2: BitFieldReader<UInt8> = try dataStream.readBits(endianess: .littleEndian)
        
        /// fForward (7 bits): An unsigned integer that MUST be 0 or 1. This field specifies that the selection was made in a downward direction or towards
        /// the logical right if the value is 1.
        self.fForward = flags2.readBits(count: 7)
        
        /// Q - fPrefixW2007 (1 bit): A bit that SHOULD<238> be 0 and MUST be ignored.
        self.fPrefixW2007 = flags2.readBit()
        
        /// fInsEnd (8 bits): An unsigned integer value that MUST be 0 or 1. If this value is 1, the selection is an insertion point at the end of the line, as
        /// opposed to at the beginning of the following line. If fInsEnd is 1, fIns MUST also be 1. If fShape is 1, fInsEnd is undefined and MUST be ignored.
        /// If the selection does not fall at a line break, fInsEnd MUST be ignored.
        let fInsEnd: UInt8 = try dataStream.read(endianess: .littleEndian)
        if !self.fShape {
            if fInsEnd != 0 && fInsEnd != 1 {
                throw OfficeFileError.corrupted
            }
            
            if fInsEnd == 1 && !fIns {
                throw OfficeFileError.corrupted
            }
        }
        
        self.fInsEnd = fInsEnd
        
        /// cpFirst (4 bytes): A signed integer that specifies the start point, in characters, of the selection range. This value MUST be at least 0, and MUST
        /// NOT exceed the end of the text piece. If the selection begins with whole table cells, cpFirst MUST be the location of the beginning of the row
        /// that contains the first selected cell. If the selection is a block selection of text, cpFirst MUST be the location of the beginning of the first line
        /// that contains selected characters.
        let cpFirst: Int32 = try dataStream.read(endianess: .littleEndian)
        if cpFirst < 0 {
            throw OfficeFileError.corrupted
        }
        
        self.cpFirst = cpFirst
        
        /// cpLim (4 bytes): A signed integer that specifies the endpoint, in characters, of the selection range. This value MUST be at least 0, MUST be
        /// greater than or equal to cpFirst, and MUST NOT exceed the end of the document. If the selection ends with whole table cells, cpLim MUST
        /// be the location of the end of the row that contains the last selected cell. If the selection is a block selection of text, cpLim MUST be the
        /// location of the beginning of the last line that contains selected characters.
        let cpLim: Int32 = try dataStream.read(endianess: .littleEndian)
        if cpLim < 0 || cpLim < cpFirst {
            throw OfficeFileError.corrupted
        }
        
        self.cpLim = cpLim
        
        /// unused4 (4 bytes): Undefined and MUST be ignored.
        self.unused4 = try dataStream.read(endianess: .littleEndian)
        
        /// blktblSel (4 bytes): Specifies a selection range. The interpretation of blktblSel depends on the values of fTable and fBlock, which are provided
        /// following.
        /// fTable fBlock Interpretation
        /// 0 0 blktblSel is undefined and MUST be ignored.
        /// 0 1 blktblSel is a BlockSel and specifies the dimensions of a block selection.
        /// 1 0 blktblSel is a TableSel and specifies a row selection.
        /// 1 1 blktblSel is a TableSel and specifies a range of table cells.
        self.blktblSel = try dataStream.read(endianess: .littleEndian)
        
        /// cpAnchor (4 bytes): A signed integer that specifies the point, in characters, at which the selection initially began. This value MUST be greater than
        /// or equal to cpFirst. If the selection was automatically extended to include text before cpAnchor, cpFirst is less than cpAnchor. If the selection was
        /// not extended before the point where the selection began, cpAnchor is equal to cpFirst.
        self.cpAnchor = try dataStream.read(endianess: .littleEndian)
        if self.cpAnchor < cpFirst {
            throw OfficeFileError.corrupted
        }
        
        /// sty (2 bytes): A Sty structure that specifies the type of selection that was made.
        let styRaw: UInt16 = try dataStream.read(endianess: .littleEndian)
        guard let sty = Sty(rawValue: styRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.sty = sty
        
        /// unused5 (2 bytes): This field is undefined and MUST be ignored.
        self.unused5 = try dataStream.read(endianess: .littleEndian)
        
        /// cpAnchorShrink (4 bytes): A signed integer that specifies the point, in characters, where a block selection began. If fBlock is 0 or fTable is 1,
        /// cpAnchorShrink is undefined and MUST be ignored.
        self.cpAnchorShrink = try dataStream.read(endianess: .littleEndian)
        
        /// xaTableLeft (2 bytes): A signed integer that specifies, in twips, the physical left edge of the first selected cell if the selection contains whole table
        /// cells. This value MUST be in the range of -31680 to 31680, inclusive. If the entire row is selected, xaTableLeft MUST be -31680. If the selection
        /// does not contain whole table cells, xaTableLeft is undefined and MUST be ignored.
        let xaTableLeft: Int16 = try dataStream.read(endianess: .littleEndian)
        if xaTableLeft < -31680 || xaTableLeft > 31860 {
            throw OfficeFileError.corrupted
        }
        
        self.xaTableLeft = xaTableLeft
        
        /// xaTableRight (2 bytes): A signed integer that specifies, in twips, the physical right edge of the last selected cell if the selection contains whole
        /// table cells. This value MUST be in the range of -31680 to 31680, inclusive, and MUST be greater than or equal to xaTableLeft. If the entire row is
        /// selected, xaTableRight MUST be 31680. If the selection does not contain whole table cells, xaTableRight is undefined and MUST be ignored.
        let xaTableRight: Int16 = try dataStream.read(endianess: .littleEndian)
        if xaTableRight < -31680 || xaTableRight > 31860 {
            throw OfficeFileError.corrupted
        }
        
        self.xaTableRight = xaTableRight
    }
}
