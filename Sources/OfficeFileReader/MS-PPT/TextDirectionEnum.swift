//
//  TextDirectionEnum.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

/// [MS-PPT] 2.13.30 TextDirectionEnum
/// Referenced by: TextPFException
/// An enumeration that specifies the direction of a paragraph of text.
public enum TextDirectionEnum: UInt16 {
    /// LeftToRight 0x0000 Left to right text flow.
    case leftToRight = 0x0000

    /// RightToLeft 0x0001 Right to left text flow.
    case rightToLeft = 0x0001
}
