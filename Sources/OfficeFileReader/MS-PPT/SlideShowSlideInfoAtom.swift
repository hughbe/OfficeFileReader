//
//  SlideShowSlideInfoAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.6.6 SlideShowSlideInfoAtom
/// Referenced by: MainMasterContainer, SlideContainer
/// An atom record that specifies what transition effect to perform during a slide show, and how to advance to the next presentation slide.
/// Let the corresponding slide be specified by the SlideContainer record (section 2.5.1) that contains this SlideShowSlideInfoAtom record.
public struct SlideShowSlideInfoAtom {
    public let rh: RecordHeader
    public let slideTime: Int32
    public let soundIdRef: SoundIdRef
    public let effectDirection: UInt8
    public let effectType: EffectType
    public let fManualAdvance: Bool
    public let reserved1: Bool
    public let fHidden: Bool
    public let reserved2: Bool
    public let fSound: Bool
    public let reserved3: Bool
    public let fLoopSound: Bool
    public let reserved4: Bool
    public let fStopSound: Bool
    public let reserved5: Bool
    public let fAutoAdvance: Bool
    public let reserved6: Bool
    public let fCursorVisible: Bool
    public let reserved7: UInt8
    public let speed: Speed
    public let unused: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_SlideShowSlideInfoAtom.
        /// rh.recLen MUST be 0x00000010.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .slideShowSlideInfoAtom else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// slideTime (4 bytes): A signed integer that specifies an amount of time, in milliseconds, to wait before advancing to the next presentation
        /// slide. It MUST be greater than or equal to 0 and less than or equal to 86399000. It MUST be ignored unless fAutoAdvance is TRUE.
        let slideTime: Int32 = try dataStream.read(endianess: .littleEndian)
        if slideTime < 0 || slideTime > 86399000 {
            throw OfficeFileError.corrupted
        }
        
        self.slideTime = slideTime
        
        /// soundIdRef (4 bytes): A SoundIdRef that specifies which sound to play when the transition starts.r
        self.soundIdRef = try dataStream.read(endianess: .littleEndian)
        
        /// effectDirection (1 byte): A byte that specifies the variant of effectType. See the effectType field for further restriction and specification of
        /// this field.
        self.effectDirection = try dataStream.read()
        
        /// effectType (1 byte): A byte that specifies which transition is used when transitioning to the next presentation slide during a slide show.
        /// Any of the following samples are for sample purposes only. Exact rendering of any transition is determined by the rendering application.
        /// As such, the same transition can have many variations depending on the implementation.
        let effectTypeRaw: UInt8 = try dataStream.read()
        guard let effectType = EffectType(rawValue: effectTypeRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.effectType = effectType
        
        var flags: BitFieldReader<UInt16> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fManualAdvance (1 bit): A bit that specifies whether the presentation slide can be manually advanced by the user during the slide show.
        self.fManualAdvance = flags.readBit()
        
        /// B - reserved1 (1 bit): MUST be zero and MUST be ignored.
        self.reserved1 = flags.readBit()
        
        /// C - fHidden (1 bit): A bit that specifies whether the corresponding slide is hidden and is not displayed during the slide show.
        self.fHidden = flags.readBit()
        
        /// D - reserved2 (1 bit): MUST be zero and MUST be ignored.
        self.reserved2 = flags.readBit()
        
        /// E - fSound (1 bit): A bit that specifies whether to play the sound specified by soundIfRef.
        self.fSound = flags.readBit()
        
        /// F - reserved3 (1 bit): MUST be zero and MUST be ignored.
        self.reserved3 = flags.readBit()
        
        /// G - fLoopSound (1 bit): A bit that specifies whether the sound specified by soundIdRef is looped continuously when playing until the next
        /// sound plays.
        self.fLoopSound = flags.readBit()
        
        /// H - reserved4 (1 bit): MUST be zero and MUST be ignored.
        self.reserved4 = flags.readBit()
    
        /// I - fStopSound (1 bit): A bit that specifies whether to stop any currently playing sound when the transition starts.
        self.fStopSound = flags.readBit()
        
        /// J - reserved5 (1 bit): MUST be zero and MUST be ignored.
        self.reserved5 = flags.readBit()
        
        /// K - fAutoAdvance (1 bit): A bit that specifies whether the slide will automatically advance after slideTime milliseconds during the slide show.
        self.fAutoAdvance = flags.readBit()
        
        /// L - reserved6 (1 bit): MUST be zero and MUST be ignored.
        self.reserved6 = flags.readBit()
        
        /// M - fCursorVisible (1 bit): A bit that specifies whether to display the cursor during the slide show.
        self.fCursorVisible = flags.readBit()
        
        /// N - reserved7 (3 bits): MUST be zero and MUST be ignored.
        self.reserved7 = UInt8(flags.readRemainingBits())
        
        /// speed (1 byte): A byte value that specifies how long the transition takes to run.
        let speedRaw: UInt8 = try dataStream.read()
        guard let speed = Speed(rawValue: speedRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.speed = speed
        
        /// unused (3 bytes): Undefined and MUST be ignored.
        self.unused = try dataStream.readBytes(count: 3)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
    
    /// effectType (1 byte): A byte that specifies which transition is used when transitioning to the next presentation slide during a slide show.
    /// Any of the following samples are for sample purposes only. Exact rendering of any transition is determined by the rendering application.
    /// As such, the same transition can have many variations depending on the implementation.
    public enum EffectType: UInt8 {
        /// 0 Cut The following specifies the possible effectDirection values and their meanings:
        ///  0x00: The transition is not made through black. (The effect is the same as no transition at all.)
        ///  0x01: The transition is made through black. Sample of through black:
        case cut = 0
        
        /// 1 Random effectDirection MUST be ignored.
        case random = 1
        
        /// 2 Blinds The following specifies the possible effectDirection values and their meanings:
        ///  0x00: Vertical
        ///  0x01: Horizontal
        case blinds = 2
        
        /// 3 Checker The following specifies the possible effectDirection values and their meanings:
        ///  0x00: Horizontal
        ///  0x01: Vertical
        /// Sample of Horizontal:
        case checker = 3
        
        /// 4 Cover The following specifies the possible effectDirection values and their meanings:
        ///  0x00: Left
        ///  0x01: Up
        ///  0x02: Right
        ///  0x03: Down
        ///  0x04: Left Up
        ///  0x05: Right Up
        ///  0x06: Left Down
        ///  0x07: Right Down
        /// Sample of Down:
        case cover = 4
        
        /// 5 Dissolve effectDirection MUST be 0x00.
        case dissolve = 5
        
        /// 6 Fade effectDirection MUST be 0x00.
        case fade = 6
        
        /// 7 Uncover The following specifies the possible effectDirection values and their meanings:
        ///  0x00: Left
        ///  0x01: Up
        ///  0x02: Right
        ///  0x03: Down
        ///  0x04: Left Up
        ///  0x05: Right Up
        ///  0x06: Left Down
        ///  0x07: Right Down
        /// Sample of Down:
        case uncover = 7
        
        /// 8 Random Bars
        /// The following specifies the possible effectDirection values and their meanings:
        ///  0x00: Horizontal
        ///  0x01: Vertical
        /// Sample of Horizontal:
        case randomBars = 8
        
        /// 9 Strips The following specifies the possible effectDirection values and their meanings:
        ///  0x04: Left Up
        ///  0x05: Right Up
        ///  0x06: Left Down
        ///  0x07: Right Down
        /// Sample of Left Down:
        case strips = 9
        
        /// 10 Wipe
        /// The following specifies the possible effectDirection values and their meanings:
        ///  0x00: Left
        ///  0x01: Up
        ///  0x02: Right
        ///  0x03: Down
        /// Sample of Left:
        case wipe = 10
        
        /// 11 Box In/Out
        /// The following specifies the possible effectDirection values and their meanings:
        ///  0x00: Out
        ///  0x01: In
        /// Sample of In:
        case boxInOut = 11
        
        /// 13 Split The following specifies the possible effectDirection values and their meanings:
        ///  0x00: Horizontally out
        ///  0x01: Horizontally in
        ///  0x02: Vertically out
        ///  0x03: Vertically in
        /// Sample of Horizontally In:
        case split = 13
        
        /// 17 Diamond effectDirection MUST be 0x00.
        case diamond = 17
        
        /// 18 Plus effectDirection MUST be 0x00.
        case plus = 18
        
        /// 19 Wedge effectDirection MUST be 0x00.
        case wedge = 19
        
        /// 20 Push The following specifies the possible effectDirection values and their meanings:
        ///  0x00: Left
        ///  0x01: Up
        ///  0x02: Right
        ///  0x03: Down
        /// Sample of Down:
        case push = 20
        
        /// 21 Comb The following specifies the possible effectDirection values and their meanings:
        ///  0x00: Horizontal
        ///  0x01: Vertical
        /// Sample of Horizontal:
        case comb = 21
        
        /// 22 Newsflash effectDirection MUST be 0x00.
        case newsflash = 22
        
        /// 23 AlphaFade effectDirection MUST be 0x00.
        case alphaFade = 23
        
        /// 26 Wheel Sample of 3:
        /// effectDirection values refer to the number of radial divisions used in the effect. The value MUST be one of 0x01, 0x02, 0x03, 0x04, or 0x08.
        case wheel = 26
        
        /// 27 Circle effectDirection MUST be 0x00.
        case circle = 27
        
        /// 255 Undefined and MUST be ignored.
        case undefined = 255
    }
    
    /// speed (1 byte): A byte value that specifies how long the transition takes to run.
    public enum Speed: UInt8 {
        /// 0x00 0.75 seconds
        case pointSevenFiveSeconds = 0x00
        
        /// 0x01 0.5 seconds
        case pointFiveSeconds = 0x01
        
        /// 0x02 0.25 seconds
        case pointTwentyFiveSeconds = 0x02
    }
}
