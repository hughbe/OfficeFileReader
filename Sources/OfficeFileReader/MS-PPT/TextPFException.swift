//
//  TextPFException.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.20 TextPFException
/// Referenced by: TextMasterStyleLevel, TextPFExceptionAtom, TextPFRun
/// A structure that specifies paragraph-level formatting.
public struct TextPFException {
    public let masks: PFMasks
    public let bulletFlags: BulletFlags?
    public let bulletChar: Int16?
    public let bulletFontRef: FontIndexRef?
    public let bulletSize: BulletSize?
    public let bulletColor: ColorIndexStruct?
    public let textAlignment: TextAlignmentEnum?
    public let lineSpacing: ParaSpacing?
    public let spaceBefore: ParaSpacing?
    public let spaceAfter: ParaSpacing?
    public let leftMargin: MarginOrIndent?
    public let indent: MarginOrIndent?
    public let defaultTabSize: TabSize?
    public let tabStops: TabStops?
    public let fontAlign: TextFontAlignmentEnum?
    public let wrapFlags: PFWrapFlags?
    public let textDirection: TextDirectionEnum?
    
    public init(dataStream: inout DataStream) throws {
        /// masks (4 bytes): A PFMasks structure that specifies whether certain fields of this TextPFException record exist and are valid. Sub-fields are
        /// further specified in the following table.
        /// Field Meaning
        /// masks.bulletBlip MUST be zero.
        /// masks.bulletHasScheme MUST be zero.
        /// masks.bulletScheme MUST be zero.
        // TODO: found these somewhere?
        let masks = try PFMasks(dataStream: &dataStream)
        if //masks.bulletBlip ||
            //masks.bulletHasScheme ||
            masks.bulletScheme {
            throw OfficeFileError.corrupted
        }
    
        self.masks = masks
        
        /// bulletFlags (2 bytes): An optional BulletFlags structure that specifies whether certain bullet-related fields are valid. It MUST exist if and only if
        /// any of masks.hasBullet, masks.bulletHasFont, masks.bulletHasColor, or masks.bulletHasSize is TRUE.
        if masks.hasBullet || masks.bulletHasFont || masks.bulletHasColor || masks.bulletHasSize {
            self.bulletFlags = try BulletFlags(dataStream: &dataStream)
        } else {
            self.bulletFlags = nil
        }
        
        /// bulletChar (2 bytes): An optional signed integer that specifies a UTF-16 Unicode [RFC2781] character to display as the bullet. The character
        /// MUST NOT be the NUL character 0x0000. It MUST exist if and only if masks.bulletChar is TRUE.
        if self.masks.bulletChar {
            self.bulletChar = try dataStream.read(endianess: .littleEndian)
            if self.bulletChar == 0x0000 {
                throw OfficeFileError.corrupted
            }
        } else {
            self.bulletChar = nil
        }
        
        /// bulletFontRef (2 bytes): An optional FontIndexRef that specifies the font to use for the bullet. It MUST exist if and only if masks.bulletFont is TRUE.
        /// This field is valid if and only if bulletFlags.fBulletHasFont is TRUE.
        if self.masks.bulletFont {
            self.bulletFontRef = try dataStream.read(endianess: .littleEndian)
        } else {
            self.bulletFontRef = nil
        }
        
        /// bulletSize (2 bytes): An optional BulletSize that specifies the size of the bullet. It MUST exist if and only if masks.bulletSize is TRUE. This field is
        /// valid if and only if bulletFlags.fBulletHasSize is TRUE.
        if self.masks.bulletSize {
            self.bulletSize = try dataStream.read(endianess: .littleEndian)
        } else {
            self.bulletSize = nil
        }
        
        /// bulletColor (4 bytes): An optional ColorIndexStruct structure that specifies the color of a bullet. This field exists if and only if masks.bulletColor
        /// is TRUE. This field is valid if and only if bulletFlags.fBulletHasColor is TRUE.
        if self.masks.bulletColor {
            self.bulletColor = try ColorIndexStruct(dataStream: &dataStream)
        } else {
            self.bulletColor = nil
        }
        
        /// textAlignment (2 bytes): An optional TextAlignmentEnum enumeration that specifies the alignment of the paragraph. It MUST exist if and only if
        /// masks.align is TRUE.
        if self.masks.align {
            let textAlignmentRaw: UInt16 = try dataStream.read(endianess: .littleEndian)
            guard let textAlignment = TextAlignmentEnum(rawValue: textAlignmentRaw) else {
                throw OfficeFileError.corrupted
            }

            self.textAlignment = textAlignment
        } else {
            self.textAlignment = nil
        }
        
        /// lineSpacing (2 bytes): An optional ParaSpacing that specifies the spacing between lines in the paragraph. It MUST exist if
        /// and only if masks.lineSpacing is TRUE.
        if self.masks.lineSpacing {
            self.lineSpacing = try ParaSpacing(dataStream: &dataStream)
        } else {
            self.lineSpacing = nil
        }
        
        /// spaceBefore (2 bytes): An optional ParaSpacing that specifies the size of the spacing before the paragraph. It MUST exist if and only if
        /// masks.spaceBefore is TRUE.
        if self.masks.spaceBefore {
            self.spaceBefore = try ParaSpacing(dataStream: &dataStream)
        } else {
            self.spaceBefore = nil
        }
        
        /// spaceAfter (2 bytes): An optional ParaSpacing that specifies the size of the spacing after the paragraph. It MUST exist if and only if
        /// masks.spaceAfter is TRUE.
        if self.masks.spaceAfter {
            self.spaceAfter = try ParaSpacing(dataStream: &dataStream)
        } else {
            self.spaceAfter = nil
        }
        
        /// leftMargin (2 bytes): An optional MarginOrIndent that specifies the left margin of the paragraph. It MUST exist if and only if masks.leftMargin is
        /// TRUE.
        if self.masks.leftMargin {
            self.leftMargin = try dataStream.read(endianess: .littleEndian)
        } else {
            self.leftMargin = nil
        }
        
        /// indent (2 bytes): An optional MarginOrIndent that specifies the indentation of the paragraph. It MUST exist if and only if masks.indent is TRUE.
        if self.masks.indent {
            self.indent = try dataStream.read(endianess: .littleEndian)
        } else {
            self.indent = nil
        }
        
        /// defaultTabSize (2 bytes): An optional TabSize that specifies the default tab size of the paragraph. It MUST exist if and only if masks.defaultTabSize
        /// is TRUE.
        if self.masks.defaultTabSize {
            self.defaultTabSize = try dataStream.read(endianess: .littleEndian)
        } else {
            self.defaultTabSize = nil
        }
        
        /// tabStops (variable): An optional TabStops structure that specifies the tab stops for the paragraph. It MUST exist if and only if masks.tabStops
        /// is TRUE.
        if self.masks.tabStops {
            self.tabStops = try TabStops(dataStream: &dataStream)
        } else {
            self.tabStops = nil
        }
        
        /// fontAlign (2 bytes): An optional TextFontAlignmentEnum enumeration that specifies the font alignment of the text in the paragraph. It MUST exist
        /// if and only if masks.fontAlign is TRUE.
        if self.masks.fontAlign {
            let fontAlignRaw: UInt16 = try dataStream.read(endianess: .littleEndian)
            guard let fontAlign = TextFontAlignmentEnum(rawValue: fontAlignRaw) else {
                throw OfficeFileError.corrupted
            }

            self.fontAlign = fontAlign
        } else {
            self.fontAlign = nil
        }
        
        /// wrapFlags (2 bytes): An optional PFWrapFlags structure that specifies text-wrapping options for the paragraph. It MUST exist if and only if any of
        /// masks.charWrap, masks.wordWrap, or masks.overflow is TRUE.
        if masks.charWrap || masks.wordWrap || masks.overflow {
            self.wrapFlags = try PFWrapFlags(dataStream: &dataStream)
        } else {
            self.wrapFlags = nil
        }
        
        /// textDirection (2 bytes): An optional TextDirectionEnum enumeration that specifies the direction of the text in this paragraph. It MUST exist if and
        /// only if masks.textDirection is TRUE.
        if self.masks.textDirection {
            let textDirectionRaw: UInt16 = try dataStream.read(endianess: .littleEndian)
            guard let textDirection = TextDirectionEnum(rawValue: textDirectionRaw) else {
                throw OfficeFileError.corrupted
            }

            self.textDirection = textDirection
        } else {
            self.textDirection = nil
        }
    }
}
