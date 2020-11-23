//
//  DopMth.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.7.17 DopMth
/// The DopMth structure specifies document-wide math settings.
public struct DopMth {
    public let mthbrk: BinaryOperatorBreak
    public let mthbrkSub: BinarySubtractionBreak
    public let mthbpjc: MathJustification
    public let reserved1: Bool
    public let fMathSmallFrac: Bool
    public let fMathIntLimUndOvr: Bool
    public let fMathNaryLimUndOvr: Bool
    public let fMathWrapAlignLeft: Bool
    public let fMathUseDispDefaults: Bool
    public let reserved2: UInt32
    public let ftcMath: UInt16
    public let dxaLeftMargin: Int32
    public let dxaRightMargin: Int32
    public let empty1: UInt32
    public let empty2: UInt32
    public let empty3: UInt32
    public let empty4: UInt32
    public let dxaIndentWrapped: Int32

    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - mthbrk (2 bits): Specifies how to break on binary operators as specified in [ECMA-376] Part 4, Section 7.1.2.16 brkBin. This MUST be
        /// one of the following values.
        let mthbrkRaw = UInt8(flags.readBits(count: 2))
        guard let mthbrk = BinaryOperatorBreak(rawValue: mthbrkRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.mthbrk = mthbrk
        
        /// B - mthbrkSub (2 bits): Specifies how to break on binary subtraction when mthbrk is 2 as specified in [ECMA-376] Part 4, Section 7.1.2.17
        /// brkBinSub. This value MUST be one of the following.
        let mthbrkSubRaw = UInt8(flags.readBits(count: 2))
        guard let mthbrkSub = BinarySubtractionBreak(rawValue: mthbrkSubRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.mthbrkSub = mthbrkSub
        
        /// C - mthbpjc (3 bits): Specifies the default justification of math as specified in [ECMA-376] Part 4, Section 7.1.2.25 defJc. This MUST be one of the
        /// following values.
        let mthbpjcRaw = UInt8(flags.readBits(count: 3))
        guard let mthbpjc = MathJustification(rawValue: mthbpjcRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.mthbpjc = mthbpjc
        
        /// D - reserved1 (1 bit): This value is undefined and MUST be ignored.
        self.reserved1 = flags.readBit()
        
        /// E - fMathSmallFrac (1 bit): Specifies whether to use a reduced fraction size when displaying math that contains fractions as specified in
        /// [ECMA-376] Part 4, Section 7.1.2.98 smallFrac. By default, this value is 0.
        self.fMathSmallFrac = flags.readBit()
        
        /// F - fMathIntLimUndOvr (1 bit): Specifies that the default placement of integral limits when converting from a linear format is directly above
        /// and below the base as opposed to on the side of the base as specified in [ECMA-376] Part 4, Section 7.1.2.49 intLim. By default, this value is 0.
        self.fMathIntLimUndOvr = flags.readBit()
        
        /// G - fMathNaryLimUndOvr (1 bit): Specifies that the default placement of n-ary limits other than integrals is directly above and below the base,
        /// as opposed to on the side of the base, as specified in [ECMA-376] Part 4, Section 7.1.2.71 naryLim. By default, this value is 0.
        self.fMathNaryLimUndOvr = flags.readBit()
        
        /// H - fMathWrapAlignLeft (1 bit): Specifies the left justification of the wrapped line of an equation as opposed to right justification of the wrapped
        /// line of an equation as specified in [ECMA-376] Part 4, Section 7.1.2.121 wrapRight where the meaning is the opposite of fMathWrapAlignLeft. By
        /// default, this value is 1.
        self.fMathWrapAlignLeft = flags.readBit()
        
        /// I - fMathUseDispDefaults (1 bit): Specifies whether to use display math defaults as specified in [ECMA-376] Part 4, Section 7.1.2.30 dispDef.
        /// By default, this value is 1.
        self.fMathUseDispDefaults = flags.readBit()
        
        /// reserved2 (19 bits): This value MUST be zero, and MUST be ignored.
        self.reserved2 = flags.readRemainingBits()
        
        /// ftcMath (2 bytes): An index into an SttbfFfn structure that specifies the font to use for new equations in the document. The default font is
        /// Cambria Math.
        self.ftcMath = try dataStream.read(endianess: .littleEndian)
        
        /// dxaLeftMargin (4 bytes): A signed integer, in twips, that specifies the left margin for math. MUST be greater than or equal to 0 and less than
        /// or equal to 31680 as specified in [ECMA-376] Part 4, Section 7.1.2.59 lMargin. By default, this value is 0.
        let dxaLeftMargin: Int32 = try dataStream.read(endianess: .littleEndian)
        if dxaLeftMargin < 0 || dxaLeftMargin > 31680 {
            throw OfficeFileError.corrupted
        }
        
        self.dxaLeftMargin = dxaLeftMargin
        
        /// dxaRightMargin (4 bytes): A signed integer in twips that specifies the right margin for math. This value MUST be greater than or equal to 0 and
        /// less than or equal to 31680, as specified in [ECMA376] Part 4, Section 7.1.2.90 rMargin. By default, this value is 0.
        let dxaRightMargin: Int32 = try dataStream.read(endianess: .littleEndian)
        if dxaRightMargin < 0 || dxaRightMargin > 31680 {
            throw OfficeFileError.corrupted
        }
        
        self.dxaRightMargin = dxaRightMargin

        /// empty1 (4 bytes): This value MUST be 120, and MUST be ignored.
        self.empty1 = try dataStream.read(endianess: .littleEndian)
        
        /// empty2 (4 bytes): This value MUST be 120, and MUST be ignored.
        self.empty2 = try dataStream.read(endianess: .littleEndian)
        
        /// empty3 (4 bytes): This value MUST be zero, and MUST be ignored.
        self.empty3 = try dataStream.read(endianess: .littleEndian)
        
        /// empty4 (4 bytes): This value MUST be zero, and MUST be ignored.
        self.empty4 = try dataStream.read(endianess: .littleEndian)
        
        /// dxaIndentWrapped (4 bytes): A signed integer, in twips, that specifies the indentation of the wrapped line of an equation. This value MUST be
        /// greater than or equal to 0 and less than or equal to 31680 as specified in [ECMA-376] Part 4, Section 7.1.2.120 wrapIndent. By default, this
        /// value is 1440.
        let dxaIndentWrapped: Int32 = try dataStream.read(endianess: .littleEndian)
        if dxaIndentWrapped < 0 || dxaIndentWrapped > 31680 {
            throw OfficeFileError.corrupted
        }
        
        self.dxaIndentWrapped = dxaIndentWrapped
    }
    
    /// A - mthbrk (2 bits): Specifies how to break on binary operators as specified in [ECMA-376] Part 4, Section 7.1.2.16 brkBin. This MUST be
    /// one of the following values.
    public enum BinaryOperatorBreak: UInt8 {
        /// 0 (default) Before. In line wrapping, breaks occur on binary operators, so the binary operator appears before the break.
        case before = 0
        
        /// 1 After. In line wrapping, breaks occur on binary operators, so the binary operator appears after the break.
        case after = 1
        
        /// 2 Repeat. In line wrapping, breaks occur on binary operators, so the binary operator appears on both sides of the break.
        case `repeat` = 2
    }
    
    /// B - mthbrkSub (2 bits): Specifies how to break on binary subtraction when mthbrk is 2 as specified in [ECMA-376] Part 4, Section 7.1.2.17
    /// brkBinSub. This value MUST be one of the following.
    public enum BinarySubtractionBreak: UInt8 {
        /// 0 (default) Minus Minus. Repetition of a subtraction sign after a line-wrapping break is minus on the first and second lines.
        case minusMinus = 0
        
        /// 1 Plus Minus. Repetition of a subtraction sign after a line-wrapping break is plus on the first line and minus on the second line.
        case plusMinus = 1
    
        /// 2 Minus Plus. Repetition of a subtraction sign after a line-wrapping break is minus on the first line and plus on the second line.
        case minusPlus = 2
    }
    
    /// C - mthbpjc (3 bits): Specifies the default justification of math as specified in [ECMA-376] Part 4, Section 7.1.2.25 defJc. This MUST be one of the
    /// following values.
    public enum MathJustification: UInt8 {
        /// 1 (default) Centered as Group. Justifies equations with respect to each other and centers the group of equations with respect to the page.
        case centeredAsGroup = 1
        
        /// 2 Center. Centers each equation individually with respect to margins.
        case center = 2
        
        /// 3 Left. Left justification of the paragraph containing only math.
        case left = 3
        
        /// 4 Right. Right justification of the paragraph containing only math.
        case right = 4
    }
}
