//
//  TextPFRun.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.45 TextPFRun
/// Referenced by: StyleTextPropAtom
/// A structure that specifies the paragraph-level formatting of a run of text.
/// Let the corresponding text be as specified in the StyleTextPropAtom record that contains this TextPFRun structure.
public struct TextPFRun {
    public let count: UInt32
    public let indentLevel: IndentLevel
    public let pf: TextPFException
    
    public init(dataStream: inout DataStream) throws {
        /// count (4 bytes): An unsigned integer that specifies the number of characters of the corresponding text to which this paragraph formatting applies.
        self.count = try dataStream.read(endianess: .littleEndian)
        
        /// indentLevel (2 bytes): An IndentLevel that specifies the indentation level of the paragraph.
        self.indentLevel = try IndentLevel(dataStream: &dataStream)
        
        /// pf (variable): A TextPFException structure that specifies paragraph-level formatting. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// masks.leftMargin MUST be FALSE.
        /// masks.indent MUST be FALSE.
        /// masks.defaultTabSize MUST be FALSE.
        /// masks.tabStops MUST be FALSE.
        self.pf = try TextPFException(dataStream: &dataStream)
        if //self.pf.masks.leftMargin ||
            //self.pf.masks.indent ||
            self.pf.masks.defaultTabSize ||
            self.pf.masks.tabStops {
            throw OfficeFileError.corrupted
        }
    }
}
