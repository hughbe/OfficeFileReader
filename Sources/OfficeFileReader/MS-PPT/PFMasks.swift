//
//  PFMasks.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.21 PFMasks
/// Referenced by: TextPFException, TextPFException9
/// A structure that specifies which paragraph-level formatting fields are valid in the TextPFException or TextPFException9 record that contains this PFMasks
/// structure.
public struct PFMasks {
    public let hasBullet: Bool
    public let bulletHasFont: Bool
    public let bulletHasColor: Bool
    public let bulletHasSize: Bool
    public let bulletFont: Bool
    public let bulletColor: Bool
    public let bulletSize: Bool
    public let bulletChar: Bool
    public let leftMargin: Bool
    public let unused: Bool
    public let indent: Bool
    public let align: Bool
    public let lineSpacing: Bool
    public let spaceBefore: Bool
    public let spaceAfter: Bool
    public let defaultTabSize: Bool
    public let fontAlign: Bool
    public let charWrap: Bool
    public let wordWrap: Bool
    public let overflow: Bool
    public let tabStops: Bool
    public let textDirection: Bool
    public let reserved1: Bool
    public let bulletBlip: Bool
    public let bulletScheme: Bool
    public let bulletHasScheme: Bool
    public let reserved2: UInt8
    
    public init(dataStream: inout DataStream) throws {
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - hasBullet (1 bit): A bit that specifies whether the bulletFlags field of the TextPFException structure that contains this PFMasks exists and
        /// whether bulletFlags.fHasBullet is valid.
        self.hasBullet = flags.readBit()

        /// B - bulletHasFont (1 bit): A bit that specifies whether the bulletFlags field of the TextPFException structure that contains this PFMasks exists and
        /// whether bulletFlags.fBulletHasFont is valid.
        self.bulletHasFont = flags.readBit()

        /// C - bulletHasColor (1 bit): A bit that specifies whether the bulletFlags field of the TextPFException structure that contains this PFMasks exists and
        /// whether bulletFlags.fBulletHasColor is valid.
        self.bulletHasColor = flags.readBit()

        /// D - bulletHasSize (1 bit): A bit that specifies whether the bulletFlags field of the TextPFException structure that contains this PFMasks exists and
        /// whether bulletFlags.fBulletHasSize is valid.
        self.bulletHasSize = flags.readBit()

        /// E - bulletFont (1 bit): A bit that specifies whether the bulletFontRef field of the TextPFException structure that contains this PFMasks exists.
        self.bulletFont = flags.readBit()

        /// F - bulletColor (1 bit): A bit that specifies whether the bulletColor field of the TextPFException structure that contains this PFMasks exists.
        self.bulletColor = flags.readBit()

        /// G - bulletSize (1 bit): A bit that specifies whether the bulletSize field of the TextPFException structure that contains this PFMasks exists.
        self.bulletSize = flags.readBit()

        /// H - bulletChar (1 bit): A bit that specifies whether the bulletChar field of the TextPFException structure that contains this PFMasks exists.
        self.bulletChar = flags.readBit()

        /// I - leftMargin (1 bit): A bit that specifies whether the leftMargin field of the TextPFException structure that contains this PFMasks exists.
        self.leftMargin = flags.readBit()

        /// J - unused (1 bit): Undefined and MUST be ignored.
        self.unused = flags.readBit()

        /// K - indent (1 bit): A bit that specifies whether the indent field of the TextPFException structure that contains this PFMasks exists.
        self.indent = flags.readBit()

        /// L - align (1 bit): A bit that specifies whether the textAlignment field of the TextPFException structure that contains this PFMasks exists.
        self.align = flags.readBit()

        /// M - lineSpacing (1 bit): A bit that specifies whether the lineSpacing field of the TextPFException structure that contains this PFMasks exists.
        self.lineSpacing = flags.readBit()

        /// N - spaceBefore (1 bit): A bit that specifies whether the spaceBefore field of the TextPFException that contains this PFMasks exists.
        self.spaceBefore = flags.readBit()

        /// O - spaceAfter (1 bit): A bit that specifies whether the spaceAfter field of the TextPFException structure that contains this PFMasks exists.
        self.spaceAfter = flags.readBit()

        /// P - defaultTabSize (1 bit): A bit that specifies whether the defaultTabSize field of the TextPFException structure that contains this PFMasks exists.
        self.defaultTabSize = flags.readBit()

        /// Q - fontAlign (1 bit): A bit that specifies whether the fontAlign field of the TextPFException structure that contains this PFMasks exists.
        self.fontAlign = flags.readBit()

        /// R - charWrap (1 bit): A bit that specifies whether the wrapFlags field of the TextPFException structure that contains this PFMasks exists and
        /// whether wrapFlags.charWrap is valid.
        self.charWrap = flags.readBit()

        /// S - wordWrap (1 bit): A bit that specifies whether the wrapFlags field of the TextPFException structure that contains this PFMasks exists and
        /// whether wrapFlags.wordWrap is valid.
        self.wordWrap = flags.readBit()

        /// T - overflow (1 bit): A bit that specifies whether the wrapFlags field of the TextPFException structure that contains this PFMasks exists and whether
        /// wrapFlags.overflow is valid.
        self.overflow = flags.readBit()

        /// U - tabStops (1 bit): A bit that specifies whether the tabStops field of the TextPFException structure that contains this PFMasks exists.
        self.tabStops = flags.readBit()

        /// V - textDirection (1 bit): A bit that specifies whether the textDirection field of the TextPFException structure that contains this PFMasks exists.
        self.textDirection = flags.readBit()

        /// W - reserved1 (1 bit): MUST be zero and MUST be ignored.
        self.reserved1 = flags.readBit()

        /// X - bulletBlip (1 bit): A bit that specifies whether the bulletBlipRef field of the TextPFException9 structure that contains this PFMasks exists.
        self.bulletBlip = flags.readBit()

        /// Y - bulletScheme (1 bit): A bit that specifies whether the bulletAutoNumberScheme field of the TextPFException9 structure that contains this
        /// PFMasks exists.
        self.bulletScheme = flags.readBit()

        /// Z - bulletHasScheme (1 bit): A bit that specifies whether the fBulletHasAutoNumber field of the TextPFException9 structure that contains this
        /// PFMasks exists.
        self.bulletHasScheme = flags.readBit()

        /// reserved2 (6 bits): MUST be zero and MUST be ignored.
        self.reserved2 = UInt8(flags.readRemainingBits())
    }
}
