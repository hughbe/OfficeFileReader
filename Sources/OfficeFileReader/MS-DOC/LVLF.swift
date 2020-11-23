//
//  LVLF.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.150 LVLF
/// The LVLF structure contains formatting properties for an individual level in a list.
public struct LVLF {
    public let iStartAt: Int32
    public let nfc: MSONFC
    public let jc: Jusitification
    public let fLegal: Bool
    public let fNoRestart: Bool
    public let fIndentSav: Bool
    public let fConverted: Bool
    public let unused1: Bool
    public let fTentative: Bool
    public let rgbxchNums: (UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8)
    public let ixchFollow: CharacterFollow
    public let dxaIndentSav: Int32
    public let unused2: UInt32
    public let cbGrpprlChpx: UInt8
    public let cbGrpprlPapx: UInt8
    public let ilvlRestartLim: UInt8
    public let grfhic: grfhic
    
    public init(dataStream: inout DataStream) throws {
        /// iStartAt (4 bytes): A signed integer that specifies the beginning number for the number sequence belonging to this level. This value MUST be
        /// less than or equal to 0x7FFF and MUST be greater than or equal to zero. If this level does not have a number sequence (see nfc), this MUST
        /// be ignored.
        let iStartAt: Int32 = try dataStream.read(endianess: .littleEndian)
        if iStartAt < 0 || iStartAt > 0x7FFF {
            throw OfficeFileError.corrupted
        }
        
        self.iStartAt = iStartAt
        
        /// nfc (1 byte): An MSONFC, as specified in [MS-OSHARED] section 2.2.1.3, that specifies the format of the level numbers that replace the
        /// placeholders for this level in the xst fields of the LVLs in this list. This value MUST NOT be equal to 0x08, 0x09, 0x0F, or 0x13. If this is equal
        /// to 0xFF or 0x17, this level does not have a number sequence and therefore has no number formatting. If this is equal to 0x17, the level uses bullets.
        let nfcRaw: UInt8 = try dataStream.read()
        guard let nfc = MSONFC(rawValue: nfcRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.nfc = nfc
        
        var flags: BitFieldReader<UInt8> = try dataStream.readBits(endianess: .littleEndian)
        
        /// jc (2 bits): An unsigned integer that specifies the justification of this level. This MUST be one of the following values.
        let jcRaw = UInt8(flags.readBits(count: 2))
        guard let jc = Jusitification(rawValue: jcRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.jc = jc
        
        /// A - fLegal (1 bit): A bit that specifies whether this level overrides the nfc of all inherited level numbers. If the original nfc of a level number is
        /// msonfcArabicLZ, it is preserved. Otherwise, the nfc of the level number is overridden by msonfcArabic.
        self.fLegal = flags.readBit()
        
        /// B - fNoRestart (1 bit): A bit that specifies whether the number sequence of the level does not restart after a level is encountered that is more
        /// significant than the level to which this LVLF corresponds. If this is nonzero, ilvlRestartLim specifies the levels after which the number
        /// sequence of this level restarts. Otherwise, this number sequence of this level restarts when a more significant level is encountered. If this level
        /// does not have a number sequence (see nfc), this MUST be ignored.
        self.fNoRestart = flags.readBit()
        
        /// C - fIndentSav (1 bit): A bit that specifies whether the level indented the text it was applied to and that the indent needs to be removed when
        /// numbering is removed. The indent to be removed is stored in dxaIndentSav.
        self.fIndentSav = flags.readBit()
        
        /// D - fConverted (1 bit): A bit that specifies whether the nfc of this LVLF structure was previously a temporary value used for bidirectional
        ///  compatibility that was converted into a standard MSONFC, as specified in [MS-OSHARED] section 2.2.1.3.
        self.fConverted = flags.readBit()
        
        /// E - unused1 (1 bit): This bit MUST be ignored.
        self.unused1 = flags.readBit()
        
        /// F - fTentative (1 bit): A bit that specifies whether the format of the level is tentative. This is used to describe the levels of a hybrid list that are
        /// not in use or displayed. If the fHybrid bit of the LSTF of the list is zero, this MUST be ignored.
        self.fTentative = flags.readBit()
        
        /// rgbxchNums (9 bytes): An array of 8-bit integers. Each integer specifies a one-based character offset to a level placeholder in the xst.rgtchar of
        /// the LVL that contains this LVLF. This array is zero-terminated, unless it is full. The count of elements in this array, before to the first terminating
        /// zero, MUST be less than or equal to the one-based level of the list to which this LVL corresponds. The integers in this array, before the first
        /// terminating zero, MUST be in ascending order, and MUST be unique.
        self.rgbxchNums = (
            try dataStream.read(),
            try dataStream.read(),
            try dataStream.read(),
            try dataStream.read(),
            try dataStream.read(),
            try dataStream.read(),
            try dataStream.read(),
            try dataStream.read(),
            try dataStream.read()
        )
        
        /// ixchFollow (1 byte): An unsigned integer that specifies the character that follows the number text. This MUST be one of the following values.
        let ixchFollowRaw: UInt8 = try dataStream.read()
        guard let ixchFollow = CharacterFollow(rawValue: ixchFollowRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.ixchFollow = ixchFollow
        
        /// dxaIndentSav (4 bytes): If fIndentSav is nonzero, this is a signed integer that specifies the size, in twips, of the indent that needs to be removed
        /// when the numbering is removed. This MUST be less than or equal to 0x00007BC0 or greater than or equal to 0xFFFF8440. If fIndentSav is zero,
        /// this MUST be ignored.
        let dxaIndentSav: Int32 = try dataStream.read(endianess: .littleEndian)
        if self.fIndentSav && (dxaIndentSav > 0x00007BC0 || dxaIndentSav < Int32(bitPattern: 0xFFFF8440)) {
            throw OfficeFileError.corrupted
        }
        
        self.dxaIndentSav = dxaIndentSav
        
        /// unused2 (4 bytes): This field MUST be ignored.
        self.unused2 = try dataStream.read(endianess: .littleEndian)
        
        /// cbGrpprlChpx (1 byte): An unsigned integer that specifies the size, in bytes, of the grpprlChpx in the LVL that contains this LVLF.
        self.cbGrpprlChpx = try dataStream.read()
        
        /// cbGrpprlPapx (1 byte): An unsigned integer that specifies the size, in bytes, of the grpprlPapx in the LVL that contains this LVLF.
        self.cbGrpprlPapx = try dataStream.read()
        
        /// ilvlRestartLim (1 byte): An unsigned integer that specifies the first (most-significant) zero-based level after which the number sequence of this
        /// level does not restart. The number sequence of this level does restart after any level that is more significant than the specified level. This MUST be
        /// less than or equal to the zero-based level of the list to which this LVLF corresponds. If fNoRestart is zero, this MUST be ignored. If this level
        /// does not have a number sequence (see nfc), this MUST be ignored.
        self.ilvlRestartLim = try dataStream.read()
        
        /// grfhic (1 byte): A grfhic that specifies the HTML incompatibilities of the level.
        self.grfhic = try OfficeFileReader.grfhic(dataStream: &dataStream)
    }
    
    /// jc (2 bits): An unsigned integer that specifies the justification of this level. This MUST be one of the following values.
    public enum Jusitification: UInt8 {
        /// 0x0 Left justified
        case left = 0x00
        
        /// 0x1 Center justified
        case center = 0x01
        
        /// 0x2 Right justified
        case right = 0x02
    }
    
    /// ixchFollow (1 byte): An unsigned integer that specifies the character that follows the number text. This MUST be one of the following values.
    public enum CharacterFollow: UInt8 {
        /// 0x0 A tab follows the number text.
        case tab = 0x0
        
        /// 0x1 A space follows the number text.
        case space = 0x1
        
        /// 0x2 Nothing follows the number text.
        case nothing = 0x2
    }
}
