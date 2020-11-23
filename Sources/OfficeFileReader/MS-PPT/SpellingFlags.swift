//
//  SpellingFlags.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.33 SpellingFlags
/// Referenced by: TextSIException
/// A structure that specifies the spelling status of a run of text.
public struct SpellingFlags {
    public let error: Bool
    public let clean: Bool
    public let grammar: Bool
    public let reserved: UInt16
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - error (1 bit): A bit that specifies whether the text is spelled incorrectly.
        self.error = flags.readBit()
        
        /// B - clean (1 bit): A bit that specifies whether the text needs rechecking.
        self.clean = flags.readBit()
        
        /// C - grammar (1 bit): A bit that specifies whether the text has a grammar error.
        self.grammar = flags.readBit()
        
        /// reserved (13 bits): MUST be zero and MUST be ignored.
        self.reserved = flags.readRemainingBits()
    }
}
