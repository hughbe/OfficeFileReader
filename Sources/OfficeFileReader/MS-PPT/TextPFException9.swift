//
//  TextPFException9.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.26 TextPFException9
/// Referenced by: StyleTextProp9, TextDefaults9Atom, TextMasterStyle9Level
/// A structure that specifies additional paragraph-level formatting.
public struct TextPFException9 {
    public let masks: PFMasks
    public let bulletBlipRef: BlipRef?
    public let fBulletHasAutoNumber: UInt16?
    public let bulletAutoNumberScheme: TextAutoNumberScheme?
    
    public init(dataStream: inout DataStream) throws {
        /// masks (4 bytes): A PFMasks structure that specifies which fields in this TextPFException9 exist.
        /// Sub-fields are further specified in the following table.
        /// Field Meaning
        /// masks.hasBullet MUST be zero.
        /// masks.bulletHasFont MUST be zero.
        /// masks.bulletHasColor MUST be zero.
        /// masks.bulletHasSize MUST be zero.
        /// masks.bulletFont MUST be zero.
        /// masks.bulletColor MUST be zero.
        /// masks.bulletSize MUST be zero.
        /// masks.bulletChar MUST be zero.
        /// masks.leftMargin MUST be zero.
        /// masks.indent MUST be zero.
        /// masks.align MUST be zero.
        /// masks.lineSpacing MUST be zero.
        /// masks.spaceBefore MUST be zero.
        /// masks.spaceAfter MUST be zero.
        /// masks.defaultTabSize MUST be zero.
        /// masks.fontAlign MUST be zero.
        /// masks.charWrap MUST be zero.
        /// masks.wordWrap MUST be zero.
        /// masks.overflow MUST be zero.
        /// masks.tabStops MUST be zero.
        /// masks.textDirection MUST be zero.
        let masks = try PFMasks(dataStream: &dataStream)
        if masks.hasBullet ||
            masks.bulletHasFont ||
            masks.bulletHasColor ||
            masks.bulletHasSize ||
            masks.bulletFont ||
            masks.bulletColor ||
            masks.bulletSize ||
            masks.bulletChar ||
            masks.leftMargin ||
            masks.indent ||
            masks.align ||
            masks.lineSpacing ||
            masks.spaceBefore ||
            masks.spaceAfter ||
            masks.defaultTabSize ||
            masks.fontAlign ||
            masks.charWrap ||
            masks.wordWrap ||
            masks.overflow ||
            masks.tabStops ||
            masks.textDirection {
            throw OfficeFileError.corrupted
        }
        
        self.masks = masks

        /// bulletBlipRef (2 bytes): An optional BlipRef that specifies a picture to use as a bullet for this paragraph. It MUST exist if and only if
        /// masks.bulletBlip is TRUE.
        if self.masks.bulletBlip {
            self.bulletBlipRef = try dataStream.read(endianess: .littleEndian)
        } else {
            self.bulletBlipRef = nil
        }
        
        /// fBulletHasAutoNumber (2 bytes): An optional signed integer that specifies whether this paragraph has an automatic numbering scheme.
        /// It MUST exist if and only if masks.bulletHasScheme is TRUE. It MUST be a value from the following table.
        /// Field Meaning
        /// 0x0000 This paragraph does not have an automatic numbering scheme.
        /// 0x0001 This paragraph has an automatic numbering scheme.
        if self.masks.bulletHasScheme {
            self.fBulletHasAutoNumber = try dataStream.read(endianess: .littleEndian)
        } else {
            self.fBulletHasAutoNumber = nil
        }
        
        /// bulletAutoNumberScheme (4 bytes): An optional TextAutoNumberScheme structure that specifies the automatic numbering scheme for this
        /// paragraph. It MUST exist if and only if masks.bulletScheme is TRUE.
        if self.masks.bulletScheme {
            self.bulletAutoNumberScheme = try TextAutoNumberScheme(dataStream: &dataStream)
        } else {
            self.bulletAutoNumberScheme = nil
        }
    }
}
