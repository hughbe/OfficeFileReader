//
//  DopTypography.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.7.16 DopTypography
/// The DopTypography structure contains East Asian language typography settings.
public struct DopTypography {
    public let fKerningPunct: Bool
    public let iJustification: Compression
    public let iLevelOfKinsoku: LevelOfKinsoku
    public let f2on1: Bool
    public let unused: Bool
    public let iCustomKsu: CustomKsu
    public let fJapaneseUseLevel2: Bool
    public let reserved: UInt8
    public let cchFollowingPunct: Int16
    public let cchLeadingPunct: Int16
    public let rgxchFPunct: [UInt16]
    public let rgxchLPunct: [UInt16]
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fKerningPunct (1 bit): Specifies whether to kern punctuation characters as specified in [ECMA376] Part 4, Section 2.15.1.60
        /// noPunctuationKerning, where the meaning of noPunctuationKerning is the opposite of fKerningPunct.
        self.fKerningPunct = flags.readBit()
        
        /// B - iJustification (2 bits): Specifies the character-level whitespace compression as specified in [ECMA-376] Part 4, Section 2.15.1.18
        /// characterSpacingControl. This value MUST be one of the following.
        let iJustificationRaw = UInt8(flags.readBits(count: 2))
        guard let iJustification = Compression(rawValue: iJustificationRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.iJustification = iJustification
        
        /// C - iLevelOfKinsoku (2 bits): This value MAY<199> specify which set of line breaking rules to use for East Asian characters. This value
        /// MUST be one of the following.
        let iLevelOfKinsokuRaw = UInt8(flags.readBits(count: 2))
        guard let iLevelOfKinsoku = LevelOfKinsoku(rawValue: iLevelOfKinsokuRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.iLevelOfKinsoku = iLevelOfKinsoku
        
        /// D - f2on1 (1 bit): Specifies whether to print two pages per sheet, as specified in [ECMA-376] Part 4, Section 2.15.1.64 printTwoOnOne.
        self.f2on1 = flags.readBit()
        
        /// E - unused (1 bit): This value is undefined and MUST be ignored.
        self.unused = flags.readBit()
        
        /// F - iCustomKsu (3 bits): This value specifies for what language the characters in rgxchFPunct are kinsoku overrides<200>. All other
        /// languages act according to the description of iLevelOfKinsoku with a value of 0. This MUST be one of the following values.
        let iCustomKsuRaw = UInt8(flags.readBits(count: 3))
        guard let iCustomKsu = CustomKsu(rawValue: iCustomKsuRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.iCustomKsu = iCustomKsu
        
        /// G - fJapaneseUseLevel2 (1 bit): This value specifies that line breaking rules for Japanese acts according to the description of iLevelOfKinsoku
        /// with a value of 1<201>. The default value is 0.
        self.fJapaneseUseLevel2 = flags.readBit()
        
        /// reserved (5 bits): This value MUST be zero, and MUST be ignored.
        self.reserved = UInt8(flags.readBits(count: 5))
        
        /// cchFollowingPunct (2 bytes): A signed integer that specifies the number of characters in rgxchFPunct. This MUST be a value between 0x0000
        /// and 0x0064 inclusive. By default, this value is 0x0000.
        let cchFollowingPunct: Int16 = try dataStream.read(endianess: .littleEndian)
        if cchFollowingPunct < 0x0000 || cchFollowingPunct > 0x0064 {
            throw OfficeFileError.corrupted
        }
        
        self.cchFollowingPunct = cchFollowingPunct
        
        /// cchLeadingPunct (2 bytes): A signed integer that specifies the number of characters in rgxchLPunct. This MUST be a value between 0x0000
        /// and 0x0032, inclusive. By default, this value is 0x0000.
        let cchLeadingPunct: Int16 = try dataStream.read(endianess: .littleEndian)
        if cchLeadingPunct < 0x0000 || cchLeadingPunct > 0x0032 {
            throw OfficeFileError.corrupted
        }
        
        self.cchLeadingPunct = cchLeadingPunct
        
        /// rgxchFPunct (202 bytes): An array of cchFollowingPunct Unicode characters that cannot start a line if the language of the text matches the
        /// language specified in iCustomKsu. If iCustomKsu has a value of 0, this array has no effect on the document.
        var rgxchFPunct: [UInt16] = []
        rgxchFPunct.reserveCapacity(101)
        for _ in 0..<101 {
            rgxchFPunct.append(try dataStream.read(endianess: .littleEndian))
        }
        
        self.rgxchFPunct = rgxchFPunct
        
        /// rgxchLPunct (102 bytes): An array of cchLeadingPunct Unicode characters that cannot end a line if the language of the text matches the
        /// language specified in iCustomKsu. If iCustomKsu has a value of 0, this array has no effect on the document.
        var rgxchLPunct: [UInt16] = []
        rgxchLPunct.reserveCapacity(51)
        for _ in 0..<51 {
            rgxchLPunct.append(try dataStream.read(endianess: .littleEndian))
        }
        
        self.rgxchLPunct = rgxchLPunct
    }
    
    /// B - iJustification (2 bits): Specifies the character-level whitespace compression as specified in [ECMA-376] Part 4, Section 2.15.1.18
    /// characterSpacingControl. This value MUST be one of the following.
    public enum Compression: UInt8 {
        /// 0 (default) doNotCompress
        case doNotCompress = 0
        
        /// 1 compressPunctuation
        case compressPunctuation = 1
        
        /// 2 compressPunctuationAndJapaneseKana
        case compressPunctuationAndJapaneseKana = 2
    }
    
    /// C - iLevelOfKinsoku (2 bits): This value MAY<199> specify which set of line breaking rules to use for East Asian characters. This value
    /// MUST be one of the following.
    public enum LevelOfKinsoku: UInt8 {
        /// 0 (default) Chinese (Simplified)
        case `default` = 0
        
        /// 1. Cannot start a line:
        /// !%),.:;>?]}¢¨°·ˇˉ―‖ ’"…‰′″›℃ ∶ 、。〃〉》」』】〕〗〞︶︺︾﹀﹄﹚﹜﹞！＂％＇），．
        /// ：；？］｀｜｝～￠
        /// 2. Cannot end a line:$([{£¥·‘"〈《「『【〔〖〝﹙﹛﹝＄（．［｛￡¥
        /// Chinese (Traditional)
        /// 1. Cannot start a line:
        /// !),.:;?]}¢·–—
        /// ’"•‥…‧ ′╴ 、。〉》」』】〕〞︰︱︳︴︶︸︺︼︾﹀﹂﹄﹏﹐﹑﹒﹔﹕﹖﹗﹚﹜﹞！），．：；
        /// ？］｜｝､
        /// 2. Cannot end a line:
        /// ([{£¥‘"‵ 〈《「『【〔〝︵︷︹︻︽︿﹁﹃﹙﹛﹝（｛
        /// Japanese
        /// 1. Cannot start a line:
        /// !%),.:;?]}¢°’"‰′″℃、。々〉》」』】〕゛゜ゝゞ・ヽヾ！％），．：；？］｝｡ ｣ ､ ･ ﾞ ﾟ ￠
        /// 2. Cannot end a line:
        /// $([\{£¥‘"〈《「『【〔＄（［｛｢ ￡¥
        /// Korean
        /// 1. Cannot start a line:
        /// !%),.:;?]}¢°’"′″℃〉》」』】〕！％），．：；？］｝￠
        /// 2. Cannot end a line:
        /// $([\{£¥‘"〈《「『【〔＄（［｛￡¥￦
        /// 1 Identical to 0 for all but Japanese where the following is used:
        /// Cannot start a line:
        /// !%),.:;?]}¢°’"‰′″℃、。々〉》」』】〕ぁぃぅぇぉっゃゅょゎ゛゜ゝゞァィゥェォッャュョヮヵヶ
        /// ・ーヽヾ！％），．：；？］｝｡ ｣ ､ ･ ｧ ｨ ｩ ｪ ｫ ｬ ｭ ｮ ｯ ｰ ﾞ ﾟ ￠
        /// Cannot end a line:
        /// $([\{£¥‘"〈《「『【〔＄（［｛｢ ￡¥
        case defaultWithJapanese = 1
        
        /// 2 The characters that are forbidden to be used for starting or ending a line are specified by rgxchFPunct and rgxchLPunct.
        case forbiddenCharactersSpecified = 2
    }
    
    /// F - iCustomKsu (3 bits): This value specifies for what language the characters in rgxchFPunct are kinsoku overrides<200>. All other languages act
    /// according to the description of iLevelOfKinsoku with a value of 0. This MUST be one of the following values.
    public enum CustomKsu: UInt8 {
        /// 0 (default) No language
        case noLanguage = 0
        
        /// 1 Japanese
        case japanese = 1
        
        /// 2 Chinese (Simplified)
        case chineseSimplified = 2
        
        /// 3 Korean
        case korean = 3
        
        /// 4 Chinese (Traditional)
        case chineseTraditional = 4
    }
}
