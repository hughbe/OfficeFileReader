//
//  UFEL.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.332 UFEL
/// The UFEL structure specifies layout information for text in East Asian languages. See also [ECMA-376] part 4, section 2.3.2.8 eastAsianLayout
/// paragraph property.
public struct UFEL {
    public let fTNY: Bool
    public let fWarichu: Bool
    public let fKumimoji: Bool
    public let fRuby: Bool
    public let fLSFitText: Bool
    public let fVRuby: Bool
    public let spare1: UInt8
    public let iWarichuBracket: WarichuBracket
    public let fWarichuNoOpenBracket: Bool
    public let fTNYCompress: Bool
    public let fTNYFetchTxm: Bool
    public let fCellFitText: Bool
    public let spare2: Bool
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fTNY (1 bit): A bit that specifies if the text displays horizontally within vertical text, or vertically within horizontal text. The text is
        /// rendered with a 90-degree rotation to the left from all other contents of the containing line, while keeping the text on the same line
        /// as all other text in the paragraph.
        self.fTNY = flags.readBit()
        
        /// B - fWarichu (1 bit): A bit that specifies that the text displays on a single line by creating two sublines within the regular line, and laying
        /// out this text equally between those sub-lines.
        self.fWarichu = flags.readBit()
        
        /// C - fKumimoji (1 bit): This value MUST be zero and MUST be ignored.
        self.fKumimoji = flags.readBit()
        
        /// D - fRuby (1 bit): This value MUST be zero and MUST be ignored.
        self.fRuby = flags.readBit()
        
        /// E - fLSFitText (1 bit): The value MUST be zero and MUST be ignored.
        self.fLSFitText = flags.readBit()
        
        /// F - fVRuby (1 bit): This value MUST be zero and MUST be ignored.
        self.fVRuby = flags.readBit()
        
        /// G - spare1 (2 bits): This value MUST be ignored.
        self.spare1 = UInt8(flags.readBits(count: 2))
        
        /// H - iWarichuBracket (3 bits): An unsigned integer that specifies whether the two sub-lines within one line are enclosed within a pair
        /// of brackets when displayed, and the type of brackets that are displayed. If fWarichu is equal to 0x0, this value MUST be ignored.
        /// The iWarichuBracket value MUST be one of the following.
        let iWarichuBracketRaw = UInt8(flags.readBits(count: 3))
        guard let iWarichuBracket = WarichuBracket(rawValue: iWarichuBracketRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.iWarichuBracket = iWarichuBracket
        
        /// I - fWarichuNoOpenBracket (1 bit): This value MUST be zero and MUST be ignored.
        self.fWarichuNoOpenBracket = flags.readBit()
        
        /// J - fTNYCompress (1 bit): A bit that specifies whether other Sprm structures were applied that cause the text to be scaled to fit
        /// within the existing line. A value of 0x1 means that other Sprm structures were applied. A value of 0x0 means that they were not.
        self.fTNYCompress = flags.readBit()
        
        /// K - fTNYFetchTxm (1 bit): This value MUST be zero and MUST be ignored.
        self.fTNYFetchTxm = flags.readBit()
        
        /// L - fCellFitText (1 bit): This value MUST be zero and MUST be ignored.
        self.fCellFitText = flags.readBit()
        
        /// M - spare2 (1 bit): This value MUST be ignored.
        self.spare2 = flags.readBit()
    }
    
    /// H - iWarichuBracket (3 bits): An unsigned integer that specifies whether the two sub-lines within one line are enclosed within a pair of
    /// brackets when displayed, and the type of brackets that are displayed. If fWarichu is equal to 0x0, this value MUST be ignored.
    /// The iWarichuBracket value MUST be one of the following.
    public enum WarichuBracket: UInt8 {
        /// 0x0 No brackets
        case noBrackets = 0x0
        
        /// 0x1 Round brackets, "()"
        case roundBrackets = 0x1
        
        /// 0x2 Square brackets, "[]"
        case squareBrackets = 0x2
        
        /// 0x3 Angle brackets, "<>"
        case angleBrackets = 0x3
        
        /// 0x4 Curly brackets, "{}"
        case curlyBrackets = 0x4
    }
}
