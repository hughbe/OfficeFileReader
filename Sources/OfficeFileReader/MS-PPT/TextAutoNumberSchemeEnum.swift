//
//  TextAutoNumberSchemeEnum.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

/// [MS-PPT] 2.13.28 TextAutoNumberSchemeEnum
/// Referenced by: TextAutoNumberScheme
/// An enumeration that specifies the character sequence and delimiters to use for automatic numbering.
public enum TextAutoNumberSchemeEnum: UInt16 {
    /// ANM_AlphaLcPeriod 0x0000 Lowercase Latin character followed by a period. Example: a., b., c., …
    case alphaLcPeriod = 0x0000

    /// ANM_AlphaUcPeriod 0x0001 Uppercase Latin character followed by a period. Example: A., B., C., …
    case alphaUcPeriod = 0x0001

    /// ANM_ArabicParenRight 0x0002 Arabic numeral followed by a closing parenthesis. Example: 1), 2), 3), …
    case arabicParenRight = 0x0002

    /// ANM_ArabicPeriod 0x0003 Arabic numeral followed by a period. Example: 1., 2., 3., …
    case arabicPeriod = 0x0003

    /// ANM_RomanLcParenBoth 0x0004 Lowercase Roman numeral enclosed in parentheses. Example: (i), (ii), (iii), …
    case romanLcParenBoth = 0x0004

    /// ANM_RomanLcParenRight 0x0005 Lowercase Roman numeral followed by a closing parenthesis. Example: i), ii), iii), …
    case romanLcParenRight = 0x0005

    /// ANM_RomanLcPeriod 0x0006 Lowercase Roman numeral followed by a period. Example: i., ii., iii., …
    case romaLcPeriod = 0x0006

    /// ANM_RomanUcPeriod 0x0007 Uppercase Roman numeral followed by a period. Example: I., II., III., …
    case romanUcPeriod = 0x0007

    /// ANM_AlphaLcParenBoth 0x0008 Lowercase alphabetic character enclosed in parentheses. Example: (a), (b), (c), …
    case alphaLcParentBoth = 0x0008

    /// ANM_AlphaLcParenRight 0x0009 Lowercase alphabetic character followed by a closing parenthesis. Example: a), b), c), …
    case alphaLcParenRight = 0x0009

    /// ANM_AlphaUcParenBoth 0x000A Uppercase alphabetic character enclosed in parentheses. Example: (A), (B), (C), …
    case alphaUcParenBoth = 0x000A

    /// ANM_AlphaUcParenRight 0x000B Uppercase alphabetic character followed by a closing parenthesis. Example: A), B), C), …
    case alphaUcParenRight = 0x000B

    /// ANM_ArabicParenBoth 0x000C Arabic numeral enclosed in parentheses. Example: (1), (2), (3), …
    case arabicParenBoth = 0x000C

    /// ANM_ArabicPlain 0x000D Arabic numeral. Example: 1, 2, 3, …
    case arabicPlain = 0x000D

    /// ANM_RomanUcParenBoth 0x000E Uppercase Roman numeral enclosed in parentheses. Example: (I), (II), (III), …
    case romanUcParenBoth = 0x000E

    /// ANM_RomanUcParenRight 0x000F Uppercase Roman numeral followed by a closing parenthesis. Example: I), II), III), …
    case romanUcParenRight = 0x000F

    /// ANM_ChsPlain 0x0010 Simplified Chinese.
    case chsPlain = 0x0010

    /// ANM_ChsPeriod 0x0011 Simplified Chinese with single-byte period.
    case chsPeriod = 0x0011

    /// ANM_CircleNumDBPlain 0x0012 Double byte circle numbers.
    case circleNumDBPlain = 0x0012

    /// ANM_CircleNumWDBWhitePlain 0x0013 Wingdings white circle numbers.
    case circleNumWDBWhitePlain = 0x0013

    /// ANM_CircleNumWDBBlackPlain 0x0014 Wingdings black circle numbers.
    case circleNumWDBBlackPlain = 0x0014

    /// ANM_ChtPlain 0x0015 Traditional Chinese.
    case chtPlain = 0x0015

    /// ANM_ChtPeriod 0x0016 Traditional Chinese with single-byte period.
    case chtPeriod = 0x0016

    /// ANM_Arabic1Minus 0x0017 Bidi Arabic 1 (AraAlpha) with ANSI minus symbol.
    case arabic1Minus = 0x0017

    /// ANM_Arabic2Minus 0x0018 Bidi Arabic 2 (AraAbjad) with ANSI minus symbol.
    case arabic2Minus = 0x0018

    /// ANM_Hebrew2Minus 0x0019 Bidi Hebrew 2 with ANSI minus symbol.
    case hebrew2Minus = 0x0019

    /// ANM_JpnKorPlain 0x001A Japanese/Korean.
    case jpnKorPlain = 0x001A

    /// ANM_JpnKorPeriod 0x001B Japanese/Korean with single-byte period.
    case jpnKorPeriod = 0x001B

    /// ANM_ArabicDbPlain 0x001C Double-byte Arabic numbers.
    case arabicDbPlain = 0x001C

    /// ANM_ArabicDbPeriod 0x001D Double-byte Arabic numbers with double-byte period.
    case arabicDbPeriod = 0x001D

    /// ANM_ThaiAlphaPeriod 0x001E Thai alphabetic character followed by a period.
    case thaiAlphaPeriod = 0x001E

    /// ANM_ThaiAlphaParenRight 0x001F Thai alphabetic character followed by a closing parenthesis.
    case thaiAlphaParenRight = 0x001F

    /// ANM_ThaiAlphaParenBoth 0x0020 Thai alphabetic character enclosed by parentheses.
    case thaiAlphaParenBoth = 0x0020

    /// ANM_ThaiNumPeriod 0x0021 Thai numeral followed by a period.
    case thaiNumPeriod = 0x0021

    /// ANM_ThaiNumParenRight 0x0022 Thai numeral followed by a closing parenthesis.
    case thaiNumParenRight = 0x0022

    /// ANM_ThaiNumParenBoth 0x0023 Thai numeral enclosed in parentheses.
    case thaiNumParenBoth = 0x0023

    /// ANM_HindiAlphaPeriod 0x0024 Hindi alphabetic character followed by a period.
    case hindiAlphaPeriod = 0x0024

    /// ANM_HindiNumPeriod 0x0025 Hindi numeric character followed by a period.
    case hindiNumPeriod = 0x0025

    /// ANM_JpnChsDBPeriod 0x0026 Japanese with double-byte period.
    case jpnChsDBPeriod = 0x0026

    /// ANM_HindiNumParenRight 0x0027 Hindi numeric character followed by a closing parenthesis.
    case hindiNumParenRight = 0x0027

    /// ANM_HindiAlpha1Period 0x0028 Hindi alphabetic character followed by a period.
    case hindiAlpha1Period = 0x0028
}
