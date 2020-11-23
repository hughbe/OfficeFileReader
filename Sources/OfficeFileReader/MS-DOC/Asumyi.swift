//
//  Asumyi.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.7.14 Asumyi
/// The Asumyi structure specifies AutoSummary state information
public struct Asumyi {
    public let fValid: Bool
    public let fView: Bool
    public let iViewBy: AutoSummaryType
    public let fUpdateProps: Bool
    public let reserved: UInt16
    public let wDlgLevel: UInt16
    public let lHighestLevel: UInt32
    public let lCurrentLevel: UInt32
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fValid (1 bit): Specifies whether the rest of the information in the Asumyi is currently valid.
        self.fValid = flags.readBit()
        
        /// B - fView (1 bit): Specifies whether the AutoSummary view is currently active.
        self.fView = flags.readBit()
        
        /// C - iViewBy (2 bits): Specifies the type of AutoSummary to use. This value MUST be one of the following.
        let iViewByRaw = UInt8(flags.readBits(count: 2))
        guard let iViewBy = AutoSummaryType(rawValue: iViewByRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.iViewBy = iViewBy
        
        /// D - fUpdateProps (1 bit): Specifies whether to update the document summary information to reflect the AutoSummary results after the next
        /// summarization.
        self.fUpdateProps = flags.readBit()
        
        /// reserved (11 bits): This value MUST be zero, and MUST be ignored.
        self.reserved = flags.readRemainingBits()
        
        /// wDlgLevel (2 bytes): Specifies the desired size of the summary. This value SHOULD<198> either be between 0 and 100, expressing the
        /// percentage of the original document size, or be one of the following values.
        self.wDlgLevel = try dataStream.read(endianess: .littleEndian)
        
        /// lHighestLevel (4 bytes): If fValid is set to 1, this value MUST be greater than or equal to the highest value of ASUMY.lLevel.
        self.lHighestLevel = try dataStream.read(endianess: .littleEndian)
        
        /// lCurrentLevel (4 bytes): If fValid is set to 1, this value MUST be equal to the following.
        /// (wDlgLevel x lHighestLevel + 50) / 100
        /// If wDlgLevel is between 0xFFF7 and 0xFFFE, the value to use for wDlgLevel is the equivalent percentage to maintain the meaning of wDlgLevel.
        /// This value is compared to ASUMY.lLevel to see if is to be part of the summary. If ASUMY.lLevel is less than or equal to lCurrentLevel, it is
        /// to be part of the summary.
        self.lCurrentLevel = try dataStream.read(endianess: .littleEndian)
    }
    
    /// C - iViewBy (2 bits): Specifies the type of AutoSummary to use. This value MUST be one of the following.
    public enum AutoSummaryType: UInt8 {
        /// 0 Highlight the text that is to be included in the summary.
        case highlightTextInSummary = 0
        
        /// 1 Hide all text that is not part of the summary
        case hideTextNotInSummary = 1
        
        /// 2 Insert the summary at the top of the document.
        case insertSummaryAtTop = 2
        
        /// 3 Create a new document that contains the summary.
        case createNewDocumentContainingSummary = 3
    }
    
    /// wDlgLevel (2 bytes): Specifies the desired size of the summary. This value SHOULD<198> either be between 0 and 100, expressing the
    /// percentage of the original document size, or be one of the following values.
    public enum DigLevelSpecial: UInt16 {
        /// 0xFFFE 10 sentences.
        case tenSentences = 0xFFFE
        
        /// 0xFFFD 20 sentences.
        case twentySentences = 0xFFFD
        
        /// 0xFFFC 100 words.
        case oneHundredWords = 0xFFFC
        
        /// 0xFFFB 500 words.
        case fiveHundredWords = 0xFFFB
        
        /// 0xFFFA 10 percent of the original document size.
        case tenPercentOfOriginalDocumentSize = 0xFFFA
        
        /// 0xFFF9 25 percent of the original document size.
        case twentyFivePercentOfOriginalDocumentSize = 0xFFF9
        
        /// 0xFFF8 50 percent of the original document size.
        case fiftyPercentOfOriginalDocumentSize = 0xFFF8
        
        /// 0xFFF7 75 percent of the original document size.
        case seventyFivePercentOfOriginalDocumentSize = 0xFFF7
    }
}
