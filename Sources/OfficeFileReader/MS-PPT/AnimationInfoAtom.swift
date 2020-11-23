//
//  AnimationInfoAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.2 AnimationInfoAtom
/// Referenced by: AnimationInfoContainer
/// An atom record that specifies the animation information for a shape or text
public struct AnimationInfoAtom {
    public let rh: RecordHeader
    public let dimColor: ColorIndexStruct
    public let fReverse: UInt8
    public let fAutomatic: UInt8
    public let fSound: UInt8
    public let fStopSound: UInt8
    public let fPlay: UInt8
    public let fSynchronous: UInt8
    public let fHide: UInt8
    public let fAnimateBg: UInt8
    public let reserved: UInt16
    public let soundIdRef: SoundIdRef
    public let delayTime: Int32
    public let orderID: Int16
    public let slideCount: UInt16
    public let animBuildType: AnimBuildTypeEnum
    public let animEffect: AnimEffect
    public let animEffectDuration: UInt8
    public let animAfterEffect: AnimAfterEffectEnum
    public let textBuildSubEffect: TextBuildSubEffectEnum
    public let oleVerb: OLEVerbEnum
    public let unused: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x1.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_AnimationInfoAtom.
        /// rh.recLen MUST be 0x0000001C.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x1 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .animationInfoAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x0000001C else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// dimColor (4 bytes): A ColorIndexStruct structure that specifies a color for the dim effect after the animation is complete.
        self.dimColor = try ColorIndexStruct(dataStream: &dataStream)
        
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fReverse (2 bits): An unsigned integer that specifies whether the animation plays in the reverse direction. It MUST be a value from the
        /// following table.
        /// Value Meaning
        /// 0x0 Do not play in the reverse direction.
        /// 0x1 Play in the reverse direction.
        self.fReverse = UInt8(flags.readBits(count: 2))
        
        /// B - fAutomatic (2 bits): An unsigned integer that specifies whether the animation starts automatically. It MUST be a value from the following
        /// table.
        /// Value Meaning
        /// 0x0 Start manually by click.
        /// 0x1 Start automatically.
        self.fAutomatic = UInt8(flags.readBits(count: 2))
        
        /// C - fSound (2 bits): An unsigned integer that specifies whether the animation has an associated sound. It MUST be a value from the following
        /// table.
        /// Value Meaning
        /// 0x0 Has no associated sound.
        /// 0x1 Has associated sound.
        self.fSound = UInt8(flags.readBits(count: 2))
        
        /// D - fStopSound (2 bits): An unsigned integer that specifies whether all playing sounds are stopped when this animation begins. It MUST be
        /// a value from the following table.
        /// Value Meaning
        /// 0x0 All playing sounds are not stopped.
        /// 0x1 All playing sounds are stopped.
        self.fStopSound = UInt8(flags.readBits(count: 2))
        
        /// E - fPlay (2 bits): An unsigned integer that specifies whether an associated sound, media or action verb is activated when the shape is
        /// clicked. It MUST be a value from the following table.
        /// Value Meaning
        /// 0x0 No behavior happens when the shape is clicked.
        /// 0x1 The associated sound, media or action verb plays when the shape is clicked.
        self.fPlay = UInt8(flags.readBits(count: 2))
        
        /// F - fSynchronous (2 bits): An unsigned integer that specifies that the animation, while playing, stops other slide show actions. If the shape
        /// is a media or OLE object, this field is valid; otherwise, it MUST be ignored. It MUST be a value from the following table.
        /// Value Meaning
        /// 0x0 Do not stop other slide show actions.
        /// 0x1 Stop other slide show actions.
        self.fSynchronous = UInt8(flags.readBits(count: 2))
        
        /// G - fHide (2 bits): An unsigned integer that specifies whether the shape is hidden while the animation is not playing. If the shape is a media
        /// or OLE object, this field is valid; otherwise, it MUST be ignored. It MUST be a value from the following table.
        /// Value Meaning
        /// 0x0 Do not hide the shape while the animation is not playing.
        /// 0x1 Hide the shape while the animation is not playing.
        self.fHide = UInt8(flags.readBits(count: 2))
        
        /// H - fAnimateBg (2 bits): An unsigned integer that specifies whether the background of the shape is animated. It MUST be a value from the
        /// following table.
        /// Value Meaning
        /// 0x0 Do not animate the background.
        /// 0x1 Animate the background.
        self.fAnimateBg = UInt8(flags.readBits(count: 2))
        
        /// reserved (16 bits): MUST be zero, and MUST be ignored.
        self.reserved = UInt16(flags.readRemainingBits())
        
        /// soundIdRef (4 bytes): A SoundIdRef that specifies the value to refer to in the SoundCollectionContainer record (section 2.4.16.1) to locate
        /// the embedded audio.
        self.soundIdRef = try dataStream.read(endianess: .littleEndian)
        
        /// delayTime (4 bytes): A signed integer that specifies the delay time, in milliseconds, before the animation starts to play. If fAutomatic is 0x1,
        /// this value MUST be greater than or equal to 0; otherwise, this field MUST be ignored.
        self.delayTime = try dataStream.read(endianess: .littleEndian)
        
        /// orderID (2 bytes): A signed integer that specifies the order of the animation in the slide. It MUST be greater than or equal to -2. The value
        /// -2 specifies that this animation follows the order of the corresponding placeholder shape on the main master slide or title master slide. The
        /// value -1 SHOULD NOT<104> be used.
        self.orderID = try dataStream.read(endianess: .littleEndian)
        guard self.orderID >= -2 else {
            throw OfficeFileError.corrupted
        }
        
        /// slideCount (2 bytes): An unsigned integer that specifies the number of slides that this animation continues playing. This field is utilized only
        /// in conjunction with media. The value 0xFFFFFFFF specifies that the animation plays for one slide.
        self.slideCount = try dataStream.read(endianess: .littleEndian)
        
        /// animBuildType (1 byte): An AnimBuildTypeEnum enumeration that specifies the animation build type for the animation effect.
        guard let animBuildType = AnimBuildTypeEnum(rawValue: try dataStream.read()) else {
            throw OfficeFileError.corrupted
        }
        
        self.animBuildType = animBuildType
        
        /// animEffect (1 byte): An unsigned integer that specifies the animation effect type for the shape. The following diagrams are for example
        /// purposes only. Exact rendering of any animation effect is determined by the rendering application. As such, the same animation effect
        /// can have many variations depending on the implementation. It MUST be a value from the following table:
        guard let animEffect = AnimEffect(rawValue: try dataStream.read()) else {
            throw OfficeFileError.corrupted
        }
        
        self.animEffect = animEffect
        
        /// animEffectDirection (1 byte): An unsigned integer that specifies the direction of the animation effect. It MUST be a value as specified by
        /// the animEffect field.
        self.animEffectDuration = try dataStream.read(endianess: .littleEndian)
        
        /// animAfterEffect (1 byte): An AnimAfterEffectEnum enumeration that specifies the behavior of the shape or text after the animation effect is
        /// finished.
        guard let animAfterEffect = AnimAfterEffectEnum(rawValue: try dataStream.read()) else {
            throw OfficeFileError.corrupted
        }
        
        self.animAfterEffect = animAfterEffect
        
        /// textBuildSubEffect (1 byte): A TextBuildSubEffectEnum enumeration that specifies the behavior of text in the animation effect.
        guard let textBuildSubEffect = TextBuildSubEffectEnum(rawValue: try dataStream.read()) else {
            throw OfficeFileError.corrupted
        }
        
        self.textBuildSubEffect = textBuildSubEffect
        
        /// oleVerb (1 byte): An OLEVerbEnum enumeration that SHOULD<105> specify the OLE verb associated with this shape.
        guard let oleVerb = OLEVerbEnum(rawValue: try dataStream.read()) else {
            throw OfficeFileError.corrupted
        }
        
        self.oleVerb = oleVerb
        
        /// unused (2 bytes): Undefined and MUST be ignored.
        self.unused = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
    
    /// animEffect (1 byte): An unsigned integer that specifies the animation effect type for the shape. The following diagrams are for example purposes
    /// only. Exact rendering of any animation effect is determined by the rendering application. As such, the same animation effect can have many
    /// variations depending on the implementation. It MUST be a value from the following table:
    public enum AnimEffect: UInt8 {
        /// 0x00 Cut animation effect that replaces the previous object instance with the new object instance instantaneously, as illustrated in the
        /// following example:
        /// The animEffectDirection value MUST be one of the following:
        ///  0x00: Not through black
        ///  0x01: Through black
        ///  0x02: The same as 0x00
        case cut = 0x00
        
        /// 0x01 Random animation effect that chooses a random effect with a random applicable direction from the set available. This effect can be
        /// different each time it is used. animEffectDirection MUST be ignored.
        case random = 0x01
        
        /// 0x02 Blinds animation effect that uses a set of horizontal or vertical bars and wipes them either left-to-right or top-to-bottom, respectively,
        /// until the new object instance is fully shown, as illustrated in the following example:
        /// The animEffectDirection value MUST be one of the following:
        ///  0x00: Vertical direction
        ///  0x01: Horizontal direction
        case blinds = 0x02
        
        /// 0x03 Checker animation effect that uses a set of horizontal or vertical checkerboard squares and wipes them either left-to-right or
        /// top-to-bottom, respectively, until the new object instance is fully shown, as illustrated in the following example:
        /// The animEffectDirection value MUST be one of the following:
        ///  0x00: Horizontal direction
        ///  0x01: Vertical direction
        case checker = 0x03
        
        /// 0x04 Cover animation effect that moves the new object instance in from the specified direction, continually covering more of the previous
        /// object instance until the new object instance is fully shown, as illustrated in the following example:
        /// The animEffectDirection value MUST be one of the following:
        ///  0x00: Cover from the right to the left side of the object.
        ///  0x01: Cover from the bottom to the top side of the object.
        ///  0x02: Cover from the left to the right side of the object.
        ///  0x03: Cover from the top to the bottom side of the object.
        ///  0x04: Cover from the bottom-right to the top-left corner of the object.
        ///  0x05: Cover from the bottom-left to the top-right corner of the object.
        ///  0x06: Cover from the top-right to the bottom-left corner of the object.
        ///  0x07: Cover from the top-left to the bottom-right corner of the object.
        case cover = 0x04
        
        /// 0x05 Dissolve animation effect that uses a set of randomly placed squares on the object instance that continue to be added to until the
        /// new object instance is fully shown, as illustrated in the following example:
        /// animEffectDirection MUST be 0x00.
        case dissolve = 0x05
        
        /// 0x06 Fade animation effect that smoothly fades the previous object instance either directly
        /// to the new object instance or first to a black screen and then to the new object instance, as illustrated in the following example:
        /// animEffectDirection MUST be 0x00.
        case fade = 0x06
        
        /// 0x07 Pull animation effect that moves the previous object instance out from the specified direction, continually revealing more of the new
        /// object instance until the new object instance is fully shown, as illustrated in the following example:
        /// The animEffectDirection value MUST be one of the following:
        ///  0x00: Reveal from the right to the left side of the object.
        ///  0x01: Reveal from the bottom to the top side of the object.
        ///  0x02: Reveal from the left to the right side of the object.
        ///  0x03: Reveal from the top to the bottom side of the object.
        ///  0x04: Reveal from the bottom-right to the top-left corner of the object.
        ///  0x05: Reveal from the bottom-left to the top-right corner of the object.
        ///  0x06: Reveal from the top-right to the bottom-left corner of the object.
        ///  0x07: Reveal from the top-left to the bottom-right corner of the object.
        case pull = 0x07
        
        /// 0x08 Random bar animation effect that uses a set of randomly placed horizontal or vertical bars on the object instance that continue to be
        /// added to until the new object instance is fully shown, as illustrated in the following example:
        /// The animEffectDirection value MUST be one of the following:
        ///  0x00: Horizontal direction
        ///  0x01: Vertical direction
        case randomBar = 0x08
        
        /// 0x09 Strips animation effect that uses a set of bars that are arranged in a staggered fashion and wipes them across the screen until the
        /// new object instance is fully shown, as illustrated in the following example:
        /// The animEffectDirection value MUST be one of the following:
        ///  0x04: Strips move from the bottom-right to the top-left corner of the object.
        ///  0x05: Strips move from the bottom-left to the top-right corner of the object.
        ///  0x06: Strips move from the top-right to the bottom-left corner of the object.
        ///  0x07: Strips move from the top-left to the bottom-right corner of the object.
        case strips = 0x09
        
        /// 0x0A Wipe animation effect that wipes the new object instance over the previous object instance from one edge of the screen to the
        /// opposite until the new object instance is fully shown, as illustrated in the following example:
        /// The animEffectDirection value MUST be one of the following:
        ///  0x00: Wipe effect is from the right to the left side of the object.
        ///  0x01: Wipe effect is from the bottom to the top side of the object.
        ///  0x02: Wipe effect is from the left to the right side of the object.
        ///  0x03: Wipe effect is from the top to the bottom side of the object.
        case wipe = 0x0A
        
        /// 0x0B Zoom animation effect that uses a box pattern centered on the object instance that increases or decreases in size until the new
        /// object instance is fully shown, as illustrated in the following example:
        /// The animEffectDirection value MUST be one of the following:
        ///  0x00: Outward direction
        ///  0x01: Inward direction
        case zoom = 0x0B
        
        /// 0x0C Fly animation effect that moves the new object instance in from the specified direction to the object’s on-screen location, as
        /// illustrated in the following example:
        /// The animEffectDirection value MUST be one of the following:
        ///  0x00: Fly from the left side of the presentation slide.
        ///  0x01: Fly from the top side of the presentation slide.
        ///  0x02: Fly from the right side of the presentation slide.
        ///  0x03: Fly from the bottom side of the presentation slide.
        ///  0x04: Fly from the top-left corner of the presentation slide.
        ///  0x05: Fly from the top-right corner of the presentation slide.
        ///  0x06: Fly from the bottom-left corner of the presentation slide.
        ///  0x07: Fly from the bottom-right corner of the presentation slide.
        ///  0x08: Fly from the left edge of the shape or text.
        ///  0x09: Fly from the bottom edge of the shape or text.
        ///  0x0A: Fly from the right edge of the shape or text.
        ///  0x0B: Fly from the top edge of the shape or text.
        ///  0x0C: Crawl from the left side of the presentation slide.
        ///  0x0D: Crawl from the top side of the presentation slide.
        ///  0x0E: Crawl from the right side of the presentation slide.
        ///  0x0F: Crawl from the bottom side of the presentation slide.
        ///  0x10: The shape or text zooms in from zero size to its full size, and its center keeps unchanged.
        ///  0x11: The shape or text zooms in from half of its size to its full size, and its center remains unchanged.
        ///  0x12: The shape or text zooms out from 4 times its size to its full size, and its center remains unchanged.
        ///  0x13: The shape or text zooms out from 1.5 times its size to its full size, and its center remains unchanged.
        ///  0x14: The shape or text zooms in from zero size to its full size, and its center moves from the screen center to its actual center.
        ///  0x15: The shape or text zooms out from 4 times its size to its full size, and it moves from the bottom side of the screen to its actua
        ///  position.
        ///  0x16: The shape or text stretches from its center to both left and right.
        ///  0x17: The shape or text stretches from its left side to its right side.
        ///  0x18: The shape or text stretches from its top side to its bottom side.
        ///  0x19: The shape or text stretches from its right side to its left side.
        ///  0x1A: The shape or text stretches from its bottom side to its top side.
        ///  0x1B: The shape or text rotates around the vertical axis that passes through its center.
        ///  0x1C: The shape or text flies in a spiral.
        case fly = 0x0C
        
        /// 0x0D Split animation that reveals the new object instance directly on top of the previous one by wiping either horizontally or vertically from
        /// the outside in, or from the inside out, until the new object instance is fully shown, as illustrated in the following example:
        /// The animEffectDirection value MUST be one of the following:
        ///  0x00: The split animation plays horizontally from the middle to both the top and bottom of the shape or text.
        ///  0x01: The split animation plays horizontally from the top and bottom to the middle of the shape or text.
        ///  0x02: The split animation plays vertically from the middle to both the left and right of the shape or text.
        ///  0x03: The split animation plays vertically from the left and right to the middle of the shape or text.
        case split = 0x0D
        
        /// 0x0E Flash animation effect that displays the new object instance for a period of time and then hides the object from view, as illustrated in
        /// the following example: animEffectDirection specifies the time when the flash takes place. The following table is for description purposes
        /// only. Exact time when the flash takes place is determined by the application.
        /// The animEffectDirection value MUST be one of the following:
        ///  0x00: Flash takes place after a short time.
        ///  0x01: Flash takes place after a medium time.
        ///  0x02: Flash takes place after a long time.
        case flash = 0x0E
        
        /// 0x11 Diamond animation effect that uses a diamond pattern centered on the object instance that increases in size until the new object
        /// instance is fully shown, as illustrated in the following example:
        /// animEffectDirection MUST be 0x00.
        case diamond = 0x11
        
        /// 0x12 Plus animation effect that uses a plus pattern centered on the object instance that increases in size until the new object instance is
        /// fully shown, as illustrated in the following example:
        /// animEffectDirection MUST be 0x00.
        case plus = 0x012
        
        /// 0x13 Wedge animation effect that uses two radial edges that wipe from top to bottom in opposite directions until the new object instance
        /// is fully shown, as illustrated in the following example:
        /// animEffectDirection MUST be 0x00.
        case wedge = 0x13
        
        /// 0x1A Wheel animation effect that uses a set of radial edges and wipes them in the clockwise direction until the new object instance is fully
        /// shown, as illustrated in the following example:
        /// The animEffectDirection value MUST be one of the following:
        ///  0x01: Use 1 spoke.
        ///  0x02: Use 2 spokes.
        ///  0x03: Use 3 spokes.
        ///  0x04: Use 4 spokes.
        ///  0x08: Use 8 spokes.
        case wheel = 0x1A
        
        /// 0x1B Circle animation effect that uses a circle pattern centered on the object instance that increases in size until the new object instance is
        /// fully shown, as illustrated in the following example:
        /// animEffectDirection MUST be 0x00.
        case circle = 0x1B
    }
}
