//
//  TextMasterStyle10Level.swift
//
//
//  Created by Hugh Bellamy on 18/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.40 TextMasterStyle10Level
/// Referenced by: TextMasterStyle10Atom
/// A structure that specifies additional character-level formatting for a style level.
public struct TextMasterStyle10Level {
    public let cf10: TextCFException10
    
    public init(dataStream: inout DataStream) throws {
        /// cf10 (variable): A TextCFException10 structure that specifies additional character-level formatting.
        self.cf10 = try TextCFException10(dataStream: &dataStream)
    }
}
