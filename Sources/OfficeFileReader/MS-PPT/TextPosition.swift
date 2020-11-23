//
//  TextPosition.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-PPT] 2.2.30 TextPosition
/// Referenced by: DateTimeMCAtom, FooterMCAtom, GenericDateMCAtom, HeaderMCAtom, RTFDateTimeMCAtom, SlideNumberMCAtom,
/// TextBookmarkAtom, TextRange
/// A 4-byte signed integer that specifies a zero-based character position in a range of text. It MUST be greater than or equal to 0x00000000, and MUST be
/// less than the character length of the corresponding text.
public struct TextPosition {
    public let value: Int32
    
    public init(dataStream: inout DataStream) throws {
        self.value = try dataStream.read(endianess: .littleEndian)
        if value < 0x00000000 {
            throw OfficeFileError.corrupted
        }
    }
}
