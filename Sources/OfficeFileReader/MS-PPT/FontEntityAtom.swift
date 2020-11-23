//
//  FontEntityAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.10 FontEntityAtom
/// Referenced by: FontCollectionEntry
/// An atom record that specifies the information needed to define the attributes of a font, such as typeface name, character set, and so on, and
/// corresponds in part to a Windows Logical Font (LOGFONT) structure [MC-LOGFONT].
public struct FontEntityAtom {
    public let rh: RecordHeader
    public let lfFaceName: String
    public let lfCharSet: UInt8
    public let fEmbedSubsetted: Bool
    public let unused: UInt8
    public let rasterFontType: Bool
    public let deviceFontType: Bool
    public let truetypeFontType: Bool
    public let fNoFontSubstitution: Bool
    public let reserved: UInt8
    public let lfPitchAndFamily: UInt8
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be greater than or equal to 0 and less than or equal to 128.
        /// rh.recType MUST be an RT_FontEntityAtom.
        /// rh.recLen MUST be equal to 0x00000044.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance <= 128 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .fontEntityAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000044 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// lfFaceName (64 bytes): A char2 that specifies the typeface name of the font. It corresponds to the lfFaceName field of the LOGFONT structure.
        /// The length of this string MUST NOT exceed 32 characters, including the terminating null character.
        self.lfFaceName = try dataStream.readString(count: 64, encoding: .utf16LittleEndian)!.trimmingCharacters(in: ["\0"])
        
        /// lfCharSet (1 byte): An unsigned byte that specifies the character set. It corresponds to the lfCharSet field of the LOGFONT structure.
        self.lfCharSet = try dataStream.read()
        
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fEmbedSubsetted (1 bit): A bit that specifies whether a subset of this font is embedded.
        self.fEmbedSubsetted = flags.readBit()
        
        /// unused (7 bits): Undefined and MUST be ignored.
        self.unused = UInt8(flags.readBits(count: 7))
        
        /// B - rasterFontType (1 bit): A bit that specifies whether the font is a raster font.
        self.rasterFontType = flags.readBit()
        
        /// C - deviceFontType (1 bit): A bit that specifies whether the font is a device font.
        self.deviceFontType = flags.readBit()
        
        /// D - truetypeFontType (1 bit): A bit that specifies whether the font is a TrueType font.
        self.truetypeFontType = flags.readBit()
        
        /// E - fNoFontSubstitution (1 bit): A bit that specifies whether font substitution logic is not applied for this font.
        self.fNoFontSubstitution = flags.readBit()
        
        /// F - reserved (4 bits): MUST be zero and MUST be ignored.
        self.reserved = UInt8(flags.readRemainingBits())
        
        /// lfPitchAndFamily (1 byte): An unsigned byte that specifies the pitch and family of the font. It corresponds to the lfPitchAndFamily field of
        /// the LOGFONT structure.
        self.lfPitchAndFamily = try dataStream.read()
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
