//
//  Copts.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.7.13 Copts
/// A structure that specifies compatibility options.
public struct Copts {
    public let copts80: Copts80
    public let fSpLayoutLikeWW8: Bool
    public let fFtnLayoutLikeWW8: Bool
    public let fDontUseHTMLParagraphAutoSpacing: Bool
    public let fDontAdjustLineHeightInTable: Bool
    public let fForgetLastTabAlign: Bool
    public let fUseAutospaceForFullWidthAlpha: Bool
    public let fAlignTablesRowByRow: Bool
    public let fLayoutRawTableWidth: Bool
    public let fLayoutTableRowsApart: Bool
    public let fUseWord97LineBreakingRules: Bool
    public let fDontBreakWrappedTables: Bool
    public let fDontSnapToGridInCell: Bool
    public let fDontAllowFieldEndSelect: Bool
    public let fApplyBreakingRules: Bool
    public let fDontWrapTextWithPunct: Bool
    public let fDontUseAsianBreakRules: Bool
    public let fUseWord2002TableStyleRules: Bool
    public let fGrowAutoFit: Bool
    public let fUseNormalStyleForList: Bool
    public let fDontUseIndentAsNumberingTabStop: Bool
    public let fFELineBreak11: Bool
    public let fAllowSpaceOfSameStyleInTable: Bool
    public let fWW11IndentRules: Bool
    public let fDontAutofitConstrainedTables: Bool
    public let fAutofitLikeWW11: Bool
    public let fUnderlineTabInNumList: Bool
    public let fHangulWidthLikeWW11: Bool
    public let fSplitPgBreakAndParaMark: Bool
    public let fDontVertAlignCellWithSp: Bool
    public let fDontBreakConstrainedForcedTables: Bool
    public let fDontVertAlignInTxbx: Bool
    public let fWord11KerningPairs: Bool
    public let fCachedColBalance: Bool
    public let empty1: UInt32
    public let empty2: UInt32
    public let empty3: UInt32
    public let empty4: UInt32
    public let empty5: UInt32
    public let empty6: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// copts80 (4 bytes): A Copts80 that specifies additional compatibility options.
        self.copts80 = try Copts80(dataStream: &dataStream)
        
        var flags1: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)

        /// A - fSpLayoutLikeWW8 (1 bit): Specifies whether to emulate Word 97 text wrapping around floating objects. Specified in [ECMA-376] part 4,
        /// 2.15.3.41 (shapeLayoutLikeWW8).
        self.fSpLayoutLikeWW8 = flags1.readBit()
        
        /// B - fFtnLayoutLikeWW8 (1 bit): Specifies whether to emulate Microsoft® Word 6.0, Word for Windows 95, or Word 97 footnote placement.
        /// Specified in [ECMA-376] Part 4, 2.15.3.26 (footnoteLayoutLikeWW8).
        self.fFtnLayoutLikeWW8 = flags1.readBit()
        
        /// C - fDontUseHTMLParagraphAutoSpacing (1 bit): Specifies whether to use fixed paragraph spacing for paragraphs specifying auto spacing.
        /// Specified in [ECMA-376] Part 4, 2.15.3.21 (doNotUseHTMLParagraphAutoSpacing).
        self.fDontUseHTMLParagraphAutoSpacing = flags1.readBit()
        
        /// D - fDontAdjustLineHeightInTable (1 bit): Prevents lines within tables from having their heights adjusted to comply with the document grid.
        /// See sprmSDyaLinePitch and [ECMA-376] Part 4, 2.15.3.1 (adjustLineHeightInTable) where the meaning is the opposite of
        /// fDontAdjustLineHeightInTable.
        self.fDontAdjustLineHeightInTable = flags1.readBit()
        
        /// E - fForgetLastTabAlign (1 bit): Specifies whether to ignore width of the last tab stop when aligning a paragraph if the tab stop is not left aligned.
        /// Specified in [ECMA-376] Part 4, 2.15.3.27 (forgetLastTabAlignment) where jc refers to sprmPJc and the tab element refers to either
        /// sprmPChgTabs or sprmPChgTabsPapx.
        self.fForgetLastTabAlign = flags1.readBit()
        
        /// F - fUseAutospaceForFullWidthAlpha (1 bit): Specifies whether to emulate Word for Windows 95 full-width character spacing. Specified in
        /// [ECMA-376] Part 4, 2.15.3.6 (autoSpaceLikeWord for Windows 95).
        self.fUseAutospaceForFullWidthAlpha = flags1.readBit()
        
        /// G - fAlignTablesRowByRow (1 bit): Specifies whether to align table rows independently. Specified in [ECMA-376] Part 4, 2.15.3.2 (
        /// alignTablesRowByRow) where the jc element refers to sprmTJc or sprmTJc90.
        self.fAlignTablesRowByRow = flags1.readBit()
        
        /// H - fLayoutRawTableWidth (1 bit): Specifies whether to ignore space before tables when deciding if a table wraps a floating object. Specified
        /// in [ECMA-376] Part 4, 2.15.3.29 (layoutRawTableWidth).
        self.fLayoutRawTableWidth = flags1.readBit()
        
        /// I - fLayoutTableRowsApart (1 bit): Specifies whether to allow table rows to wrap inline objects independently. Specified in [ECMA-376] Part 4,
        /// 2.15.3.30 (layoutTableRowsApart).
        self.fLayoutTableRowsApart = flags1.readBit()
        
        /// J - fUseWord97LineBreakingRules (1 bit): Specifies whether to emulate Word 97 East Asian line breaking rules. Specified in [ECMA-376] Part 4,
        /// 2.15.3.64 (useWord97LineBreakRules).
        self.fUseWord97LineBreakingRules = flags1.readBit()
        
        /// K - fDontBreakWrappedTables (1 bit): Specifies whether to prevent floating tables from breaking across pages. Specified in [ECMA-376] Part 4,
        /// 2.15.3.14 (doNotBreakWrappedTables) where the tblpPr element refers to any of sprmTDxaAbs, sprmTDyaAbs, sprmTPc,
        /// sprmTDyaFromTextBottom, sprmTDyaFromText, sprmTDxaFromTextRight, or sprmTDxaFromText with a nondefault value specified.
        self.fDontBreakWrappedTables = flags1.readBit()
        
        /// L - fDontSnapToGridInCell (1 bit): Specifies whether to not snap to the document grid in table cells with objects. Specified in [ECMA-376] Part 4,
        /// 2.15.3.17 (doNotSnapToGridInCell) where the docGrid element refers to any of sprmSClm, sprmSDyaLinePitch or sprmSDxtCharSpace with a
        /// nondefault value specified.
        self.fDontSnapToGridInCell = flags1.readBit()
        
        /// M - fDontAllowFieldEndSelect (1 bit): Specifies whether to select an entire field when the first or last character of the field is selected.
        /// Specified in [ECMA-376] Part 4, 2.15.3.40 (selectFldWithFirstOrLastChar).
        self.fDontAllowFieldEndSelect = flags1.readBit()
        
        /// N - fApplyBreakingRules (1 bit): Specifies whether to use legacy Ethiopic and Amharic line breaking rules. Specified in [ECMA-376] Part 4,
        /// 2.15.3.4 (applyBreakingRules).
        self.fApplyBreakingRules = flags1.readBit()
        
        /// O - fDontWrapTextWithPunct (1 bit): Specifies whether to prevent hanging punctuation with the character grid. Specified in [ECMA-376] Part 4,
        /// 2.15.3.25 (doNotWrapTextWithPunct) where the docGrid element refers to any of sprmSClm, sprmSDyaLinePitch or sprmSDxtCharSpace with a
        /// nondefault value specified and the overflowPunct element refers to sprmPFOverflowPunct.
        self.fDontWrapTextWithPunct = flags1.readBit()
        
        /// P - fDontUseAsianBreakRules (1 bit): Specifies whether to disallow the compressing of compressible characters when using the document grid.
        /// Specified in [ECMA-376] Part 4, 2.15.3.20 (doNotUseEastAsianBreakRules) where the docGrid element refers to any of sprmSClm,
        /// sprmSDyaLinePitch, or sprmSDxtCharSpace with a nondefault value specified.
        self.fDontUseAsianBreakRules = flags1.readBit()
        
        /// Q - fUseWord2002TableStyleRules (1 bit): Specifies whether to emulate Microsoft Word 2002 table style rules. Specified in [ECMA-376] Part 4,
        /// 2.15.3.63 (useWord2002TableStyleRules).
        self.fUseWord2002TableStyleRules = flags1.readBit()
        
        /// R - fGrowAutoFit (1 bit): Specifies whether to allow tables to autofit into the page margins. Specified in [ECMA-376] Part 4, 2.15.3.28 (growAutofit).
        self.fGrowAutoFit = flags1.readBit()
        
        /// S - fUseNormalStyleForList (1 bit): Specifies whether to not automatically apply the list paragraph style to bulleted or numbered text. Specified in
        /// [ECMA-376] Part 4, 2.15.3.60 (useNormalStyleForList). MAY<183> be ignored.
        self.fUseNormalStyleForList = flags1.readBit()
        
        /// T - fDontUseIndentAsNumberingTabStop (1 bit): Specifies whether to ignore the hanging indent when creating a tab stop after numbering.
        /// Specified in [ECMA-376] Part 4, 2.15.3.22 (doNotUseIndentAsNumberingTabStop). MAY<184> be ignored.
        self.fDontUseIndentAsNumberingTabStop = flags1.readBit()
        
        /// U - fFELineBreak11 (1 bit): Specifies whether to use an alternate set of East Asian line breaking rules. Specified in [ECMA-376] Part 4,
        /// 2.15.3.57 (useAltKinsokuLineBreakRules). MAY<185> be ignored.
        self.fFELineBreak11 = flags1.readBit()
        
        /// V - fAllowSpaceOfSameStyleInTable (1 bit): Specifies whether to allow contextual spacing of paragraphs in tables. Specified in [ECMA-376]
        /// Part 4, 2.15.3.3 (allowSpaceOfSameStyleInTable) where the contextualSpacing element refers to sprmPFContextualSpacing. MAY<186> be
        /// ignored.
        self.fAllowSpaceOfSameStyleInTable = flags1.readBit()
        
        /// W - fWW11IndentRules (1 bit): Specifies whether to not ignore floating objects when calculating paragraph indentation. Specified in [ECMA-376]
        /// Part 4, 2.15.3.18 (doNotSuppressIndentation). MAY<187> be ignored.
        self.fWW11IndentRules = flags1.readBit()
        
        /// X - fDontAutofitConstrainedTables (1 bit): Specifies whether to not autofit tables such that they fit next to wrapped objects. Specified in
        /// [ECMA-376] Part 4, 2.15.3.12 (doNotAutofitConstrainedTables). MAY<188> be ignored.
        self.fDontAutofitConstrainedTables = flags1.readBit()
        
        /// Y - fAutofitLikeWW11 (1 bit): Specifies whether to allow table columns to exceed the preferred widths of the constituent cells. Specified in
        /// [ECMA-376] Part 4, 2.15.3.5 (autofitToFirstFixedWidthCell). MAY<189> be ignored.
        self.fAutofitLikeWW11 = flags1.readBit()
        
        /// Z - fUnderlineTabInNumList (1 bit): Specifies whether to underline the tab following numbering when both the numbering and the first character
        /// of the numbered paragraph are underlined. Specified in [ECMA-376] Part 4, 2.15.3.56 (underlineTabInNumList). MAY<190> be ignored.
        self.fUnderlineTabInNumList = flags1.readBit()
        
        /// a - fHangulWidthLikeWW11 (1 bit): Specifies whether to use fixed width for Hangul characters. Specified in [ECMA-376] Part 4, 2.15.3.11
        /// (displayHangulFixedWidth). MAY<191> be ignored.
        self.fHangulWidthLikeWW11 = flags1.readBit()
        
        /// b - fSplitPgBreakAndParaMark (1 bit): Specifies whether to move paragraph marks to the page after a page break. Specified in [ECMA-376]
        /// Part 4, 2.15.3.45 (splitPgBreakAndParaMark). MAY<192> be ignored.
        self.fSplitPgBreakAndParaMark = flags1.readBit()
        
        /// c - fDontVertAlignCellWithSp (1 bit): Specifies whether to not vertically align cells containing floating objects. Specified in [ECMA-376] Part 4,
        /// 2.15.3.23 (doNotVertAlignCellWithSp). MAY<193> be ignored.
        self.fDontVertAlignCellWithSp = flags1.readBit()
        
        /// d - fDontBreakConstrainedForcedTables (1 bit): Specifies whether to not break table rows around floating tables. Specified in [ECMA-376]
        /// Part 4, 2.15.3.13 (doNotBreakConstrainedForcedTable) where cantSplit element refers to either sprmTFCantSplit or sprmTFCantSplit90 and
        /// tblpPr element refers to any of sprmTDxaAbs, sprmTDyaAbs, sprmTPc, sprmTDyaFromTextBottom, sprmTDyaFromText,
        /// sprmTDxaFromTextRight, or sprmTDxaFromText with a nondefault value specified. MAY<194> be ignored.
        self.fDontBreakConstrainedForcedTables = flags1.readBit()
        
        /// e - fDontVertAlignInTxbx (1 bit): Specifies whether to ignore vertical alignment in text boxes. Specified in [ECMA-376] Part 4, 2.15.3.24
        /// (doNotVertAlignInTxbx). MAY<195> be ignored.
        self.fDontVertAlignInTxbx = flags1.readBit()
        
        /// f - fWord11KerningPairs (1 bit): Specifies whether to use ANSI kerning pairs from fonts instead of the Unicode kerning pair info. Specified in
        /// [ECMA-376] Part 4, 2.15.3.58 (useAnsiKerningPairs). MAY<196> be ignored.
        self.fWord11KerningPairs = flags1.readBit()
        
        var flags2: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// g - fCachedColBalance (1 bit): Specifies whether to use cached paragraph information for column balancing. Specified in [ECMA-376] Part 4,
        /// 2.15.3.8 (cachedColBalance). MAY<197> be ignored.
        self.fCachedColBalance = flags2.readBit()
        
        /// empty1 (31 bits): Undefined, and MUST be ignored.
        self.empty1 = flags2.readRemainingBits()
        
        /// empty2 (4 bytes): Undefined, and MUST be ignored.
        self.empty2 = try dataStream.read(endianess: .littleEndian)

        /// empty3 (4 bytes): Undefined, and MUST be ignored.
        self.empty3 = try dataStream.read(endianess: .littleEndian)
        
        /// empty4 (4 bytes): Undefined, and MUST be ignored.
        self.empty4 = try dataStream.read(endianess: .littleEndian)
        
        /// empty5 (4 bytes): Undefined, and MUST be ignored.
        self.empty5 = try dataStream.read(endianess: .littleEndian)
        
        /// empty6 (4 bytes): Undefined, and MUST be ignored.
        self.empty6 = try dataStream.read(endianess: .littleEndian)
    }
}
