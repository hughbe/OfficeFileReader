//
//  MSONFC.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

/// [MS-DOC] 2.2.1.3 MSONFC
/// This specifies the list of numbering formats that can be used for a group of automatically numbered objects. The numbering format values
/// are mapped to the ST_NumberFormat ([ECMA-376] partition IV section 2.18.66) enumeration equivalents as described in the following table.
public enum MSONFC: UInt8 {
    /// msonfcArabic 0x00 decimal
    case arabic = 0x00

    /// msonfcUCRoman 0x01 upperRoman
    case ucRoman = 0x01

    /// msonfcLCRoman 0x02 lowerRoman
    case lcRoman = 0x02

    /// msonfcUCLetter 0x03 upperLetter
    case ucLetter = 0x03

    /// msonfcLCLetter 0x04 lowerLetter
    case lcLetter = 0x04

    /// msonfcOrdinal 0x05 ordinal
    case ordinal = 0x05

    /// msonfcCardtext 0x06 cardinalText
    case cardtext = 0x06

    /// msonfcOrdtext 0x07 ordinalText
    case ordtext = 0x07

    /// msonfcHex 0x08 hex
    case hex = 0x08

    /// msonfcChiManSty 0x09 chicago
    case chiManSty = 0x09

    /// msonfcDbNum1 0x0A ideographDigital
    case dbNum1 = 0x0A

    /// msonfcDbNum2 0x0B japaneseCounting
    case dbNum2 = 0x0B

    /// msonfcAiueo 0x0C Aiueo
    case aiueo = 0x0C

    /// msonfcIroha 0x0D Iroha
    case iroha = 0x0D

    /// msonfcDbChar 0x0E decimalFullWidth
    case dbChar = 0x0E

    /// msonfcSbChar 0x0F decimalHalfWidth
    case sbChar = 0x0F

    /// msonfcDbNum3 0x10 japaneseLegal
    case dbNum3 = 0x10

    /// msonfcDbNum4 0x11 japaneseDigitalTenThousand
    case dbNum4 = 0x11

    /// msonfcCirclenum 0x12 decimalEnclosedCircle
    case circlenum = 0x12

    /// msonfcDArabic 0x13 decimalFullWidth2
    case dArabic = 0x13

    /// msonfcDAiueo 0x14 aiueoFullWidth
    case dAiueo = 0x14

    /// msonfcDIroha 0x15 irohaFullWidth
    case dIroha = 0x15

    /// msonfcArabicLZ 0x16 decimalZero
    case arabicLZ = 0x16

    /// msonfcBullet 0x17 bullet
    case bullet = 0x17

    /// msonfcGanada 0x18 ganada
    case ganada = 0x18

    /// msonfcChosung 0x19 chosung
    case chosung = 0x19

    /// msonfcGB1 0x1A decimalEnclosedFullstop
    case gb1 = 0x1A

    /// msonfcGB2 0x1B decimalEnclosedParen
    case gb2 = 0x1B

    /// msonfcGB3 0x1C decimalEnclosedCircleChinese
    case gb3 = 0x1C

    /// msonfcGB4 0x1D ideographEnclosedCircle
    case gb4 = 0x1D

    /// msonfcZodiac1 0x1E ideographTraditional
    case zodiac1 = 0x1E

    /// msonfcZodiac2 0x1F ideographZodiac
    case zodiac2 = 0x1F

    /// msonfcZodiac3 0x20 ideographZodiacTraditional
    case zodiac3 = 0x20

    /// msonfcTpeDbNum1 0x21 taiwaneseCounting
    case tpeDbNum1 = 0x21

    /// msonfcTpeDbNum2 0x22 ideographLegalTraditional
    case tpeDbNum2 = 0x22

    /// msonfcTpeDbNum3 0x23 taiwaneseCountingThousand
    case tpeDbNum3 = 0x23

    /// msonfcTpeDbNum4 0x24 taiwaneseDigital
    case tpeDbNum4 = 0x24

    /// msonfcChnDbNum1 0x25 chineseCounting
    case chnDbNum1 = 0x25

    /// msonfcChnDbNum2 0x26 chineseLegalSimplified
    case chnDbNum2 = 0x26

    /// msonfcChnDbNum3 0x27 chineseCountingThousand
    case chnDbNum3 = 0x27

    /// msonfcChnDbNum4 0x28 decimal
    case chnDbNum4 = 0x28

    /// msonfcKorDbNum1 0x29 koreanDigital
    case korDbNum1 = 0x29

    /// msonfcKorDbNum2 0x2A koreanCounting
    case korDbNum2 = 0x2A

    /// msonfcKorDbNum3 0x2B koreanLegal
    case korDbNum3 = 0x2B

    /// msonfcKorDbNum4 0x2C koreanDigital2
    case korDbNum4 = 0x2C

    /// msonfcHebrew1 0x2D hebrew1
    case hebrew1 = 0x2D

    /// msonfcArabic1 0x2E arabicAlpha
    case arabic1 = 0x2E

    /// msonfcHebrew2 0x2F hebrew2
    case hebrew2 = 0x2F

    /// msonfcArabic2 0x30 arabicAbjad
    case arabic2 = 0x30

    /// msonfcHindi1 0x31 hindiVowels
    case hindi1 = 0x31

    /// msonfcHindi2 0x32 hindiConsonants
    case hindi2 = 0x32

    /// msonfcHindi3 0x33 hindiNumbers
    case hindi3 = 0x33

    /// msonfcHindi4 0x34 hindiCounting
    case hindi4 = 0x34

    /// msonfcThai1 0x35 thaiLetters
    case thai1 = 0x35

    /// msonfcThai2 0x36 thaiNumbers
    case thai2 = 0x36

    /// msonfcThai3 0x37 thaiCounting
    case thai3 = 0x37

    /// msonfcViet1 0x38 vietnameseCounting
    case viet1 = 0x38

    /// msonfcNumInDash 0x39 numberInDash
    case numInDash = 0x39

    /// msonfcLCRus 0x3A russianLower
    case lcRus = 0x3A

    /// msonfcUCRus 0x3B russianUpper
    case ucRus = 0x3B

    /// msonfcNone 0xFF Specifies that the sequence will not display any numbering
    case none = 0xFF
}
