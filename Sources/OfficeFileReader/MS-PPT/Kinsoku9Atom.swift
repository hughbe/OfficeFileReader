//
//  Kinsoku9Atom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.7 Kinsoku9Atom
/// Referenced by: Kinsoku9Container
/// An atom record that specifies information about the types of East Asian text line breaking for the following languages: Japanese, Korean, Simplified
/// Chinese and Traditional Chinese.
public struct Kinsoku9Atom {
    public let rh: RecordHeader
    public let korLevel: KoreanLevel
    public let scLevel: SimplifiedChineseLevel
    public let tcLevel: TraditionalChineseLevel
    public let jpnLevel: JapaneseLevel
    public let reserved: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x003.
        /// rh.recType MUST be an RT_KinsokuAtom.
        /// rh.recLen MUST be 0x00000004.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x003 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .kinsokuAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000004 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - korLevel (2 bits): An unsigned integer that specifies the type of East Asian text line breaking applied to Korean text. It MUST be a value
        /// from the following table:
        guard let korLevel = KoreanLevel(rawValue: UInt8(flags.readBits(count: 2))) else {
            throw OfficeFileError.corrupted
        }
        
        self.korLevel = korLevel
        
        /// B - scLevel (2 bits): An unsigned integer that specifies the type of East Asian text line breaking applied to Simplified Chinese text. It MUST
        /// be a value from the following table.
        guard let scLevel = SimplifiedChineseLevel(rawValue: UInt8(flags.readBits(count: 2))) else {
            throw OfficeFileError.corrupted
        }
        
        self.scLevel = scLevel
        
        /// C - tcLevel (2 bits): An unsigned integer that specifies the type of East Asian text line breaking applied to Traditional Chinese text. It MUST
        /// be a value from the following table.
        guard let tcLevel = TraditionalChineseLevel(rawValue: UInt8(flags.readBits(count: 2))) else {
            throw OfficeFileError.corrupted
        }
        
        self.tcLevel = tcLevel
        
        /// D - jpnLevel (2 bits): An unsigned integer that specifies the type of East Asian text line breaking applied to Japanese text. It MUST be a value
        /// from the following table.
        guard let jpnLevel = JapaneseLevel(rawValue: UInt8(flags.readBits(count: 2))) else {
            throw OfficeFileError.corrupted
        }
        
        self.jpnLevel = jpnLevel
        
        /// reserved (24 bits): MUST be zero and MUST be ignored.
        self.reserved = flags.readRemainingBits()

        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
    
    /// A - korLevel (2 bits): An unsigned integer that specifies the type of East Asian text line breaking applied to Korean text. It MUST be a value
    /// from the following table:
    public enum KoreanLevel: UInt8 {
        /// 0x00000000 Use standard line breaking settings.
        case standard = 0x00
        
        /// 0x00000002 Use the customized line breaking settings specified by the KinsokuLeadingAtom and KinsokuFollowingAtom records contained
        /// in either the KinsokuContainer (section 2.9.2) or Kinsoku9Container record (section 2.9.6).
        case customized = 0x02
    }
    
    /// B - scLevel (2 bits): An unsigned integer that specifies the type of East Asian text line breaking applied to Simplified Chinese text. It MUST
    /// be a value from the following table.
    public enum SimplifiedChineseLevel: UInt8 {
        /// 0x00000000 Use standard line breaking settings.
        case standard = 0x00
        
        /// 0x00000002 Use the customized line breaking settings specified by the KinsokuLeadingAtom and KinsokuFollowingAtom records contained
        /// in either the KinsokuContainer or Kinsoku9Container record.
        case customized = 0x02
    }
    
    /// C - tcLevel (2 bits): An unsigned integer that specifies the type of East Asian text line breaking applied to Traditional Chinese text. It MUST
    /// be a value from the following table.
    public enum TraditionalChineseLevel: UInt8 {
        /// 0x00000000 Use standard line breaking settings.
        case standard = 0x00
        
        /// 0x00000002 Use the customized line breaking settings specified by the KinsokuLeadingAtom and KinsokuFollowingAtom records contained
        /// in either the KinsokuContainer or Kinsoku9Container record.
        case customized = 0x02
    }
    
    /// D - jpnLevel (2 bits): An unsigned integer that specifies the type of East Asian text line breaking applied to Japanese text. It MUST be a value
    /// from the following table.
    public enum JapaneseLevel: UInt8 {
        /// 0x00000000 Use standard line breaking settings.
        case standard = 0x00
        
        /// 0x00000001 Use strict line breaking settings.
        case strict = 0x01
        
        /// 0x00000002 Use the customized line breaking settings specified by the KinsokuLeadingAtom and KinsokuFollowingAtom records contained
        /// in either the KinsokuContainer or Kinsoku9Container record.
        case customized = 0x02
    }
}
