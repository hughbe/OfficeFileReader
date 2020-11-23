//
//  StyleTextProp11.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.71 StyleTextProp11
/// Referenced by: StyleTextProp11Atom
/// A structure that specifies additional text properties
public struct StyleTextProp11 {
    public let info: TextSIException
    
    public init(dataStream: inout DataStream) throws {
        /// info (variable): A TextSIException structure that specifies additional text properties for a text run. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// info.spell MUST be zero.
        /// info.lang MUST be zero.
        /// info.altLang MUST be zero.
        /// info.fPp10ext MUST be zero.
        /// info.fBidi MUST be zero.
        self.info = try TextSIException(dataStream: &dataStream)
        if self.info.spell ||
            self.info.lang ||
            self.info.altLang ||
            self.info.fPp10ext ||
            self.info.fBidi {
            throw OfficeFileError.corrupted
        }
    }
}
