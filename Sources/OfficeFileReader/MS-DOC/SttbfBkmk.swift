//
//  SttbfBkmk.swift
//
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.279 SttbfBkmk
/// The SttbfBkmk structure is an STTB structure whose strings specify the names of bookmarks in the document. The cData field size of this STTB structure
/// is 2 bytes. The strings of this STTB contain extended (2-byte) characters, and there is no extra data appended to them—in other words, it is equivalent
/// to an SttbfBkmkBPRepairs structure. The names in this table that begin with the Unicode character 0x005F correspond to hidden bookmarks. The strings
/// in this table MUST be greater than 0 and less than 40 characters in length. The strings in this table MUST be unique, and there MUST NOT be more than
/// 0x3FFB of them.
public struct SttbfBkmk {
    public let sttb: STTB<String>
    
    public init(dataStream: inout DataStream) throws {
        /// The SttbfBkmk structure is an STTB structure with the following additional restrictions on its field values:
        /// fExtend (2 bytes): MUST be 0xFFFF.
        /// cData (2 bytes): MUST NOT exceed 0x3FFC.
        /// cbExtra (2 bytes): MUST be 0.
        /// cchData (2 bytes): MUST NOT exceed 40.
        /// Data (variable): For the purpose of achieving the correct definition of "skip character", the following constraints MUST be evaluated using delayed
        /// evaluation and examination of characters in a string MUST take place in first-to-last order. Delayed evaluation requires that each constraint not be
        /// read until the result of that constraint is needed. For example, application of the following algorithm to the string "Abc" will never require reading
        /// of the constraints defining a single byte Katakana character.
        /// To be a valid member of SttbfBkmk, all characters in the string that are not preceded by a skip character SHOULD<244> meet all of the following
        /// constraints:
        ///  Is the first character of the name and satisfies all of the following constraints:
        ///  Is not Unicode character 0x3000.
        ///  Is not a double-byte digit, meaning that it is between 0xFF10 and 0xFF19, inclusive.
        ///  Is one of the following:
        ///  An alpha character, as defined later.
        ///  The hidden bookmark character, 0x005F.
        ///  A single-byte Katakana character, meaning that it is between 0xFF61 and 0xFF9F, inclusive.
        ///  A far-east, double-byte text character as defined later.
        ///  Is not the first character of the name and satisfies all of the following constraints:
        ///  Is not Unicode character 0x3000.
        ///  Is one of the following:
        ///  An East Asian, double-byte text character as defined later.
        ///  An alpha character as defined later.
        ///  A digit character as defined later.
        ///  The hidden bookmark character, 0x005F.
        ///  A single-byte Katakana character, meaning it is between 0xFF61 and 0xFF9F, inclusive.
        /// A digit character is defined as that which satisfies both of the following constraints:
        ///  Is not 0xFFFF.
        ///  Satisfies one of the following constraints:
        ///  Is between 0x0030 and 0x0039, inclusive.
        ///  Is between 0xFF10 and 0xFF19, inclusive.
        ///  Is between 0x0E50 and 0x0E59, inclusive.
        ///  Is between 0x0966 and 0x096F, inclusive.
        ///  Is between 0x0F18 and 0x0F19, inclusive.
        ///  Is between 0x0F20 and 0x0F33, inclusive.
        ///  Is between 0x0F3E and 0x0F3F, inclusive.
        ///  Is between 0x0ED0 and 0x0ED9, inclusive.
        ///  Is between 0x17E0 and 0x17F9, inclusive.
        /// A bidirectional alpha character is defined as a character that satisfies one of the following constraints:
        ///  Is 0x067E or 0x0686 or 0x0698 or 0x06AF or 0x05C4.
        ///  Is between 0x0621 and 0x0652, inclusive.
        ///  Is between 0x05D0And 0x05EA, inclusive.
        ///  Is between 0x05B0 and 0x05B9, inclusive.
        ///  Is between 0x05BB and 0x05C2, inclusive.
        ///  Is between 0x05F0 and 0x05F2, inclusive.
        ///  Is between 0x0591 and 0x05A1, inclusive.
        ///  Is between 0x05A3 and 0x05AF, inclusive.
        ///  Is between 0x0710 and 0x072C, inclusive.
        ///  Is between 0x0730 and 0x073F, inclusive.
        ///  Is any linguistic character in a right-to-left alphabet.
        /// An alpha character is defined as that which satisfies one of the following constraints:
        ///  Is between 'a' and 'z', inclusive.
        ///  Is between 'A' and 'Z', inclusive.
        ///  Is an uppercase or lowercase character in a left-to-right, non-East Asian alphabet.
        ///  Is a Hangul compatibility Jamo, meaning between 0x3131 and 0x318E, inclusive.
        ///  Is a Hangul Jamo, meaning between 0xAC00 and 0xD7A3, inclusive.
        ///  Is a Kanji character, meaning that it is 0x3005 or 0x3007 or between 0x4E00 and 0x9FFF, inclusive, or the Unicode sub-range of the character
        /// is either CJK Compatibility Ideographs or CJK
        /// Unified Ideographs Extension A.
        ///  Is not a character that satisfies the definition of a digit given earlier, and satisfies one of the following constraints:
        ///  Is not 0x1780 and the top 2 bytes of the character are 0x900, 0xE00, 0xF00 or 0x1700 and satisfies one of the following constraints:
        ///  Is between 0x901 and 0x939, inclusive.
        ///  Is 0x93D.
        ///  Is between 0x93E and 0x94D, inclusive.
        ///  Is between 0x950 and 0x963, inclusive.
        ///  Is between 0x966 and 0x96F, inclusive.
        ///  Is between 0x0E01 and 0x0E2E, inclusive.
        ///  Is between 0x0E30 and 0x0E3A, inclusive.
        ///  Is between 0x0E40 and 0x0E4C, inclusive.
        ///  Is between 0x0E50 and 0x0E59, inclusive.
        ///  Is between 0x0E5A and 0x0E5B, inclusive.
        ///  Is between 0x0E80 and 0x0ECD, inclusive.
        ///  Is between 0x0EDC and 0x0EDD, inclusive.
        ///  Is between 0x0F00 and 0x0F07, inclusive.
        ///  Is between 0x0F15 and 0x0F17, inclusive.
        ///  Is between 0x0F1A and 0x0F1F, inclusive.
        ///  Is between 0x0F34 and 0x0F3D, inclusive.
        ///  Is between 0x0F40 and 0x0FCF, inclusive.
        ///  Is between 0x1780 and 0x17DD, inclusive.
        ///  Satisfies all of the following:
        ///  The top 2 bytes of the character are not 0x900, 0xE00, 0xF00 or 0x1700.
        ///  Is a Unicode 3 South Asian character—meaning that it is less than or equal to 0x900 and satisfies one of the following:
        ///  Is less than or equal to 0x109F.
        ///  Is between 0x1780 and 0x19FF, inclusive.
        ///  Is any linguistic character in a left-to-right, non-East Asian language.
        ///  Satisfies the definition of bidirectional alpha character that was given earlier.
        ///  Is a Vietnamese tonemark, meaning it is one of the following: 0x0300, 0x0301, 0x0303, 0x0309, or 0x0323.
        ///  Is a low surrogate character, meaning that it is between 0xDC00 and 0xDFFF, inclusive.
        ///  Is a high surrogate character, meaning that it is between 0xD840 and 0xD869, inclusive.
        ///  Is between 0xA000 and 0xA4C6, inclusive.
        /// An East Asian double-byte text character is defined as that which satisfies one of the following constraints:
        ///  Is between 0x3000 and 0x4DB5, inclusive.
        ///  Is between 0x1100 and 0x11F9, inclusive.
        ///  Is between 0xAC00 and 0xD7A3, inclusive.
        ///  Is between 0x4E00 and 0x9FFF, inclusive.
        ///  Is between 0xE815 and 0xE864, inclusive.
        ///  Is between 0xF900 and 0xFAFF, inclusive.
        ///  Is between 0xFE30 and 0xFE4F, inclusive.
        ///  Is between 0xFF00 and 0xFF5F, inclusive.
        ///  Is between 0xE000 and 0xE7FF, inclusive.
        ///  Is between 0x2460 and 0x24FF, inclusive.
        ///  Is between 0x0080 and satisfies both of the following constraints:
        ///  Is a high surrogate character, meaning it is between 0xD800 and 0xDBFF, inclusive. If this constraint is reached and satisfied during delayed
        /// evaluation of the conditions upon strings in SttbfBkmk, then it is a skip character.
        ///  Is between 0xD840 and 0xD869, inclusive.
        ///  Is greater than or equal to 0x0080 and satisfies all of the following constraints:
        ///  Not a high or low surrogate character, where a low surrogate character is defined as between 0xDC00 and 0xDFFF, inclusive.
        ///  Can be expressed as a multibyte character string in an East Asian code page.
        self.sttb = try STTB(dataStream: &dataStream)
        if !self.sttb.fExtend {
            throw OfficeFileError.corrupted
        }
        if self.sttb.cData > 0x3FFC {
            throw OfficeFileError.corrupted
        }
        if self.sttb.cbExtra != 0 {
            throw OfficeFileError.corrupted
        }
        if self.sttb.cchData.contains(where: { $0 > 40 }) {
            throw OfficeFileError.corrupted
        }
    }
}
