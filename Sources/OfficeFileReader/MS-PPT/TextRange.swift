//
//  TextRange.swift
//  
//
//  Created by Hugh Bellamy on 13/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.59 TextRange
/// Referenced by: MouseClickTextInteractiveInfoAtom, MouseOverTextInteractiveInfoAtom
/// A structure that specifies a range of text.
/// Let the corresponding text be as specified in the MouseClickTextInteractiveInfoAtom record or the MouseOverTextInteractiveInfoAtom record that contains
/// this TextRange structure.
/// The range specified MUST be valid for the corresponding text. The length of the range of text is specified by the following formula: end - begin
public struct TextRange {
    public let begin: TextPosition
    public let end: TextPosition
    
    public init(dataStream: inout DataStream) throws {
        /// begin (4 bytes): A TextPosition that specifies the first position of the range. It MUST be greater than or equal to zero and MUST be less than or
        /// equal to the length of the corresponding text.
        self.begin = try TextPosition(dataStream: &dataStream)
        
        /// end (4 bytes): A TextPosition that specifies the cutoff position for the range. The character before this position is the last character in the range.
        /// It MUST be greater than begin and MUST be less than or equal to the length of the corresponding text.
        self.end = try TextPosition(dataStream: &dataStream)
        guard self.end.value > self.begin.value else {
            throw OfficeFileError.corrupted
        }
    }
}
