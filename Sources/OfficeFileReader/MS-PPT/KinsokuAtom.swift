//
//  KinsokuAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.3 KinsokuAtom
/// Referenced by: KinsokuContainer
/// An atom record that specifies the type of East Asian text line breaking.
public struct KinsokuAtom {
    public let rh: RecordHeader
    public let level: EastAsianTextLineBreakingType
    
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

        /// level (4 bytes): A signed integer that specifies the type of East Asian text line breaking. It MUST be a value from the following table.
        guard let level = EastAsianTextLineBreakingType(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }

        self.level = level

        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
    
    /// level (4 bytes): A signed integer that specifies the type of East Asian text line breaking. It MUST be a value from the following table.
    public enum EastAsianTextLineBreakingType: UInt32 {
        /// 0x00000000 Use standard line breaking settings.
        case standardLineBreakingSettings = 0x00000000
        
        /// 0x00000001 Use strict line breaking settings for Japanese text.
        case strictLineBreakingForJapaneseText = 0x00000001
        
        /// 0x00000002 Use the customized line breaking settings specified by the kinsokuLeadingAtom and kinsokuFollowingAtom fields of the
        /// KinsokuContainer (section 2.9.2) that contains this KinsokuAtom.
        case customizedLineBreakingSettings = 0x00000002
    }
}
