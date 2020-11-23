//
//  Copts80.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.7.12 Copts80
/// The Copts80 structure specifies compatibility options.
public struct Copts80 {
    public let copts60: Copts60
    public let fSuppressTopSpacingMac5: Bool
    public let fTruncDxaExpand: Bool
    public let fPrintBodyBeforeHdr: Bool
    public let fNoExtLeading: Bool
    public let fDontMakeSpaceForUL: Bool
    public let fMWSmallCaps: Bool
    public let f2ptExtLeadingOnly: Bool
    public let fTruncFontHeight: Bool
    public let fSubOnSize: Bool
    public let fLineWrapLikeWord6: Bool
    public let fWW6BorderRules: Bool
    public let fExactOnTop: Bool
    public let fExtraAfter: Bool
    public let fWPSpace: Bool
    public let fWPJust: Bool
    public let fPrintMet: Bool
    
    public init(dataStream: inout DataStream) throws {
        /// copts60 (2 bytes): A Copts60 that specifies additional compatibility options.
        self.copts60 = try Copts60(dataStream: &dataStream)
        
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fSuppressTopSpacingMac5 (1 bit): Specifies whether the minimum line height for the first line on the page is ignored as specified in
        /// [ECMA-376] Part 4, Section 2.15.3.48 suppressSpacingAtTopOfPage, where a spacing element with a lineRule attribute value of
        /// atLeast refers to sprmPDyaLine with a LSPD.fMultLinespace of 0 and LSPD.dyaline greater than 0.
        self.fSuppressTopSpacingMac5 = flags.readBit()
        
        /// B - fTruncDxaExpand (1 bit): Specifies whether text is expanded or condensed by whole points as specified in [ECMA-376] Part 4, Section
        /// 2.15.3.44 spacingInWholePoints, where spacing refers to sprmPDyaBefore and sprmPDyaAfter.
        self.fTruncDxaExpand = flags.readBit()
        
        /// C - fPrintBodyBeforeHdr (1 bit): Specifies whether body text is printed before header and footer contents as specified in [ECMA-376] Part 4,
        /// Section 2.15.3.38 printBodyTextBeforeHeader.
        self.fPrintBodyBeforeHdr = flags.readBit()
        
        /// D - fNoExtLeading (1 bit): Specifies whether leading is not added between lines of text as specified in [ECMA-376] Part 4, Section 2.15.3.35
        /// noLeading.
        self.fNoExtLeading = flags.readBit()
        
        /// E - fDontMakeSpaceForUL (1 bit): Specifies whether additional space is not added below the baseline for underlined East Asian characters as
        /// specified in [ECMA-376] Part 4, Section 2.15.3.43 spaceForUL, where u is sprmCKul and textAlignment with val of baseline is sprmPWAlignFont
        /// with a value of 2 and the overall meaning is the opposite of fDontMakeSpaceForUL.
        self.fDontMakeSpaceForUL = flags.readBit()
        
        /// F - fMWSmallCaps (1 bit): Specifies whether Word 5.x for the Macintosh small caps formatting is to be used as specified in [ECMA-376] Part 4,
        /// Section 2.15.3.32 mwSmallCaps.
        self.fMWSmallCaps = flags.readBit()
        
        /// G - f2ptExtLeadingOnly (1 bit): Specifies whether line spacing emulates WordPerfect 5.x line spacing as specified in [ECMA-376] Part 4,
        /// Section 2.15.3.51 suppressTopSpacingWP.
        self.f2ptExtLeadingOnly = flags.readBit()
        
        /// H - fTruncFontHeight (1 bit): Specifies whether font height calculation emulates WordPerfect 6.x font height calculation as specified in
        /// [ECMA-376] Part 4, Section 2.15.3.53 truncateFontHeightsLikeWP6.
        self.fTruncFontHeight = flags.readBit()
        
        /// I - fSubOnSize (1 bit): Specifies whether the priority of font size is increased during font substitution as specified in [ECMA-376] Part 4, Section
        /// 2.15.3.46 subFontBySize.
        self.fSubOnSize = flags.readBit()
        
        /// J - fLineWrapLikeWord6 (1 bit): Specifies whether line wrapping emulates Microsoft® Word 6.0 line wrapping for East Asian characters as
        /// specified in [ECMA-376] Part 4, Section 2.15.3.31 lineWrapLikeWord6.
        self.fLineWrapLikeWord6 = flags.readBit()
        
        /// K - fWW6BorderRules (1 bit): Specifies whether the paragraph borders next to frames are not suppressed as specified in [ECMA-376] Part 4,
        /// Section 2.15.3.19 doNotSuppressParagraphBorders.
        self.fWW6BorderRules = flags.readBit()
        
        /// L - fExactOnTop (1 bit): Specifies whether content on lines with exact line height is not to be centered as specified in [ECMA-376] Part 4,
        /// Section 2.15.3.34 noExtraLineSpacing, where exact line height using the spacing element refers to sprmPDyaLine with LSPD.fMultLinespace of 0
        /// and LSPD.dyaline is less than 0.
        self.fExactOnTop = flags.readBit()
        
        /// M - fExtraAfter (1 bit): Specifies whether the exact line height for the last line on a page is ignored as specified in [ECMA-376] Part 4, Section
        /// 2.15.3.47 suppressBottomSpacing, where exact line height has using the spacing element refers to sprmPDyaLine with LSPD.fMultLinespace of 0
        /// and LSPD.dyaline is less than 0.
        self.fExtraAfter = flags.readBit()
        
        /// N - fWPSpace (1 bit): Specifies whether the width of a space emulates WordPerfect 5.x space width as specified in [ECMA-376] Part 4, Section
        /// 2.15.3.66 wpSpaceWidth.
        self.fWPSpace = flags.readBit()
        
        /// O - fWPJust (1 bit): Specifies whether paragraph justification emulates WordPerfect 6.x paragraph justification as specified in [ECMA-376] Part 4,
        /// Section 2.15.3.65 wpJustification, where the val attribute value of both on the jc element refers to sprmPJc with a value of 3.
        self.fWPJust = flags.readBit()
        
        /// P - fPrintMet (1 bit): Specifies whether printer metrics are used to display documents as specified in [ECMA-376] Part 4, Section 2.15.3.61
        /// usePrinterMetrics.
        self.fPrintMet = flags.readBit()
    }
}
