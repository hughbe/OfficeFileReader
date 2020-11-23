//
//  TextRuler.swift
//  
//
//  Created by Hugh Bellamy on 13/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.30 TextRuler
/// Referenced by: DefaultRulerAtom, TextRulerAtom
/// A structure that specifies tabbing, margins, and indentation for text.
public struct TextRuler {
    public let fDefaultTabSize: Bool
    public let fCLevels: Bool
    public let fTabStops: Bool
    public let fLeftMargin1: Bool
    public let fLeftMargin2: Bool
    public let fLeftMargin3: Bool
    public let fLeftMargin4: Bool
    public let fLeftMargin5: Bool
    public let fIndent1: Bool
    public let fIndent2: Bool
    public let fIndent3: Bool
    public let fIndent4: Bool
    public let fIndent5: Bool
    public let reserved: UInt32
    public let cLevels: UInt16?
    public let defaultTabSize: TabSize?
    public let tabs: TabStops?
    public let leftMargin1: MarginOrIndent?
    public let indent1: MarginOrIndent?
    public let leftMargin2: MarginOrIndent?
    public let indent2: MarginOrIndent?
    public let leftMargin3: MarginOrIndent?
    public let indent3: MarginOrIndent?
    public let leftMargin4: MarginOrIndent?
    public let indent5: MarginOrIndent?
    public let leftMargin5: MarginOrIndent?
    public let indent4: MarginOrIndent?
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fDefaultTabSize (1 bit): A bit that specifies whether defaultTabSize exists.
        self.fDefaultTabSize = flags.readBit()
        
        /// B - fCLevels (1 bit): A bit that specifies whether cLevels exists.
        self.fCLevels = flags.readBit()
        
        /// C - fTabStops (1 bit): A bit that specifies whether tabs exists.
        self.fTabStops = flags.readBit()
        
        /// D - fLeftMargin1 (1 bit): A bit that specifies whether leftMargin1 exists.
        self.fLeftMargin1 = flags.readBit()
        
        /// E - fLeftMargin2 (1 bit): A bit that specifies whether leftMargin2 exists.
        self.fLeftMargin2 = flags.readBit()
        
        /// F - fLeftMargin3 (1 bit): A bit that specifies whether leftMargin3 exists.
        self.fLeftMargin3 = flags.readBit()
        
        /// G - fLeftMargin4 (1 bit): A bit that specifies whether leftMargin4 exists.
        self.fLeftMargin4 = flags.readBit()
        
        /// H - fLeftMargin5 (1 bit): A bit that specifies whether leftMargin5 exists.
        self.fLeftMargin5 = flags.readBit()
        
        /// I - fIndent1 (1 bit): A bit that specifies whether indent1 exists.
        self.fIndent1 = flags.readBit()
        
        /// J - fIndent2 (1 bit): A bit that specifies whether indent2 exists.
        self.fIndent2 = flags.readBit()
        
        /// K - fIndent3 (1 bit): A bit that specifies whether indent3 exists.
        self.fIndent3 = flags.readBit()
        
        /// L - fIndent4 (1 bit): A bit that specifies whether indent4 exists.
        self.fIndent4 = flags.readBit()
        
        /// M - fIndent5 (1 bit): A bit that specifies whether indent5 exists.
        self.fIndent5 = flags.readBit()
        
        /// reserved (19 bits): MUST be zero and MUST be ignored.
        self.reserved = flags.readRemainingBits()
        
        /// cLevels (2 bytes): An optional signed integer that specifies the number of style levels in this text ruler. It MUST exist if and only if fCLevels is
        /// TRUE.
        if self.fCLevels {
            self.cLevels = try dataStream.read(endianess: .littleEndian)
        } else {
            self.cLevels = nil
        }
        
        /// defaultTabSize (2 bytes): An optional TabSize that specifies the default tab size for this text ruler. It MUST exist if and only if fDefaultTabSize is
        /// TRUE.
        if self.fDefaultTabSize {
            self.defaultTabSize = try dataStream.read(endianess: .littleEndian)
        } else {
            self.defaultTabSize = nil
        }
        
        /// tabs (variable): An optional TabStops structure that specifies the tab stops for this text ruler. It MUST exist if and only if fTabStops is TRUE.
        if self.fTabStops {
            self.tabs = try TabStops(dataStream: &dataStream)
        } else {
            self.tabs = nil
        }
        
        /// leftMargin1 (2 bytes): An optional MarginOrIndent that specifies the left margin for text that has an IndentLevel equal to 0x0000. It MUST exist
        /// if and only if fLeftMargin1 is TRUE.
        if self.fLeftMargin1 {
            self.leftMargin1 = try dataStream.read(endianess: .littleEndian)
        } else {
            self.leftMargin1 = nil
        }
        
        /// indent1 (2 bytes): An optional MarginOrIndent that specifies the indentation for text that has an IndentLevel equal to 0x0000. It MUST exist if
        /// and only if fIndent1 is TRUE.
        if self.fIndent1 {
            self.indent1 = try dataStream.read(endianess: .littleEndian)
        } else {
            self.indent1 = nil
        }
        
        /// leftMargin2 (2 bytes): An optional MarginOrIndent that specifies the left margin for text that has an IndentLevel equal to 0x0001. It MUST exist
        /// if and only if fLeftMargin2 is TRUE.
        if self.fLeftMargin2 {
            self.leftMargin2 = try dataStream.read(endianess: .littleEndian)
        } else {
            self.leftMargin2 = nil
        }
        
        /// indent2 (2 bytes): An optional MarginOrIndent that specifies the indentation for text that has an IndentLevel equal to 0x0001. It MUST exist if
        /// and only if fIndent2 is TRUE.
        if self.fIndent2 {
            self.indent2 = try dataStream.read(endianess: .littleEndian)
        } else {
            self.indent2 = nil
        }
        
        /// leftMargin3 (2 bytes): An optional MarginOrIndent that specifies the left margin for text that has an IndentLevel equal to 0x0002. It MUST exist
        /// if and only if fLeftMargin3 is TRUE.
        if self.fLeftMargin3 {
            self.leftMargin3 = try dataStream.read(endianess: .littleEndian)
        } else {
            self.leftMargin3 = nil
        }
        
        /// indent3 (2 bytes): An optional MarginOrIndent that specifies the indentation for text that has an IndentLevel equal to 0x0002. It MUST exist if
        /// and only if fIndent3 is TRUE.
        if self.fIndent3 {
            self.indent3 = try dataStream.read(endianess: .littleEndian)
        } else {
            self.indent3 = nil
        }
        
        /// leftMargin4 (2 bytes): An optional MarginOrIndent that specifies the left margin for text that has an IndentLevel equal to 0x0003. It MUST exist if
        /// and only if fLeftMargin4 is TRUE.
        if self.fLeftMargin4 {
            self.leftMargin4 = try dataStream.read(endianess: .littleEndian)
        } else {
            self.leftMargin4 = nil
        }
        
        /// indent4 (2 bytes): An optional MarginOrIndent that specifies the indentation for text that has an IndentLevel equal to 0x0003. It MUST exist if and
        /// only if fIndent4 is TRUE.
        if self.fIndent4 {
            self.indent4 = try dataStream.read(endianess: .littleEndian)
        } else {
            self.indent4 = nil
        }
        
        /// leftMargin5 (2 bytes): An optional MarginOrIndent that specifies the left margin for text that has an IndentLevel equal to 0x0004. It MUST exist if
        /// and only if fLeftMargin5 is TRUE.
        if self.fLeftMargin5 {
            self.leftMargin5 = try dataStream.read(endianess: .littleEndian)
        } else {
            self.leftMargin5 = nil
        }
        
        /// indent5 (2 bytes): An optional MarginOrIndent that specifies the indentation for text that has an IndentLevel equal to 0x0004. It MUST exist if
        /// and only if fIndent5 is TRUE.
        if self.fIndent5 {
            self.indent5 = try dataStream.read(endianess: .littleEndian)
        } else {
            self.indent5 = nil
        }
    }
}
