//
//  TextMasterStyle9Level.swift
//  
//
//  Created by Hugh Bellamy on 18/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.38 TextMasterStyle9Level
/// Referenced by: TextMasterStyle9Atom
/// A structure that specifies additional character-level and paragraph level-formatting for a style level.
public struct TextMasterStyle9Level {
    public let pf9: TextPFException9
    public let cf9: TextCFException9
    
    public init(dataStream: inout DataStream) throws {
        /// pf9 (variable): A TextPFException9 structure that specifies paragraph-level formatting.
        self.pf9 = try TextPFException9(dataStream: &dataStream)
        
        /// cf9 (variable): A TextCFException9 structure that specifies character-level formatting.
        self.cf9 = try TextCFException9(dataStream: &dataStream)
    }
}
