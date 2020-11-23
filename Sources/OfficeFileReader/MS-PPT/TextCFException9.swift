//
//  TextCFException9.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.17 TextCFException9
/// Referenced by: StyleTextProp9, TextDefaults9Atom, TextMasterStyle9Level
/// A structure that specifies additional character-level formatting.
public struct TextCFException9 {
    public let masks: CFMasks
    public let pp10runid: Bool?
    public let unused: UInt32?
    
    public init(dataStream: inout DataStream) throws {
        /// masks (4 bytes): A CFMasks structure that specifies which fields of this TextCFException9 exist and are valid. Sub-fields are further specified in
        /// the following table.
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
        /// masks.oldEATypeface MUST be zero.
        /// masks.ansiTypeface MUST be zero.
        /// masks.symbolTypeface MUST be zero.
        /// masks.newEATypeface MUST be zero.
        /// masks.csTypeface MUST be zero.
        /// masks.pp11ext MUST be zero.
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
            masks.oldEATypeface ||
            masks.ansiTypeface ||
            masks.symbolTypeface ||
            masks.newEATypeface ||
            masks.csTypeface ||
            masks.pp11ext {
            throw OfficeFileError.corrupted
        }
        
        self.masks = masks
        
        if self.masks.pp10ext {
            var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
            
            /// A - pp10runid (4 bits): An optional unsigned integer that specifies an identifier for a character run that contains TextCFException10 data.
            /// It MUST exist if and only if masks.pp10ext is TRUE.
            self.pp10runid = flags.readBit()
            
            /// unused (28 bits): Undefined and MUST be ignored. It MUST exist if and only if masks.pp10ext is TRUE
            self.unused = flags.readRemainingBits()
        } else {
            self.pp10runid = nil
            self.unused = nil
        }
    }
}
