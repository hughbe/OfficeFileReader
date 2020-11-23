//
//  Acd.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9 Basic Types
/// [MS-DOC] 2.9.1 Acd
/// The Acd structure specifies an allocated command.
public struct Acd {
    public let ibst: UInt16
    public let fciBasedOn: Fci
    public let reserved: Bool
    public let fFree: Bool
    public let fRef: Bool
    
    public init(dataStream: inout DataStream) throws {
        /// ibst (2 bytes): Index in the Command String Table (TcgSttbf.sttbf) where a string representation of the argument to the allocated
        /// command is specified.
        self.ibst = try dataStream.read(endianess: .littleEndian)
        
        let rawValue: UInt16 = try dataStream.read(endianess: .littleEndian)

        /// fciBasedOn (13 bits): An Fci that identifies the allocated command. MUST be one of the following Fci values. Each item specifies
        /// what the value of the argument as specified by ibst is.
        ///  ApplyStyleName. The argument specifies the style to apply. The argument MUST be at least 2 characters long. The 16-bit value
        /// of the first character MUST be either 0x0001 or 0x0002.
        ///  If the 16-bit value of the first character is 0x0001, then the argument MUST be exactly 3 characters long. The second and third
        /// characters specify the sti of the style to apply (see StdfBase.sti). The sti is given by (c2 & 0x00FF) * 256 + (c3 & 0x00FF) where c2
        /// and c3 represent the character codes of the second and third characters. The sti value MUST be less than 267.
        ///  If the 16-bit value of the first character is 0x0002, then the remaining characters in the argument specify the name of the style
        /// to apply.
        ///  ApplyFontName. The argument is the name of the font to apply when this command is executed.
        ///  ApplyAutoTextName. The argument is the name of the AutoText entry to insert when this command is executed.
        ///  Columns. The argument specifies the number of columns to apply. The number of columns is the character code of the first
        /// character in the string.
        ///  Condensed. The argument specifies the amount to condense by. The amount is specified in twips and is given by
        /// (c1 & 0x00FF) * 256 + (c2 & 0x00FF) where c1 and c2 represent the character codes of the first and second characters in the
        /// argument string.
        ///  Expanded. The argument specifies the amount to expand by. The amount is specified in twips and is given by
        /// (c1 & 0x00FF) * 256 + (c2 & 0x00FF) where c1 and c2 represent the character codes of the first and second characters in the
        /// argument string.
        ///  FontSize. The argument specifies the font size. The amount is specified in half points and is given by
        /// (c1 & 0x00FF) * 256 + (c2 & 0x00FF) where c1 and c2 represent the 16-bit values of the first and second characters in the argument
        /// string.
        ///  Lowered. The argument specifies the amount to lower the text by. The amount is specified in half points and is given by
        /// (c1 & 0x00FF) * 256 + (c2 & 0x00FF) where c1 and c2 represent the 16-bit values of the first and second characters in the argument
        /// string.
        ///  Raised. The argument specifies the amount to raise the text by. The amount is specified in half points and is given by
        /// (c1 & 0x00FF) * 256 + (c2 & 0x00FF) where c1 and c2 represent the 16-bit values codes of the first and second characters in the
        /// argument string.
        ///  FileOpenFile. The argument specifies the file name to open.
        ///  Shading. The argument specifies which shading pattern to apply. The 16-bit value of the first character of the argument is an IPat.
        ///  Borders. The argument specifies which border to apply. The 16-bit value of the first character of the argument MUST be one of
        /// the following values, and specifies which border to apply.
        /// Value Meaning
        /// 0 Clear all borders.
        /// 1 Apply top border.
        /// 2 Apply bottom border.
        /// 3 Apply left border.
        /// 4 Apply right border.
        /// 5 Apply inside borders.
        /// 6 Apply box borders.
        /// 7 Apply grid borders.
        /// The weight and style of the border applied is that of the last border applied by the user during the editing session, or a single, black
        /// border if no border has been applied in this session.
        ///  Color. The argument specifies the color to apply. The 16-bit value of the first character of the argument is an Ico.
        ///  Symbol. The argument specifies the symbol character and font to insert. The first character of the argument is the symbol
        /// character to insert. If there are more characters in the argument, they form the name of the font to apply to the newly inserted
        /// character. If the character set of the font to use is the SYMBOL_CHARSET then the symbol character to insert is given by
        /// (c1 & 0x00FF).
        guard let fciBasedOn = Fci(rawValue: rawValue & 0b1111111111111) else {
            throw OfficeFileError.corrupted
        }
        
        self.fciBasedOn = fciBasedOn
        
        /// A - reserved (1 bit): This value MUST be 1.
        self.reserved = ((rawValue >> 13) & 0b1) != 0
        
        /// B - fFree (1 bit): Specifies whether the current Acd is an unused slot in PlfAcd.rgacd. A value of 1 specifies that the current Acd is
        /// unused. A value of 0 specifies that the current Acd is valid and used.
        self.fFree = ((rawValue >> 14) & 0b1) != 0
        
        /// C - fRef (1 bit): Specifies whether the current Acd is being referenced by a command. If fFree is 1, fRef MUST be 0; if fFree is 0,
        /// fRef MUST be 1.
        self.fRef = ((rawValue >> 15) & 0b1) != 0
    }
}
