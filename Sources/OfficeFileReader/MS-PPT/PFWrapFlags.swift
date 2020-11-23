//
//  PFWrapFlags.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.25 PFWrapFlags
/// Referenced by: TextPFException
/// A structure that specifies line breaking settings for a paragraph.
public struct PFWrapFlags {
    public let charWrap: Bool
    public let wordWrap: Bool
    public let overflow: Bool
    public let reserved: UInt16
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - charWrap (1 bit): A bit that specifies whether the paragraph follows the East Asian text line breaking settings specified by the
        /// KinsokuContainer (section 2.9.2) and Kinsoku9Container (section 2.9.6) records.
        self.charWrap = flags.readBit()
        
        /// B - wordWrap (1 bit): A bit that specifies whether text wraps from one line to the next only at word breaks, or in the middle of a word. It MUST
        /// be a value from the following table.
        /// Value Meaning
        /// TRUE Text wraps at word breaks. All of the characters of a word exist on the same line.
        /// FALSE Text wraps at character breaks. Characters of a word can be split across lines.
        self.wordWrap = flags.readBit()
        
        /// C - overflow (1 bit): A bit that specifies whether hanging punctuation is allowed for East Asian text.
        self.overflow = flags.readBit()
        
        /// reserved (13 bits): MUST be zero and MUST be ignored.
        self.reserved = flags.readRemainingBits()
    }
}
