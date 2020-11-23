//
//  TextCFException.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.14 TextCFException
/// Referenced by: TextCFExceptionAtom, TextCFRun, TextMasterStyleLevel
/// A structure that specifies character-level style and formatting, font information, coloring and positioning.
public struct TextCFException {
    public let masks: CFMasks
    public let fontStyle: CFStyle?
    public let fontRef: FontIndexRef?
    public let oldEAFontRef: FontIndexRef?
    public let ansiFontRef: FontIndexRef?
    public let symbolFontRef: FontIndexRef?
    public let fontSize: Int16?
    public let color: ColorIndexStruct?
    public let position: Int16?
    
    public init(dataStream: inout DataStream) throws {
        /// masks (4 bytes): A CFMasks structure that specifies whether certain fields in this TextCFException record exist and are valid. Sub-fields are
        /// further specified in the following table.
        /// Field Meaning
        /// masks.pp10ext MUST be zero.
        /// masks.newEATypeface MUST be zero.
        /// masks.csTypeface MUST be zero.
        /// masks.pp11ext MUST be zero.
        let masks = try CFMasks(dataStream: &dataStream)
        if masks.pp10ext ||
            // masks.newEATypeface ||
            masks.csTypeface ||
            masks.pp11ext {
            throw OfficeFileError.corrupted
        }
        
        self.masks = masks
        
        /// fontStyle (2 bytes): A CFStyle structure that specifies the character-level style. It MUST exist if and only if one or more of the following fields are
        /// TRUE: masks.bold, masks.italic, masks.underline, masks.shadow, masks.fehint, masks.kumi, masks.emboss, or masks.fHasStyle.
        if masks.bold || masks.italic || masks.underline || masks.shadow || masks.fehint || masks.kumi || masks.emboss || masks.fHasStyle != 0 {
            self.fontStyle = try CFStyle(dataStream: &dataStream)
        } else {
            self.fontStyle = nil
        }
        
        /// fontRef (2 bytes): An optional FontIndexRef that specifies the font. It MUST exist if and only if masks.typeface is TRUE.
        if self.masks.typeface {
            self.fontRef = try dataStream.read(endianess: .littleEndian)
        } else {
            self.fontRef = nil
        }
        
        /// oldEAFontRef (2 bytes): An optional FontIndexRef that specifies an East Asian font. It MUST exist if and only if masks.oldEATypeface is TRUE.
        if self.masks.oldEATypeface {
            self.oldEAFontRef = try dataStream.read(endianess: .littleEndian)
        } else {
            self.oldEAFontRef = nil
        }
        
        /// ansiFontRef (2 bytes): An optional FontIndexRef that specifies an ANSI font. It MUST exist if and only if masks.ansiTypeface is TRUE.
        if self.masks.ansiTypeface {
            self.ansiFontRef = try dataStream.read(endianess: .littleEndian)
        } else {
            self.ansiFontRef = nil
        }
        
        /// symbolFontRef (2 bytes): An optional FontIndexRef that specifies a symbol font. It MUST exist if and only if masks.symbolTypeface is TRUE.
        if self.masks.symbolTypeface {
            self.symbolFontRef = try dataStream.read(endianess: .littleEndian)
        } else {
            self.symbolFontRef = nil
        }
        
        /// fontSize (2 bytes): An optional signed integer that specifies the size, in points, of the font. It MUST be greater than or equal to 1 and less than or
        /// equal to 4000. It MUST exist if and only if masks.size is TRUE.
        if self.masks.size {
            let fontSize: Int16 = try dataStream.read(endianess: .littleEndian)
            if fontSize < 1 || fontSize > 4000 {
                throw OfficeFileError.corrupted
            }
            
            self.fontSize = fontSize
        } else {
            self.fontSize = nil
        }
        
        /// color (4 bytes): An optional ColorIndexStruct structure that specifies the color of the text. It MUST exist if and only if masks.color is TRUE.
        if self.masks.color {
            self.color = try ColorIndexStruct(dataStream: &dataStream)
        } else {
            self.color = nil
        }
        
        /// position (2 bytes): An optional signed integer that specifies the baseline position of a text run relative to the baseline of the text line as a
        /// percentage of line height. It MUST be greater than or equal to -100 and less than or equal to 100. It MUST exist if and only if masks.position
        /// is TRUE.
        if self.masks.position {
            let position: Int16 = try dataStream.read(endianess: .littleEndian)
            if position < -100 || position > 100 {
                throw OfficeFileError.corrupted
            }
            
            self.position = position
        } else {
            self.position = nil
        }
    }
}
