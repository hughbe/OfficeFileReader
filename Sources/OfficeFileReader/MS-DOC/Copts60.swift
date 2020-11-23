//
//  Copts60.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.7.11 Copts60
/// The Copts60 structure specifies compatibility options.
public struct Copts60 {
    public let fNoTabForInd: Bool
    public let fNoSpaceRaiseLower: Bool
    public let fSuppressSpBfAfterPgBrk: Bool
    public let fWrapTrailSpaces: Bool
    public let fMapPrintTextColor: Bool
    public let fNoColumnBalance: Bool
    public let fConvMailMergeEsc: Bool
    public let fSuppressTopSpacing: Bool
    public let fOrigWordTableRules: Bool
    public let unused14: Bool
    public let fShowBreaksInFrames: Bool
    public let fSwapBordersFacingPgs: Bool
    public let fLeaveBackslashAlone: Bool
    public let fExpShRtn: Bool
    public let fDntULTrlSpc: Bool
    public let fDntBlnSbDbWid: Bool
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)

        /// A - fNoTabForInd (1 bit): Specified in [ECMA-376] Part 4, Section 2.15.3.37 noTabHangInd.
        self.fNoTabForInd = flags.readBit()
        
        /// B - fNoSpaceRaiseLower (1 bit): Specified in [ECMA-376] Part 4, Section 2.15.3.36 noSpaceRaiseLower.
        self.fNoSpaceRaiseLower = flags.readBit()
        
        /// C - fSuppressSpBfAfterPgBrk (1 bit): Specified in [ECMA-376] Part 4, Section 2.15.3.49 suppressSpBfAfterPgBrk.
        self.fSuppressSpBfAfterPgBrk = flags.readBit()
        
        /// D - fWrapTrailSpaces (1 bit): Specified in [ECMA-376] Part 4, Section 2.15.3.67 wrapTrailSpaces.
        self.fWrapTrailSpaces = flags.readBit()
        
        /// E - fMapPrintTextColor (1 bit): Specified in [ECMA-376] Part 4, Section 2.15.3.39 printColBlack.
        self.fMapPrintTextColor = flags.readBit()
        
        /// F - fNoColumnBalance (1 bit): Specified in [ECMA-376] Part 4, Section 2.15.3.33 noColumnBalance.
        self.fNoColumnBalance = flags.readBit()
        
        /// G - fConvMailMergeEsc (1 bit): Specified in [ECMA-376] Part 4, Section 2.15.3.10 convMailMergeEsc.
        self.fConvMailMergeEsc = flags.readBit()
        
        /// H - fSuppressTopSpacing (1 bit): Specified in [ECMA-376] Part 4, Section 2.15.3.50 suppressTopSpacing.
        self.fSuppressTopSpacing = flags.readBit()
        
        /// I - fOrigWordTableRules (1 bit): Specified in [ECMA-376] Part 4, Section 2.15.3.62 useSingleBorderforContiguousCells.
        self.fOrigWordTableRules = flags.readBit()
        
        /// J - unused14 (1 bit): This value is undefined and MUST be ignored.
        self.unused14 = flags.readBit()
        
        /// K - fShowBreaksInFrames (1 bit): Specified in [ECMA-376] Part 4, Section 2.15.3.42 showBreaksInFrames.
        self.fShowBreaksInFrames = flags.readBit()
        
        /// L - fSwapBordersFacingPgs (1 bit): Specified in [ECMA-376] Part 4, Section 2.15.3.52 swapBordersFacingPages.
        self.fSwapBordersFacingPgs = flags.readBit()
        
        /// M - fLeaveBackslashAlone (1 bit): Specified in [ECMA-376] Part 4, Section 2.15.3.16 doNotLeaveBackslashAlone, where the meaning
        /// of the element is the opposite of fLeaveBackslashAlone.
        self.fLeaveBackslashAlone = flags.readBit()
        
        /// N - fExpShRtn (1 bit): Specified in [ECMA-376] Part 4, Section 2.15.3.15 doNotExpandShiftReturn, where the meaning is the opposite of
        /// fExpShRtn.
        self.fExpShRtn = flags.readBit()
        
        /// O - fDntULTrlSpc (1 bit): Specified in [ECMA-376] Part 4, Section 2.15.3.55 ulTrailSpace, where the meaning of the element is the opposite
        /// of fDntULTrlSpc.
        self.fDntULTrlSpc = flags.readBit()
        
        /// P - fDntBlnSbDbWid (1 bit): Specified in [ECMA-376] Part 4, Section 2.15.3.7 balanceSingleByteDoubleByteWidth, where the meaning of
        /// the element is the opposite of fDntBlnSbDbWid.
        self.fDntBlnSbDbWid = flags.readBit()
    }
}
