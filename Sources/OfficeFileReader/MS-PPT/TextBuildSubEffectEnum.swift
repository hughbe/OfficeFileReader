//
//  TextBuildSubEffectEnum.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

/// [MS-PPT] 2.13.29 TextBuildSubEffectEnum
/// Referenced by: AnimationInfoAtom
/// An enumeration that specifies behavior types of text in animation effects.
public enum TextBuildSubEffectEnum: UInt8 {
    /// TXB_BuildByNone 0x00 Text is animated all at once.
    case buildByNone = 0x00
    
    /// TXB_BuildByWord 0x01 Text is animated word by word.
    case buildByWord = 0x01
    
    /// TXB_BuildByCharacter 0x02 Text is animated character by character.
    case buildByCharacter = 0x02
}
