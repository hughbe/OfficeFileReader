//
//  PresAdvisorFlags9Atom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.6 PresAdvisorFlags9Atom
/// Referenced by: PP9DocBinaryTagExtension
/// An atom record that specifies which rules to ignore when warning the user about aspects of the document that do not conform to a particular style.
public struct PresAdvisorFlags9Atom {
    public let rh: RecordHeader
    public let fDisableCaseStyleTitleRule: Bool
    public let fDisableCaseStyleBodyRule: Bool
    public let fDisableEndPunctuationTitleRule: Bool
    public let fDisableEndPunctuationBodyRule: Bool
    public let fDisableTooManyBulletsRule: Bool
    public let fDisableFontSizeTitleRule: Bool
    public let fDisableFontSizeBodyRule: Bool
    public let fDisableNumberOfLinesTitleRule: Bool
    public let fDisableNumberOfLinesBodyRule: Bool
    public let fDisableTooManyFontsRule: Bool
    public let fDisablePrintTip: Bool
    public let reserved: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_PresentationAdvisorFlags9Atom (section 2.13.24).
        /// rh.recLen MUST be 0x00000004.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .presentationAdvisorFlags9Atom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000004 else {
            throw OfficeFileError.corrupted
        }

        let startPosition = dataStream.position
        
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A fDisableCaseStyleTitleRule (1 bit): A bit that specifies not to warn the user when the letter casing of text in a title placeholder shape does not follow a certain rule.
        self.fDisableCaseStyleTitleRule = flags.readBit()

        /// B fDisableCaseStyleBodyRule (1 bit): A bit that specifies not to warn the user when the letter casing of text in a body placeholder shape does not follow a certain rule.
        self.fDisableCaseStyleBodyRule = flags.readBit()

        /// C fDisableEndPunctuationTitleRule (1 bit): A bit that specifies not to warn the user when the ending punctuation of text in a title placeholder shape does not follow a certain rule.
        self.fDisableEndPunctuationTitleRule = flags.readBit()

        /// D fDisableEndPunctuationBodyRule (1 bit): A bit that specifies not to warn the user when the ending punctuation of text in a body placeholder shape does not follow a certain rule.
        self.fDisableEndPunctuationBodyRule = flags.readBit()

        /// E fDisableTooManyBulletsRule (1 bit): A bit that specifies not to warn the user when too many bullets are used.
        self.fDisableTooManyBulletsRule = flags.readBit()

        /// F fDisableFontSizeTitleRule (1 bit): A bit that specifies not to warn the user when the font size in a title placeholder shape exceeds a certain size.
        self.fDisableFontSizeTitleRule = flags.readBit()

        /// G fDisableFontSizeBodyRule (1 bit): A bit that specifies not to warn the user when the font size in a body placeholder shape exceeds a certain size.
        self.fDisableFontSizeBodyRule = flags.readBit()

        /// H fDisableNumberOfLinesTitleRule (1 bit): A bit that specifies not to warn the user when the number of lines of text in a title placeholder shape exceeds a certain quantity.
        self.fDisableNumberOfLinesTitleRule = flags.readBit()

        /// I fDisableNumberOfLinesBodyRule (1 bit): A bit that specifies not to warn the user when the number of lines of a paragraph in a body placeholder shape exceeds a certain quantity.
        self.fDisableNumberOfLinesBodyRule = flags.readBit()

        /// J fDisableTooManyFontsRule (1 bit): A bit that specifies not to warn the user when the number of different fonts used exceeds a certain quantity.
        self.fDisableTooManyFontsRule = flags.readBit()

        /// K fDisablePrintTip (1 bit): A bit that specifies not to advise the user about printing when they first print the document.
        self.fDisablePrintTip = flags.readBit()

        /// reserved (21 bits): MUST be zero and MUST be ignored.
        self.reserved = flags.readRemainingBits()
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
