//
//  TextCFException10.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.18 TextCFException10
/// Referenced by: StyleTextProp10Atom, TextDefaults10Atom, TextMasterStyle10Level
/// A structure that specifies additional character-level formatting information.
public struct TextCFException10 {
    public let masks: CFMasks
    public let newEAFontRef: FontIndexRef10?
    public let csFontRef: FontIndexRef10?
    public let pp11ext: UInt32?
    
    public init(dataStream: inout DataStream) throws {
        /// masks (4 bytes): A CFMasks structure that specifies which fields of this TextCFException10 exist and are valid.
        /// Field Meaning
        /// masks.bold MUST be zero.
        /// masks.italic MUST be zero.
        /// masks.underline MUST be zero.
        /// masks.shadow MUST be zero.
        /// masks.fehint MUST be zero.
        /// masks.kumi MUST be zero.
        /// masks.emboss MUST be zero.
        /// masks.fHasStyle MUST be zero.
        /// masks.typeface MUST be zero.
        /// masks.size MUST be zero.
        /// masks.color MUST be zero.
        /// masks.position MUST be zero.
        /// masks.pp10ext MUST be zero.
        /// masks.oldEATypeface MUST be zero.
        /// masks.ansiTypeface MUST be zero.
        /// masks.symbolTypeface MUST be zero.
        let masks = try CFMasks(dataStream: &dataStream)
        if masks.bold ||
            masks.italic ||
            masks.underline ||
            masks.shadow ||
            masks.fehint ||
            masks.kumi ||
            masks.emboss ||
            masks.fHasStyle != 0 ||
            masks.typeface ||
            masks.size ||
            masks.color ||
            masks.position ||
            masks.pp10ext ||
            masks.oldEATypeface ||
            masks.ansiTypeface ||
            masks.symbolTypeface {
            throw OfficeFileError.corrupted
        }
        
        self.masks = masks
        
        /// newEAFontRef (2 bytes): An optional FontIndexRef10 that specifies a new East Asian font. It MUST exist if and only if masks.newEATypeface is
        /// TRUE.
        if self.masks.newEATypeface {
            self.newEAFontRef = try dataStream.read(endianess: .littleEndian)
        } else {
            self.newEAFontRef = nil
        }
        
        /// csFontRef (2 bytes): An optional FontIndexRef10 that specifies a complex script font. It MUST exist if and only if masks.csTypeface is TRUE.
        if self.masks.csTypeface {
            self.csFontRef = try dataStream.read(endianess: .littleEndian)
        } else {
            self.csFontRef = nil
        }
        
        /// pp11ext (4 bytes): Undefined and MUST be ignored. It MUST exist if and only if masks.pp11ext is TRUE.
        if self.masks.pp11ext {
            self.pp11ext = try dataStream.read(endianess: .littleEndian)
        } else {
            self.pp11ext = nil
        }
    }
}
