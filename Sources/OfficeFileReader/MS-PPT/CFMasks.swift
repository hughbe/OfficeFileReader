//
//  CFMasks.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.15 CFMasks
/// Referenced by: TextCFException, TextCFException10, TextCFException9
/// A structure that specifies character-level font, text-formatting, and extensibility options.
public struct CFMasks {
    public let bold: Bool
    public let italic: Bool
    public let underline: Bool
    public let unused1: Bool
    public let shadow: Bool
    public let fehint: Bool
    public let unused2: Bool
    public let kumi: Bool
    public let unused3: Bool
    public let emboss: Bool
    public let fHasStyle: UInt8
    public let unused4: UInt8
    public let typeface: Bool
    public let size: Bool
    public let color: Bool
    public let position: Bool
    public let pp10ext: Bool
    public let oldEATypeface: Bool
    public let ansiTypeface: Bool
    public let symbolTypeface: Bool
    public let newEATypeface: Bool
    public let csTypeface: Bool
    public let pp11ext: Bool
    public let reserved: UInt8
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - bold (1 bit): A bit that specifies whether the fontStyle.bold field of the TextCFException structure that contains this CFMasks is valid.
        self.bold = flags.readBit()

        /// B - italic (1 bit): A bit that specifies whether the fontStyle.italic field of the TextCFException structure that contains this CFMasks is valid.
        self.italic = flags.readBit()

        /// C - underline (1 bit): A bit that specifies whether the fontStyle.underline field of the TextCFException structure that contains this CFMasks is valid.
        self.underline = flags.readBit()

        /// D - unused1 (1 bit): Undefined and MUST be ignored.
        self.unused1 = flags.readBit()

        /// E - shadow (1 bit): A bit that specifies whether the fontStyle.shadow field of the TextCFException structure that contains this CFMasks is valid.
        self.shadow = flags.readBit()

        /// F - fehint (1 bit): A bit that specifies whether the fontStyle.fehint field of the TextCFException structure that contains this CFMasks is valid.
        self.fehint = flags.readBit()

        /// G - unused2 (1 bit): Undefined and MUST be ignored.
        self.unused2 = flags.readBit()

        /// H - kumi (1 bit): A bit that specifies whether the fontStyle.kumi field of the TextCFException structure that contains this CFMasks is valid.
        self.kumi = flags.readBit()

        /// I - unused3 (1 bit): Undefined and MUST be ignored.
        self.unused3 = flags.readBit()

        /// J - emboss (1 bit): A bit that specifies whether the fontStyle.emboss field of the TextCFException structure that contains this CFMasks is valid.
        self.emboss = flags.readBit()

        /// K - fHasStyle (4 bits): An unsigned integer that specifies whether the fontStyle field of the TextCFException structure that contains this CFMasks
        /// exists.
        self.fHasStyle = UInt8(flags.readBits(count: 4))

        /// L - unused4 (2 bits): Undefined and MUST be ignored.
        self.unused4 = UInt8(flags.readBits(count: 2))

        /// M - typeface (1 bit): A bit that specifies whether the fontRef field of the TextCFException structure that contains this CFMasks exists.
        self.typeface = flags.readBit()

        /// N - size (1 bit): A bit that specifies whether the fontSize field of the TextCFException structure that contains this CFMasks exists.
        self.size = flags.readBit()

        /// O - color (1 bit): A bit that specifies whether the color field of the TextCFException structure that contains this CFMasks exists.
        self.color = flags.readBit()

        /// P - position (1 bit): A bit that specifies whether the position field of the TextCFException structure that contains this CFMasks exists.
        self.position = flags.readBit()

        /// Q - pp10ext (1 bit): A bit that specifies whether the pp10runid and unused fields of the TextCFException9 structure that contains this CFMasks exist.
        self.pp10ext = flags.readBit()

        /// R - oldEATypeface (1 bit): A bit that specifies whether the oldEAFontRef field of the TextCFException structure that contains this CFMasks exists.
        self.oldEATypeface = flags.readBit()

        /// S - ansiTypeface (1 bit): A bit that specifies whether the ansiFontRef field of the TextCFException structure that contains this CFMasks exists.
        self.ansiTypeface = flags.readBit()

        /// T - symbolTypeface (1 bit): A bit that specifies whether the symbolFontRef field of the TextCFException structure that contains this CFMasks
        /// xists.
        self.symbolTypeface = flags.readBit()

        /// U - newEATypeface (1 bit): A bit that specifies whether the newEAFontRef field of the TextCFException10 structure that contains this CFMasks
        /// exists.
        self.newEATypeface = flags.readBit()

        /// V - csTypeface (1 bit): A bit that specifies whether the csFontRef field of the TextCFException10 structure that contains this CFMasks exists.
        self.csTypeface = flags.readBit()

        /// W - pp11ext (1 bit): A bit that specifies whether the pp11ext field of the TextCFException10 structure that contains this CFMasks exists.
        self.pp11ext = flags.readBit()

        /// reserved (5 bits): MUST be zero and MUST be ignored.
        self.reserved = UInt8(flags.readRemainingBits())
    }
}
