//
//  StyleTextProp9.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.68 StyleTextProp9
/// Referenced by: StyleTextProp9Atom
/// A structure that specifies additional paragraph-level formatting, character-level formatting, and text properties for a text run.
public struct StyleTextProp9 {
    public let pf9: TextPFException9
    public let cf9: TextCFException9
    public let si: TextSIException
    
    public init(dataStream: inout DataStream) throws {
        /// pf9 (variable): A TextPFException9 structure that specifies additional paragraph-level formatting.
        self.pf9 = try TextPFException9(dataStream: &dataStream)
        
        /// cf9 (variable): A TextCFException9 structure that specifies additional character-level formatting.
        self.cf9 = try TextCFException9(dataStream: &dataStream)
        
        /// si (variable): A TextSIException structure that specifies additional text properties. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// masks.spell MUST be 0.
        /// masks.lang MUST be 0.
        /// masks.altLang MUST be 0.
        /// masks.smartTag MUST be 0.
        self.si = try TextSIException(dataStream: &dataStream)
        if self.si.spell || self.si.lang || self.si.altLang || self.si.smartTag {
            throw OfficeFileError.corrupted
        }
    }
}
