//
//  TextCFRun.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.46 TextCFRun
/// Referenced by: StyleTextPropAtom
/// A structure that specifies the character-level formatting of a run of text.
/// Let the corresponding text be as specified in the StyleTextPropAtom record that contains this TextCFRun structure.
public struct TextCFRun {
    public let count: UInt32
    public let cf: TextCFException
    
    public init(dataStream: inout DataStream) throws {
        /// count (4 bytes): An unsigned integer that specifies the number of characters of the corresponding text to which this character formatting applies.
        self.count = try dataStream.read(endianess: .littleEndian)
        
        /// cf (variable): A TextCFException structure that specifies character-level formatting.
        self.cf = try TextCFException(dataStream: &dataStream)
    }
}
