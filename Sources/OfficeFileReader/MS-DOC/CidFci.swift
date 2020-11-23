//
//  CidFci.swift
//
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.36 CidFci
/// The CidFci structure is a command identifier that specifies a built-in command.
public struct CidFci {
    public let cmt: Cmt
    public let fci: UInt16
    public let swArg: UInt16
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// cmt (3 bits): A Cmt value that specifies the command type. This value MUST be cmtFci.
        let cmtRaw: UInt8 = UInt8(flags.readBits(count: 3))
        guard let cmt = Cmt(rawValue: cmtRaw) else {
            throw OfficeFileError.corrupted
        }
        guard cmt != .fci else {
            throw OfficeFileError.corrupted
        }
        
        self.cmt = cmt
        
        /// fci (13 bits): An unsigned integer that specifies the command. The integer MUST be either a valid Fci value, or 0x0193. The value also
        /// MUST be one of the following:
        ///  Less than 0x049D
        ///  Greater than or equal to 0x0FA0, and less than 0x1011
        ///  Greater than 0x1388
        /// When emitting, the following special rules apply.
        ///  If the intended command is OfficeDrawingCommand and the argument to the
        /// OfficeDrawingCommand (the value of swArg) is not in the intervals:
        ///  Greater than or equal to 0x0002, and less than 0x012C.
        ///  Greater than or equal to 0x1001, and less than 0x10CB.
        ///  Greater than or equal to 0x2001, and less than 0x20CB.
        ///  Greater than or equal to 0x3000, and less than 0x3011.
        ///  Then fci MUST be FileAOCEAddMailer; otherwise, OfficeDrawingCommand MUST be emitted.
        ///  If the intended command is any of the following, fci MUST be 0x0193 AND the intended command
        /// MUST be in swArg:
        ///  ToolsWordCountList
        ///  OutlineLevel
        ///  ShowLevel
        ///  If the intended command is ToolsFixHHC then fci MUST be MenuFormatBackground AND swArg MUST be ToolsFixHHC.
        ///  If the intended command is any of the following, fci MUST be ToolsTranslateChinese AND the intended command MUST be in swArg.
        ///  FileNewContext
        ///  LineSpacing
        ///  AcceptChangesSelected
        ///  RejectChangesSelected
        ///  InsertNewComment
        ///  If the intended command is not one of the following:
        ///  ToolsWordCountList
        ///  OutlineLevel
        ///  ShowLevel
        ///  OfficeDrawingCommand
        ///  FileNewContext
        ///  LineSpacing
        ///  AcceptChangesSelected
        ///  RejectChangesSelected
        ///  InsertNewComment
        ///  ToolsFixHHC AND the intended command is a valid Fci value AND it is NOT one of the following:
        ///  Less than 0x049D.
        ///  Greater than or equal to 0x0FA0 and less than 0x1011.
        ///  Greater than 0x1388.
        /// Then, fci MUST be Bold.
        /// The following special meaning applies:
        ///  If the value of fci is FileAOCEAddMailer and the value of swArg is not 0, the CidFci SHOULD<207> have the same meaning as if fci
        /// were OfficeDrawingCommand.
        ///  If the value of fci is either 0x0193, MenuFormatBackground, ToolsTranslateChinese, or Bold, and the value of swArg is a valid Fci
        /// value that is not allowed in fci, the CidFci SHOULD<208> have the same meaning as if fci was the Fci specified in swArg and the
        /// value of swArg is 0.
        self.fci = UInt16(flags.readBits(count: 13))
        
        /// swArg (2 bytes): Depends on the value of fci as follows:
        ///  If the value of fci is OfficeDrawingCommand (or FileAOCEAddMailer instead of OfficeDrawingCommand, as specified in the special
        /// rules for fci), then swArg is a MSODGCID, as specified in [MS-ODRAW] section 2.4.2, that specifies a drawing command.
        ///  If the value of fci is 0x0193, then swArg is an Fci value that specifies the command. It MUST be either ToolsWordCountList,
        /// OutlineLevel, or ShowLevel.
        ///  If the value of fci is MenuFormatBackground, ToolsTranslateChinese, or Bold, then swArg MUST be either an Fci value that is allowed
        /// as specified in the special rules for fci, or 0, which specifies that the special rules do not apply and the command is actually what fci indicates.
        ///  If the value of fci is FormatDrawingObject, then swArg is an unsigned integer that specifies which tab of the Format Object dialog
        /// is selected by default. The value of swArg MUST be one of the following:
        ///  0x0000 – no preference.
        ///  0x0046 – the tab which contains line width options.
        ///  0x0047 – the tab which contains arrow options.
        ///  0x0245 – the tab which contains color and line options.
        ///  0x0249 – the tab which contains size options.
        ///  If the value of fci is FontColor, ShadingColor, Highlight, BorderLineColor, UnderlineColor, or UnderlineStyle, then swArg is an unsigned
        /// integer that specifies whether a whole or partial control is needed. If valid, swArg MUST be one of the following:
        ///  0x0000 – whole control.
        ///  0x03E8 (not valid for UnderlineStyle) – only the portion that contains "Automatic" or "No Color" / "No Fill".
        ///  0x03E9 (not valid for UnderlineStyle) – only the portion that contains a grid of pre-defined colors.
        ///  0x03EA (not valid for Highlight) – only the portion that contains "More Colors" or "More Underlines".
        ///  If the value of fci is either FixSpellingChange or SpellingAndAutoCorrect, then swArg is a signed integer that specifies the 0-based
        /// index of the spelling suggestion being chosen by the command.
        /// Negative values MUST be ignored.
        ///  If the value of fci is FileMru, then swArg is an unsigned integer that specifies the 0-based index in the "Most Recently Used" list of
        /// the file to be open.
        ///  If the value of fci is ToolsAutoManager, then swArg is an unsigned integer that specifies which variant of the Auto options dialog
        /// is needed. It MUST be one of the following:
        ///  0x0000 – generic Auto options dialog (AutoCorrect, AutoFormat, and so on).
        ///  0x017A – dialog geared towards editing AutoCorrect options.
        ///  0x03D9 – dialog geared towards editing AutoText entries.
        ///  If the value of fci is FormatObjectCore, then swArg is an unsigned integer that specifies whether the intention of the command is
        /// formatting the borders of the object. It MUST be either of the following:
        ///  0x0000 – formatting the object.
        ///  0x00BD – formatting the borders.
        ///  If the value of fci is RunToggle, then swArg is a signed integer that MUST be either of the following:
        ///  0x0000 – toggles between right-to-left and left-to-right input.
        ///  Greater than 0 – specifies a 1-based index of a keyboard layout to switch to. The availability of keyboard layouts is implementation-specific.
        ///  If the value of fci is FixSynonymMenu, then swArg MUST be ignored.
        ///  If the value of fci is ToolbarLabel, then swArg specifies the toolbar control identifier (TCID) of the label. A list of possible values can
        /// be found in [MS-CTDOC] section 2.2.
        ///  For all other values of fci, the value of swArg MUST be 0.
        self.swArg = try dataStream.read(endianess: .littleEndian)
    }
}
