//
//  BrcType.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

/// [MS-DOC] 2.9.22 BrcType
/// brcType (8 bits): An unsigned integer that specifies the type of border. Values that are larger than 0x1B are not valid unless they describe a page border,
/// in which case they can be a value in the range of 0x40 to 0xE3, inclusive.
/// Values MUST be from the following table. The reference column specifies for each brcType value the ST_Border enumeration value in [ECMA-376]
/// part 4, section 2.18.4, that further specifies the meaning of the border type.
public enum BrcType: UInt8 {
    /// 0x00 No border. none
    case none = 0x00

    /// 0x01 A single line. single
    case single = 0x01

    /// 0x03 A double line. double
    case double = 0x03

    /// 0x05 A thin single solid line.
    case line = 0x05

    /// 0x06 A dotted border. dotted
    case dotted = 0x06

    /// 0x07 A dashed border with large gaps between the dashes. dashed
    case dashed = 0x07

    /// 0x08 A border of alternating dots and dashes. dotDash
    case dotDash = 0x08

    /// 0x09 A border of alternating sets of two dots and one dash. dotDotDash
    case dotDotDash = 0x09

    /// 0x0A A triple line border. triple
    case triple = 0x0A

    /// 0x0B A thin outer border and a thick inner border with a small gap between them. thinThickSmallGap
    case thinThickSmallGap = 0x0B

    /// 0x0C A thin outer border and thick inner border with a small gap between them. thickThinSmallGap
    case thickThinSmallGap = 0x0C

    /// 0x0D A thin outer border, a thick middle border, and a thin inner border with a small gap between them. thinThickThinSmallGap
    case thinThickThinSmallGap = 0x0D

    /// 0x0E A thin outer border and a thick inner border with a medium gap between them. thinThickMediumGap
    case thinThickMediumGap = 0x0E

    /// 0x0F A thin outer border and a thick inner border and a medium gap between them. thickThinMediumGap
    case thickThinMediumGap = 0x0F

    /// 0x10 A thin outer border, a thick middle border, and a thin inner border with a medium gaps between them. thinThickThinMediumGap
    case thinThickThinMediumGap = 0x10

    /// 0x11 A thick outer border and a thin inner border with a large gap between them. thinThickLargeGap
    case thinThickLargeGap = 0x11

    /// 0x12 A thin outer border and a thick inner border with a large gap between them. thickThinLargeGap
    case thickThinLargeGap = 0x12

    /// 0x13 A thin outer border, a thick middle border, and a thin inner border with large gaps between them. thinThickThinLargeGap
    case thinThickThinLargeGap = 0x13

    /// 0x14 A single wavy line. wave
    case wave = 0x14

    /// 0x15 A double wavy line. doubleWave
    case doubleWave = 0x15

    /// 0x16 A dashed border with small gaps between the dashes. dashSmallGap
    case dashSmallGap = 0x16

    /// 0x17 A border consisting of alternating groups of 5 and 1 thin diagonal lines. dashDotStroked
    case dashDotStroked = 0x17

    /// 0x18 A thin light gray outer border, a thick medium gray middle border, and a thin black inner border with no gaps between them. threeDEmboss
    case threeDEmboss = 0x18

    /// 0x19 A thin black outer border, a thick medium gray middle border, and a thin light gray inner border with no gaps between them. threeDEngrave
    case threeDEngrave = 0x19

    /// 0x1A A thin light gray outer border and a thin medium gray inner border with a large gap between them. outset 
    case outset  = 0x1A

    /// 0x1B A thin medium gray outer border and a thin light gray inner border with a large gap between them. inst
    case inst = 0x1B

    /// 0x40 An image border. apples
    case apples = 0x40

    /// 0x41 An image border. archedScallops
    case archedScallops = 0x41

    /// 0x42 An image border. babyPacifier
    case babyPacifier = 0x42

    /// 0x43 An image border. babyRattle
    case babyRattle = 0x43

    /// 0x44 An image border. balloons3Colors
    case balloons3Colors = 0x44

    /// 0x45 An image border. balloonsHotAir
    case balloonsHotAir = 0x45

    /// 0x46 An image border. basicBlackDashes
    case basicBlackDashes = 0x46

    /// 0x47 An image border. basicBlackDots
    case basicBlackDots = 0x47

    /// 0x48 An image border. basicBlackSquares
    case basicBlackSquares = 0x48

    /// 0x49 An image border. basicThinLines
    case basicThinLines = 0x49

    /// 0x4A An image border. basicWhiteDashes
    case basicWhiteDashes = 0x4A

    /// 0x4B An image border. basicWhiteDots
    case basicWhiteDots = 0x4B

    /// 0x4C An image border. basicWhiteSquares
    case basicWhiteSquares = 0x4C

    /// 0x4D An image border. basicWideInline
    case basicWideInline = 0x4D

    /// 0x4E An image border. basicWideMidline
    case basicWideMidline = 0x4E

    /// 0x4F An image border. basicWideOutline
    case basicWideOutline = 0x4F

    /// 0x50 An image border. bats
    case bats = 0x50

    /// 0x51 An image border. birds
    case birds = 0x51

    /// 0x52 An image border. birdsFlight
    case birdsFlight = 0x52

    /// 0x53 An image border. cabins
    case cabins = 0x53

    /// 0x54 An image border. cakeSlice
    case cakeSlice = 0x54

    /// 0x55 An image border. candyCorn
    case candyCorn = 0x55

    /// 0x56 An image border. celticKnotwork
    case celticKnotwork = 0x56

    /// 0x57 An image border. certificateBanner
    case certificateBanner = 0x57

    /// 0x58 An image border. chainLink
    case chainLink = 0x58

    /// 0x59 An image border. champagneBottle
    case champagneBottle = 0x59

    /// 0x5A An image border. checkedBarBlack
    case checkedBarBlack = 0x5A

    /// 0x5B An image border. checkedBarColor
    case checkedBarColor = 0x5B

    /// 0x5C An image border. checkered
    case checkered = 0x5C

    /// 0x5D An image border. christmasTree
    case christmasTree = 0x5D

    /// 0x5E An image border. circlesLines
    case circlesLines = 0x5E

    /// 0x5F An image border. circlesRectangles
    case circlesRectangles = 0x5F

    /// 0x60 An image border. classicalWave
    case classicalWave = 0x60

    /// 0x61 An image border. clocks
    case clocks = 0x61

    /// 0x62 An image border. compass
    case compass = 0x62

    /// 0x63 An image border. confetti
    case confetti = 0x63

    /// 0x64 An image border. confettiGrays
    case confettiGrays = 0x64

    /// 0x65 An image border. confettiOutline
    case confettiOutline = 0x65

    /// 0x66 An image border. confettiStreamers
    case confettiStreamers = 0x66

    /// 0x67 An image border. confettiWhite
    case confettiWhite = 0x67

    /// 0x68 An image border. cornerTriangles
    case cornerTriangles = 0x68

    /// 0x69 An image border. couponCutoutDashes
    case couponCutoutDashes = 0x69

    /// 0x6A An image border. couponCutoutDots
    case couponCutoutDots = 0x6A

    /// 0x6B An image border. crazyMaze
    case crazyMaze = 0x6B

    /// 0x6C An image border. creaturesButterfly
    case creaturesButterfly = 0x6C

    /// 0x6D An image border. creaturesFish
    case creaturesFish = 0x6D

    /// 0x6E An image border. creaturesInsects
    case creaturesInsects = 0x6E

    /// 0x6F An image border. creaturesLadyBug
    case creaturesLadyBug = 0x6F

    /// 0x70 An image border. crossStitch
    case crossStitch = 0x70

    /// 0x71 An image border. cup
    case cup = 0x71

    /// 0x72 An image border. decoArch
    case decoArch = 0x72

    /// 0x73 An image border. decoArchColor
    case decoArchColor = 0x73

    /// 0x74 An image border. decoBlocks
    case decoBlocks = 0x74

    /// 0x75 An image border. diamondsGray
    case diamondsGray = 0x75

    /// 0x76 An image border. doubleD
    case doubleD = 0x76

    /// 0x77 An image border. doubleDiamonds
    case doubleDiamonds = 0x77

    /// 0x78 An image border. earth1
    case earth1 = 0x78

    /// 0x79 An image border. earth2
    case earth2 = 0x79

    /// 0x7A An image border. eclipsingSquares1
    case eclipsingSquares1 = 0x7A

    /// 0x7B An image border. eclipsingSquares2
    case eclipsingSquares2 = 0x7B

    /// 0x7C An image border. eggsBlack
    case eggsBlack = 0x7C

    /// 0x7D An image border. fans 
    case fans  = 0x7D

    /// 0x7E An image border. film
    case film = 0x7E

    /// 0x7F An image border. firecrackers
    case firecrackers = 0x7F

    /// 0x80 An image border. flowersBlockPrint
    case flowersBlockPrint = 0x80

    /// 0x81 An image border. flowersDaisies
    case flowersDaisies = 0x81

    /// 0x82 An image border. flowersModern1
    case flowersModern1 = 0x82

    /// 0x83 An image border. flowersModern2
    case flowersModern2 = 0x83

    /// 0x84 An image border. flowersPansy
    case flowersPansy = 0x84

    /// 0x85 An image border. flowersRedRose
    case flowersRedRose = 0x85

    /// 0x86 An image border. flowersRoses
    case flowersRoses = 0x86

    /// 0x87 An image border. flowersTeacup
    case flowersTeacup = 0x87

    /// 0x88 An image border. flowersTiny
    case flowersTiny = 0x88

    /// 0x89 An image border. gems
    case gems = 0x89

    /// 0x8A An image border. gingerbreadMan
    case gingerbreadMan = 0x8A

    /// 0x8B An image border. gradient
    case gradient = 0x8B

    /// 0x8C An image border. handmade1
    case handmade1 = 0x8C

    /// 0x8D An image border. handmade2
    case handmade2 = 0x8D

    /// 0x8E An image border. heartBalloon
    case heartBalloon = 0x8E

    /// 0x8F An image border. heartGray
    case heartGray = 0x8F

    /// 0x90 An image border. hearts
    case hearts = 0x90

    /// 0x91 An image border. heebieJeebies
    case heebieJeebies = 0x91

    /// 0x92 An image border. holly
    case holly = 0x92

    /// 0x93 An image border. houseFunky
    case houseFunky = 0x93

    /// 0x94 An image border. hypnotic
    case hypnotic = 0x94

    /// 0x95 An image border. iceCreamCones
    case iceCreamCones = 0x95

    /// 0x96 An image border. lightBulb
    case lightBulb = 0x96

    /// 0x97 An image border. lightning1
    case lightning1 = 0x97

    /// 0x98 An image border. lightning2
    case lightning2 = 0x98

    /// 0x99 An image border. mapPins
    case mapPins = 0x99

    /// 0x9A An image border. mapleLeaf
    case mapleLeaf = 0x9A

    /// 0x9B An image border. mapleMuffins
    case mapleMuffins = 0x9B

    /// 0x9C An image border. marquee
    case marquee = 0x9C

    /// 0x9D An image border. marqueeToothed 
    case marqueeToothed  = 0x9D

    /// 0x9E An image border. moons
    case moons = 0x9E

    /// 0x9F An image border. mosaic
    case mosaic = 0x9F

    /// 0xA0 An image border. musicNotes
    case musicNotes = 0xA0

    /// 0xA1 An image border. northwest
    case northwest = 0xA1

    /// 0xA2 An image border. ovals
    case ovals = 0xA2

    /// 0xA3 An image border. packages
    case packages = 0xA3

    /// 0xA4 An image border. palmsBlack
    case palmsBlack = 0xA4

    /// 0xA5 An image border. palmsColor
    case palmsColor = 0xA5

    /// 0xA6 An image border. paperClips
    case paperClips = 0xA6

    /// 0xA7 An image border. papyrus
    case papyrus = 0xA7

    /// 0xA8 An image border. partyFavor
    case partyFavor = 0xA8

    /// 0xA9 An image border. partyGlass
    case partyGlass = 0xA9

    /// 0xAA An image border. pencils
    case pencils = 0xAA

    /// 0xAB An image border. people
    case people = 0xAB

    /// 0xAC An image border. peopleWaving
    case peopleWaving = 0xAC

    /// 0xAD An image border. peopleHats
    case peopleHats = 0xAD

    /// 0xAE An image border. poinsettias
    case poinsettias = 0xAE

    /// 0xAF An image border. postageStamp
    case postageStamp = 0xAF

    /// 0xB0 An image border. pumpkin1
    case pumpkin1 = 0xB0

    /// 0xB1 An image border. pushPinNote2
    case pushPinNote2 = 0xB1

    /// 0xB2 An image border. pushPinNote1
    case pushPinNote1 = 0xB2

    /// 0xB3 An image border. pyramids
    case pyramids = 0xB3

    /// 0xB4 An image border. pyramidsAbove
    case pyramidsAbove = 0xB4

    /// 0xB5 An image border. quadrants
    case quadrants = 0xB5

    /// 0xB6 An image border. rings
    case rings = 0xB6

    /// 0xB7 An image border. safari
    case safari = 0xB7

    /// 0xB8 An image border. sawtooth
    case sawtooth = 0xB8

    /// 0xB9 An image border. sawtoothGray
    case sawtoothGray = 0xB9

    /// 0xBA An image border. scaredCat
    case scaredCat = 0xBA

    /// 0xBB An image border. seattle
    case seattle = 0xBB

    /// 0xBC An image border. shadowedSquares
    case shadowedSquares = 0xBC

    /// 0xBD An image border. sharksTeeth 
    case sharksTeeth  = 0xBD

    /// 0xBE An image border. shorebirdTracks
    case shorebirdTracks = 0xBE

    /// 0xBF An image border. skyrocket
    case skyrocket = 0xBF

    /// 0xC0 An image border. snowflakeFancy
    case snowflakeFancy = 0xC0

    /// 0xC1 An image border. snowflakes
    case snowflakes = 0xC1

    /// 0xC2 An image border. sombrero
    case sombrero = 0xC2

    /// 0xC3 An image border. southwest
    case southwest = 0xC3

    /// 0xC4 An image border. stars
    case stars = 0xC4

    /// 0xC5 An image border. starsTop
    case starsTop = 0xC5

    /// 0xC6 An image border. stars3d
    case stars3d = 0xC6

    /// 0xC7 An image border. starsBlack
    case starsBlack = 0xC7

    /// 0xC8 An image border. starsShadowed
    case starsShadowed = 0xC8

    /// 0xC9 An image border. sun
    case sun = 0xC9

    /// 0xCA An image border. swirligig
    case swirligig = 0xCA

    /// 0xCB An image border. tornPaper
    case tornPaper = 0xCB

    /// 0xCC An image border. tornPaperBlack
    case tornPaperBlack = 0xCC

    /// 0xCD An image border. trees
    case trees = 0xCD

    /// 0xCE An image border. triangleParty
    case triangleParty = 0xCE

    /// 0xCF An image border. triangles
    case triangles = 0xCF

    /// 0xD0 An image border. tribal1
    case tribal1 = 0xD0

    /// 0xD1 An image border. tribal2
    case tribal2 = 0xD1

    /// 0xD2 An image border. tribal3
    case tribal3 = 0xD2

    /// 0xD3 An image border. tribal4
    case tribal4 = 0xD3

    /// 0xD4 An image border. tribal5
    case tribal5 = 0xD4

    /// 0xD5 An image border. tribal6
    case tribal6 = 0xD5

    /// 0xD6 An image border. twistedLines1
    case twistedLines1 = 0xD6

    /// 0xD7 An image border. twistedLines2
    case twistedLines2 = 0xD7

    /// 0xD8 An image border. vine
    case vine = 0xD8

    /// 0xD9 An image border. waveline
    case waveline = 0xD9

    /// 0xDA An image border. weavingAngles
    case weavingAngles = 0xDA

    /// 0xDB An image border. weavingBraid
    case weavingBraid = 0xDB

    /// 0xDC An image border. weavingRibbon
    case weavingRibbon = 0xDC

    /// 0xDD An image border. weavingStrips 
    case weavingStrips  = 0xDD

    /// 0xDE An image border. whiteFlowers
    case whiteFlowers = 0xDE

    /// 0xDF An image border. woodwork
    case woodwork = 0xDF

    /// 0xE0 An image border. xIllusions
    case xIllusions = 0xE0

    /// 0xE1 An image border. zanyTriangles
    case zanyTriangles = 0xE1

    /// 0xE2 An image border. zigZag
    case zigZag = 0xE2

    /// 0xE3 An image border. zigZagStitch
    case zigZagStitch = 0xE3

    /// 0xFF This MUST be ignored.
    case ignored = 0xFF
}
