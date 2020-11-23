//
//  TimeEffectID.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.23 TimeEffectID
/// Referenced by: TimeVariant4TimeNode
/// An atom record that specifies the identifier of an animation effect.
/// Let the corresponding time node be as specified in the TimePropertyList4TimeNodeContainer record (section 2.8.18) that contains this TimeEffectID
/// record.
/// Let the corresponding effect type be specified by the TimeEffectType record contained in the TimePropertyList4TimeNodeContainer record that
/// contains this TimeEffectID record.
/// Let the corresponding effect direction be specified by the intValue field of the TimeVariantInt record contained in the
/// TimePropertyList4TimeNodeContainer record such that the rh.recInstance field of the TimeVariantInt record is equal to TL_TPID_EffectDir.
public struct TimeEffectID {
    public let rh: RecordHeader
    public let type: TimeVariantTypeEnum
    public let effectID: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recType MUST be RT_TimeVariant.
        /// rh.recLen MUST be 0x00000005.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .timeVariant else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000005 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// type (1 byte): A TimeVariantTypeEnum enumeration that specifies the data type of this record. It MUST be TL_TVT_Int.
        guard let type = TimeVariantTypeEnum(rawValue: try dataStream.read()) else {
            throw OfficeFileError.corrupted
        }
        guard type == .int else {
            throw OfficeFileError.corrupted
        }
        
        self.type = type
        
        /// effectID (4 bytes): A signed integer that specifies the identifier of the animation effect of the corresponding time node.
        self.effectID = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }

    /// effectID (4 bytes): A signed integer that specifies the identifier of the animation effect of the corresponding time node.
    /// When the corresponding effect type is an entrance or an exit effect, this field MUST be a value from the following table:
    public enum EntranceOrExitEffectID: Int32 {
        /// 0x00000000 Custom. The corresponding effect direction MUST be ignored.
        case custom = 0x00000000

        /// 0x00000001 Appear. The corresponding effect direction MUST be ignored.
        case appear = 0x00000001

        /// 0x00000002 Fly in. The corresponding effect direction MUST be one of the following values:
        ///  0x00000002: Right
        ///  0x00000008: Left
        ///  0x00000001: Top
        ///  0x00000004: Bottom
        ///  0x00000009: Top left
        ///  0x00000003: Top right
        ///  0x00000006: Bottom right
        ///  0x0000000C: Bottom left
        case flyIn = 0x00000002

        /// 0x00000003 Blinds. The corresponding effect direction MUST be one of the following values:
        ///  0x0000000A: Horizontal
        ///  0x00000005: Vertical
        case blinds = 0x00000003

        /// 0x00000004 Box. The corresponding effect direction MUST be one of the following values:
        ///  0x00000010: In
        ///  0x00000020: Out
        case box = 0x00000004

        /// 0x00000005 Check board. The corresponding effect direction MUST be one of the following values:
        ///  0x00000005: Vertical
        ///  0x0000000A: Across
        case checkBoard = 0x00000005

        /// 0x00000006 Circle. The corresponding effect direction MUST be one of the following values:
        ///  0x00000010: In
        ///  0x00000020: Out
        case circle = 0x00000006

        /// 0x00000007 Crawl. The corresponding effect direction MUST be one of the following values:
        ///  0x00000002: Right
        ///  0x00000008: Left
        ///  0x00000001: Top
        ///  0x00000004: Bottom
        ///  0x00000009: Top left
        ///  0x00000003: Top right
        ///  0x00000006: Bottom right
        ///  0x0000000C: Bottom left
        case crawl = 0x00000007
        
        /// 0x00000008 Diamond. The corresponding effect direction MUST be one of the following values:
        ///  0x00000010: In
        ///  0x00000020: Out
        case diamond = 0x00000008
        
        /// 0x00000009 Dissolve. The corresponding effect direction MUST be ignored.
        case dissolve = 0x00000009
        
        /// 0x0000000A Fade. The corresponding effect direction MUST be ignored.
        case fade = 0x0000000A
        
        /// 0x0000000B Flash once. The corresponding effect direction MUST be ignored.
        case flashOnce = 0x0000000B
        
        /// 0x0000000C Peek. The corresponding effect direction MUST be one of the following values:
        ///  0x00000002: Right
        ///  0x00000008: Left
        ///  0x00000001: Top
        ///  0x00000004: Bottom
        case peek = 0x0000000C
        
        /// 0x0000000D Plus. The corresponding effect direction MUST be one of the following values:
        ///  0x00000010: In
        ///  0x00000020: Out
        case plus = 0x0000000D
        
        /// 0x0000000E Random bars. The corresponding effect direction MUST be one of the following values:
        ///  0x0000000A: Horizontal
        ///  0x00000005: Vertical
        case randomBars = 0x0000000E
        
        /// 0x0000000F Spiral The corresponding effect direction MUST be ignored.
        case spiral = 0x0000000F
        
        /// 0x00000010 Split. The corresponding effect direction MUST be one of the following values:
        ///  0x0000001A: Horizontal in
        ///  0x0000002A: Horizontal out
        ///  0x00000015: Vertical in
        ///  0x00000025: Vertical out
        case split = 0x00000010
        
        /// 0x00000011 Stretch. The corresponding effect direction MUST be one of the following values:
        ///  0x00000002: Right
        ///  0x00000008: Left
        ///  0x00000001: Top
        ///  0x00000004: Bottom
        ///  0x0000000A: Across
        case stretch = 0x00000011
        
        /// 0x00000012 Strips. The corresponding effect direction MUST be one of the following values:
        ///  0x00000009: Up left
        ///  0x00000003: Up right
        ///  0x00000006: Down right
        ///  0x0000000C: Down left
        case strips = 0x00000012
        
        /// 0x00000013 Swivel. The corresponding effect direction MUST be one of the following values:
        ///  0x0000000A: Horizontal
        ///  0x00000005: Vertical
        case swivel = 0x00000013
        
        /// 0x00000014 Wedge. The corresponding effect direction MUST be ignored.
        case wedge = 0x00000014
        
        /// 0x00000015 Wheel. The corresponding effect direction MUST be one of the following values:
        ///  0x00000001: Wheel(1)
        ///  0x00000002: Wheel(2)
        ///  0x00000003: Wheel(3)
        ///  0x00000004: Wheel(4)
        ///  0x00000008: Wheel(8)
        case wheel = 0x00000015
        
        /// 0x00000016 Wipe.
        /// The corresponding effect direction MUST be one of the following values:
        ///  0x00000001: Up
        ///  0x00000002: Right
        ///  0x00000004: Down
        ///  0x00000008: Left
        case wipe = 0x00000016
        
        /// 0x00000017 Zoom. The corresponding effect direction MUST be one of the following values:
        ///  0x00000010: In
        ///  0x00000020: Out
        ///  0x00000210: In center
        ///  0x00000024: Out bottom
        ///  0x00000120: Out slightly
        ///  0x00000110: In slightly
        case zoom = 0x00000017
        
        /// 0x00000018 Random effects. The corresponding effect direction MUST be ignored.
        case random = 0x00000018
        
        /// 0x00000019 Boomerang. The corresponding effect direction MUST be ignored.
        case boomerang = 0x00000019
        
        /// 0x0000001A Bounce. The corresponding effect direction MUST be ignored.
        case bounce = 0x0000001A
        
        /// 0x0000001B Color reveal. The corresponding effect direction MUST be ignored.
        case colorReveal = 0x0000001B
        
        /// 0x0000001C Credits. The corresponding effect direction MUST be ignored.
        case credits = 0x0000001C
        
        /// 0x0000001D Ease in. The corresponding effect direction MUST be ignored.
        case easeIn = 0x0000001D
        
        /// 0x0000001E Float. The corresponding effect direction MUST be ignored.
        case float = 0x0000001E
        
        /// 0x0000001F Grow and turn. The corresponding effect direction MUST be ignored.
        case growAndTurn = 0x0000001F
        
        /// 0x00000020 Reserved.
        case reserved1 = 0x00000020
        
        /// 0x00000021 Reserved.
        case reserved2 = 0x00000021
        
        /// 0x00000022 Light speed. The corresponding effect direction MUST be ignored.
        case lightSpeed = 0x00000022
        
        /// 0x00000023 Pin wheel. The corresponding effect direction MUST be ignored.
        case pinWheel = 0x00000023
        
        /// 0x00000024 Reserved.
        case reserved3 = 0x00000024
        
        /// 0x00000025 Rise up. The corresponding effect direction MUST be ignored.
        case riseUp = 0x00000025
        
        /// 0x00000026 Swish. The corresponding effect direction MUST be ignored.
        case swish = 0x00000026
        
        /// 0x00000027 Thin line. The corresponding effect direction MUST be ignored.
        case thinLine = 0x00000027
        
        /// 0x00000028 Unfold. The corresponding effect direction MUST be ignored.
        case unfold = 0x00000028
        
        /// 0x00000029 Whip. The corresponding effect direction MUST be ignored.
        case whip = 0x00000029
        
        /// 0x0000002A Ascend. The corresponding effect direction MUST be ignored.
        case ascend = 0x0000002A

        /// 0x0000002B Center revolve. The corresponding effect direction MUST be ignored.
        case centerRevolve = 0x0000002B

        /// 0x0000002C Reserved.
        case reserved4 = 0x0000002C

        /// 0x0000002D Faded swivel. The corresponding effect direction MUST be ignored.
        case fadedSwivel = 0x0000002D

        /// 0x0000002E Reserved.
        case reserved5 = 0x0000002E
        
        /// 0x0000002F Descend. The corresponding effect direction MUST be ignored.
        case descend = 0x0000002F

        /// 0x00000030 Sling. The corresponding effect direction MUST be ignored.
        case sling = 0x00000030

        /// 0x00000031 Spinner. The corresponding effect direction MUST be ignored.
        case spinner = 0x00000031

        /// 0x00000032 Compress. The corresponding effect direction MUST be ignored.
        case compress = 0x00000032

        /// 0x00000033 Zip. The corresponding effect direction MUST be ignored.
        case zip = 0x00000033

        /// 0x00000034 Arc up. The corresponding effect direction MUST be ignored.
        case arcUp = 0x00000034

        /// 0x00000035 Faded zoom. The corresponding effect direction MUST be ignored.
        case fadedZoom = 0x00000035

        /// 0x00000036 Glide. The corresponding effect direction MUST be ignored.
        case glide = 0x00000036

        /// 0x00000037 Expand. The corresponding effect direction MUST be ignored.
        case expand = 0x00000037
        
        /// 0x00000038 Flip. The corresponding effect direction MUST be ignored.
        case flip = 0x00000038

        /// 0x00000039 Reserved.
        case reserved = 0x00000039

        /// 0x0000003A Fold. The corresponding effect direction MUST be ignored.
        case fold = 0x0000003A
    }
    
    /// effectID (4 bytes): A signed integer that specifies the identifier of the animation effect of the corresponding time node.
    /// When the corresponding effect type is an emphasis effect, this field MUST be a value from the following table:
    public enum EnteranceOrExitEffectID: Int32 {
        /// 0x00000000 Custom. The corresponding effect direction MUST be ignored.
        case custom = 0x00000000
        
        /// 0x00000001 Change fill color. The corresponding effect direction MUST be one of the following values:
        ///  0x00000001: Instant
        ///  0x00000002: Gradual
        ///  0x00000006: Gradual and cycle clockwise
        ///  0x0000000A: Gradual and cycle counterclockwise
        case changeFillColor = 0x00000001
        
        /// 0x00000002 Change font. The corresponding effect direction MUST be ignored.
        case changeFont = 0x00000002
        
        /// 0x00000003 Change font color. The corresponding effect direction MUST be one of the following values:
        ///  0x00000001: Instant
        ///  0x00000001: Gradual
        ///  0x00000006: Gradual and cycle clockwise
        ///  0x0000000A: Gradual and cycle counterclockwise
        
        /// 0x00000004 Change font size. The corresponding effect direction MUST be one of the following values:
        ///  0x00000001: Instant
        ///  0x00000002: Gradual
        case changeFontSize = 0x00000004
        
        /// 0x00000005 Change font style. The corresponding effect direction MUST be a value of any combination of the following values:
        ///  0x00000001: Font bold
        ///  0x00000002: Font italic
        ///  0x00000004: Font underline
        case changeFontStyle = 0x00000005
        
        /// 0x00000006 Grow and shrink. The corresponding effect direction MUST be ignored.
        case growAndShrink = 0x00000006
        
        /// 0x00000007 Change line color. The corresponding effect direction MUST be one of the following values:
        ///  0x00000001: Instant
        ///  0x00000002: Gradual
        ///  0x00000006: Gradual and cycle clockwise
        ///  0x0000000A: Gradual and cycle counterclockwise
        case changeLineColor = 0x00000007
        
        /// 0x00000008 Spin. The corresponding effect direction MUST be ignored.
        case spin = 0x00000008
        
        /// 0x00000009 Transparency. The corresponding effect direction MUST be ignored.
        case transparency = 0x00000009
        
        /// 0x0000000A Bold flash. The corresponding effect direction MUST be ignored.
        case boldFlash = 0x0000000A
        
        /// 0x0000000B Reserved.
        case reserved1 = 0x0000000B
        
        /// 0x0000000C Reserved.
        case reserved2 = 0x0000000C
        
        /// 0x0000000D Reserved.
        case reserved3 = 0x0000000D
        
        /// 0x0000000E Blast. The corresponding effect direction MUST be ignored.
        case blast = 0x0000000E
        
        /// 0x0000000F Bold reveal. The corresponding effect direction MUST be ignored.
        case boldReveal = 0x0000000F
        
        /// 0x00000010 Brush on color. The corresponding effect direction MUST be ignored.
        case brushOnColor = 0x00000010
        
        /// 0x00000011 Reserved.
        case reserved4 = 0x00000011
        
        /// 0x00000012 Brush on underline. The corresponding effect direction MUST be ignored.
        case brushOnUnderline = 0x00000012
        
        /// 0x00000013 Color blend. The corresponding effect direction MUST be ignored.
        case colorBlend = 0x00000013
        
        /// 0x00000014 Color wave. The corresponding effect direction MUST be ignored.
        case colorWave = 0x00000014
        
        /// 0x00000015 Complementary color. The corresponding effect direction MUST be ignored.
        case complementaryColor = 0x00000015
        
        /// 0x00000016 Complementary color 2. The corresponding effect direction MUST be ignored.
        case complementaryColor2 = 0x00000016
        
        /// 0x00000017 Contrasting color. The corresponding effect direction MUST be ignored.
        case contrastingColor = 0x00000017
        
        /// 0x00000018 Darken. The corresponding effect direction MUST be ignored.
        case darken = 0x00000018
        
        /// 0x00000019 Desaturate. The corresponding effect direction MUST be ignored.
        case desaturate = 0x00000019
        
        /// 0x0000001A Flash bulb. The corresponding effect direction MUST be ignored.
        case flashBulb = 0x0000001A
        
        /// 0x0000001B Flicker. The corresponding effect direction MUST be ignored.
        case flicker = 0x0000001B
        
        /// 0x0000001C Grow with color. The corresponding effect direction MUST be ignored.
        case growWithColor = 0x0000001C
        
        /// 0x0000001D Reserved.
        case reserved5 = 0x0000001D
        
        /// 0x0000001E Lighten. The corresponding effect direction MUST be ignored.
        case lighten = 0x0000001E
        
        /// 0x0000001F Style emphasis. The corresponding effect direction MUST be ignored.
        case styleEmphasis = 0x0000001F
        
        /// 0x00000020 Teeter. The corresponding effect direction MUST be ignored.
        case teeter = 0x00000020
        
        /// 0x00000021 Vertical grow. The corresponding effect direction MUST be ignored.
        case verticalGrow = 0x00000021
        
        /// 0x00000022 Wave. The corresponding effect direction MUST be ignored.
        case wave = 0x00000022
        
        /// 0x00000023 Blink. The corresponding effect direction MUST be ignored.
        case blink = 0x00000023
        
        /// 0x00000024 Shimmer. The corresponding effect direction MUST be ignored.
        case shimmer = 0x00000024
    }
    
    /// effectID (4 bytes): A signed integer that specifies the identifier of the animation effect of the corresponding time node.
    /// When the corresponding effect type is a motion path effect, the corresponding effect direction MUST be ignored and this field MUST be a
    /// value from the following table:
    public enum MotionPathEffectID: Int32 {
        /// 0x00000000 Custom.
        case custom = 0x00000000

        /// 0x00000001 Circle.
        case circle = 0x00000001

        /// 0x00000002 Right triangle.
        case rightTriangle = 0x00000002

        /// 0x00000003 Diamond.
        case diamond = 0x00000003

        /// 0x00000004 Hexagon.
        case hexagon = 0x00000004

        /// 0x00000005 5-point star.
        case fivePointStart = 0x00000005

        /// 0x00000006 Crescent moon.
        case crescentMoon = 0x00000006

        /// 0x00000007 Square.
        case square = 0x00000007

        /// 0x00000008 Trapezoid.
        case trapezoid = 0x00000008

        /// 0x00000009 Heart.
        case heart = 0x00000009

        /// 0x0000000A Octagon.
        case octagon = 0x0000000A

        /// 0x0000000B 6-point star.
        case sixPointStar = 0x0000000B

        /// 0x0000000C Football.
        case football = 0x0000000C

        /// 0x0000000D Equal triangle.
        case equalTriangle = 0x0000000D

        /// 0x0000000E Parallelogram.
        case parallelogram = 0x0000000E

        /// 0x0000000F Pentagon.
        case pentagon = 0x0000000F

        /// 0x00000010 4-point star.
        case fourPointStar = 0x00000010

        /// 0x00000011 8-point star.
        case eightPointStar = 0x00000011

        /// 0x00000012 Teardrop.
        case teardrop = 0x00000012

        /// 0x00000013 Pointy star.
        case pointyStar = 0x00000013

        /// 0x00000014 Curved square.
        case curvedSquare = 0x00000014

        /// 0x00000015 Curved X.
        case curvedX = 0x00000015

        /// 0x00000016 Vertical figure 8.
        case verticalFigureEight = 0x00000016

        /// 0x00000017 Curvy star.
        case curvyStar = 0x00000017

        /// 0x00000018 Loop de loop.
        case loopDeLoop = 0x00000018

        /// 0x00000019 Buzz saw.
        case buzzSaw = 0x00000019

        /// 0x0000001A Horizontal figure 8.
        case horizontalFigureEight = 0x0000001A

        /// 0x0000001B Peanut.
        case peanut = 0x0000001B

        /// 0x0000001C Figure 8 four.
        case figureEightFour = 0x0000001C

        /// 0x0000001D Neutron.
        case neutron = 0x0000001D

        /// 0x0000001E Swoosh.
        case swoosh = 0x0000001E

        /// 0x0000001F Bean.
        case bean = 0x0000001F

        /// 0x00000020 Plus.
        case plus = 0x00000020

        /// 0x00000021 Inverted triangle.
        case invertedTriangle = 0x00000021

        /// 0x00000022 Inverted square.
        case invertedSquare = 0x00000022

        /// 0x00000023 Left.
        case left = 0x00000023

        /// 0x00000024 Turn right.
        case turnRight = 0x00000024

        /// 0x00000025 Arc down.
        case arcDown = 0x00000025

        /// 0x00000026 Zigzag.
        case zigzag = 0x00000026

        /// 0x00000027 S curve 2.
        case sCurve2 = 0x00000027

        /// 0x00000028 Sine wave.
        case sineWave = 0x00000028

        /// 0x00000029 Bounce left.
        case bounceLeft = 0x00000029

        /// 0x0000002A Down.
        case down = 0x0000002A

        /// 0x0000002B Turn up.
        case turnUp = 0x0000002B

        /// 0x0000002C Arc up.
        case arcUp = 0x0000002C

        /// 0x0000002D Heartbeat.
        case heartbeat = 0x0000002D

        /// 0x0000002E Spiral right.
        case spiralRight = 0x0000002E

        /// 0x0000002F Wave.
        case wave = 0x0000002F

        /// 0x00000030 Curvy left.
        case curvyLeft = 0x00000030

        /// 0x00000031 Diagonal down right.
        case diagonalDownRight = 0x00000031

        /// 0x00000032 Turn down.
        case turnDown = 0x00000032

        /// 0x00000033 Arc left.
        case arcLeft = 0x00000033

        /// 0x00000034 Funnel.
        case funnel = 0x00000034

        /// 0x00000035 Spring.
        case spring = 0x00000035

        /// 0x00000036 Bounce right.
        case bounceRight = 0x00000036

        /// 0x00000037 Spiral left.
        case spiralLeft = 0x00000037

        /// 0x00000038 Diagonal up right.
        case diagonalUpRight = 0x00000038

        /// 0x00000039 Turn up right.
        case turnUpRight = 0x00000039

        /// 0x0000003A Arc right.
        case arcRight = 0x0000003A

        /// 0x0000003B S curve 1.
        case sCurve1 = 0x0000003B

        /// 0x0000003C Decaying wave.
        case decayingWave = 0x0000003C

        /// 0x0000003D Curvy right.
        case curvyRigth = 0x0000003D

        /// 0x0000003E Stairs down.
        case stairsDown = 0x0000003E

        /// 0x0000003F Right.
        case right = 0x0000003F

        /// 0x00000040 Up.
        case up = 0x00000040
    }
    
    /// effectID (4 bytes): A signed integer that specifies the identifier of the animation effect of the corresponding time node.
    /// When the corresponding effect type is a media effect, the corresponding effect direction MUST be ignored and this field MUST be a value
    /// from the following table:
    public enum MediaEffectID: Int32 {
        /// 0x00000000 Custom.
        case custom = 0x00000000
        
        /// 0x00000001 Play.
        case play = 0x00000001
        
        /// 0x00000002 Pause.
        case pause = 0x00000002
        
        /// 0x00000003 Stop.
        case stop = 0x00000003
    }
}
