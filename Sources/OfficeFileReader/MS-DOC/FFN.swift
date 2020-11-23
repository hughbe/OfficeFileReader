//
//  FFN.swift
//
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.82 FFN
/// The FFN structure specifies information about a font that is used in the document. This information MUST be complete for each font. In addition
/// to specifying a specific named font, this information is intended for the purpose of font substitution when that named font is not available.
public struct FFN {
    public let ffid: FFID
    public let wWeight: Int16
    public let chs: CharacterSet
    public let ixchSzAlt: UInt8
    public let panose: PANOSE
    public let fs: FONTSIGNATURE
    public let xszFfn: String
    public let xszAlt: String?
    
    public init(dataStream: inout DataStream) throws {
        /// ffid (1 byte): An FFID that specifies the font family.
        self.ffid = try FFID(dataStream: &dataStream)
        
        /// wWeight (2 bytes): A signed integer that specifies the visual weight of the font. This value MUST be between 0 and 1000. A value of 700
        /// corresponds to bold text. A value of 400 corresponds to normal text.
        let wWeight: Int16 = try dataStream.read(endianess: .littleEndian)
        if wWeight < 0 || wWeight > 1000 {
            throw OfficeFileError.corrupted
        }
        
        self.wWeight = wWeight
        
        /// chs (1 byte): An unsigned integer that specifies the character set that is used by the font. This MUST be one of the following values.
        let chsRaw: UInt8 = try dataStream.read()
        guard let chs = CharacterSet(rawValue: chsRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.chs = chs
        
        /// ixchSzAlt (1 byte): An unsigned integer that specifies the zero-based index into the xszFfn. If nonzero, this value specifies the location
        /// within xszFfn where xszAlt begins.
        self.ixchSzAlt = try dataStream.read()
        
        /// panose (10 bytes): A Panose that specifies font attributes for TrueType fonts.
        self.panose = try PANOSE(dataStream: &dataStream)
        
        /// fs (24 bytes): A FontSignature, as specified in [MC-FONTSIGNATURE], that specifies the Unicode Subset Bitfields of the font, as
        /// specified in [MC-USB], and Code Page Bitfields, as specified in [MC-CPB].
        self.fs = try FONTSIGNATURE(dataStream: &dataStream)
        
        /// xszFfn (variable): A null-terminated Unicode string that MUST contain the name of the font.
        self.xszFfn = try dataStream.readUnicodeString(endianess: .littleEndian)!
        
        /// xszAlt (variable): A null-terminated Unicode string that specifies the name of an alternative font, intended for font substitution if the
        /// font specified by xszFfn is not available. This field, if it exists, begins immediately after the terminating null character of xszFfn. If
        /// ixchSzAlt is nonzero, this string MUST exist, otherwise it MUST NOT exist.
        if self.ixchSzAlt != 0 {
            self.xszAlt = try dataStream.readUnicodeString(endianess: .littleEndian)!
        } else {
            self.xszAlt = nil
        }
    }
    
    /// chs (1 byte): An unsigned integer that specifies the character set that is used by the font. This MUST be one of the following values.
    public enum CharacterSet: UInt8 {
        /// 0 ANSI_CHARSET
        case ANSI_CHARSET = 0

        /// 1 DEFAULT_CHARSET
        case DEFAULT_CHARSET = 1

        /// 2 SYMBOL_CHARSET
        case SYMBOL_CHARSET = 2

        /// 128 SHIFTJIS_CHARSET
        case SHIFTJIS_CHARSET = 128

        /// 129 HANGEUL_CHARSET
        /// 129 HANGUL_CHARSET
        case HANGEUL_CHARSET_OR_HANGUL_CHARSET = 129

        /// 134 GB2312_CHARSET
        case GB2312_CHARSET = 134

        /// 136 CHINESEBIG5_CHARSET
        case CHINESEBIG5_CHARSET = 136

        /// 255 OEM_CHARSET
        case OEM_CHARSET = 255

        /// 130 JOHAB_CHARSET
        case JOHAB_CHARSET = 130

        /// 177 HEBREW_CHARSET
        case HEBREW_CHARSET = 177

        /// 178 ARABIC_CHARSET
        case ARABIC_CHARSET = 178

        /// 161 GREEK_CHARSET
        case GREEK_CHARSET = 161

        /// 162 TURKISH_CHARSET
        case TURKISH_CHARSET = 162

        /// 163 VIETNAMESE_CHARSET
        case VIETNAMESE_CHARSET = 163

        /// 222 THAI_CHARSET
        case THAI_CHARSET = 222

        /// 238 EASTEUROPE_CHARSET
        case EASTEUROPE_CHARSET = 238

        /// 204 RUSSIAN_CHARSET
        case RUSSIAN_CHARSET = 204

        /// 77 MAC_CHARSET
        case MAC_CHARSET = 77

        /// 186 BALTIC_CHARSET
        case BALTIC_CHARSET = 186
    }
    
    /// https://docs.microsoft.com/en-us/windows/win32/api/wingdi/ns-wingdi-fontsignature?redirectedfrom=MSDN
    public struct FONTSIGNATURE {
        public let fsUsb: (UInt32, UInt32, UInt32, UInt32)
        public let fsCsb: (UInt32, UInt32)
        
        public init(dataStream: inout DataStream) throws {
            /// fsUsb A 128-bit Unicode subset bitfield (USB) identifying up to 126 Unicode subranges. Each bit, except the two most significant
            /// bits, represents a single subrange. The most significant bit is always 1 and identifies the bitfield as a font signature; the second
            /// most significant bit is reserved and must be 0. Unicode subranges are numbered in accordance with the ISO 10646 standard.
            /// For more information, see Unicode Subset Bitfields.
            self.fsUsb = (
                try dataStream.read(endianess: .littleEndian),
                try dataStream.read(endianess: .littleEndian),
                try dataStream.read(endianess: .littleEndian),
                try dataStream.read(endianess: .littleEndian)
            )
            
            /// fsCsb A 64-bit, code-page bitfield (CPB) that identifies a specific character set or code page. Code pages are in the lower 32
            /// bits of this bitfield. The high 32 are used for non-Windows code pages. For more information, see Code Page Bitfields.
            self.fsCsb = (
                try dataStream.read(endianess: .littleEndian),
                try dataStream.read(endianess: .littleEndian)
            )
        }
    }
}

extension FFN: STTBData {
    public init(dataStream: inout DataStream, size: UInt16, extend: Bool) throws {
        if extend {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        try self.init(dataStream: &dataStream)
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
