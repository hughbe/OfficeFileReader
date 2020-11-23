//
//  MasterTextPropRun.swift
//  
//
//  Created by Hugh Bellamy on 13/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.80 MasterTextPropRun
/// Referenced by: MasterTextPropAtom
/// A structure that specifies the indent level for a text run.
/// Let the corresponding text be as specified in the MasterTextPropAtom record that contains this MasterTextPropRun structure.
public struct MasterTextPropRun {
    public let count: UInt32
    public let indentLevel: IndentLevel
    
    public init(dataStream: inout DataStream) throws {
        /// count (4 bytes): An unsigned integer that specifies the number of characters of the corresponding text to which indentLevel applies.
        self.count = try dataStream.read(endianess: .littleEndian)
        
        /// indentLevel (2 bytes): An IndentLevel that specifies the indent level of the characters.
        self.indentLevel = try IndentLevel(dataStream: &dataStream)
    }
}
