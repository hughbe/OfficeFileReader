//
//  ParaBuildAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.8 ParaBuildAtom
/// Referenced by: ParaBuildContainer
/// An atom record that specifies the information for a paragraph build.
public struct ParaBuildAtom {
    public let rh: RecordHeader
    public let paraBuild: ParaBuildEnum
    public let buildLevel: UInt32
    public let fAnimBackground: bool1
    public let fReverse: bool1
    public let fUserSetAnimBackground: bool1
    public let fAutomatic: bool1
    public let delayTime: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x1.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_ParaBuildAtom.
        /// rh.recLen MUST be 0x00000010.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x1 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .paraBuildAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000010 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// paraBuild (4 bytes): A ParaBuildEnum enumeration that specifies the paragraph build type for text in the shape.
        guard let paraBuild = ParaBuildEnum(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.paraBuild = paraBuild
        
        /// buildLevel (4 bytes): An unsigned integer that specifies which paragraph level the paragraph build applies to. Paragraphs in level 1 to level
        /// buildLevel expand individually, and paragraphs in other levels animate at the same time as level buildLevel. If paraBuild is not
        /// TLPB_BuildByNthLevel, buildLevel MUST be ignored.
        self.buildLevel = try dataStream.read(endianess: .littleEndian)
        
        /// fAnimBackground (1 byte): A bool1 (section 2.2.2) that specifies whether the background animates. If there is an attached shape or a
        /// background on the text box or text placeholder shape, fAnimBackground is valid; otherwise, it MUST be ignored. It MUST be a value
        /// from the following table.
        /// Value Meaning
        /// 0x00 The background is not animated.
        /// 0x01 The background is animated.
        self.fAnimBackground = try bool1(dataStream: &dataStream)
        
        /// fReverse (1 byte): A bool1 that specifies whether the animation plays in reverse order. It MUST be a value from the following table:
        /// Value Meaning
        /// 0x00 The animation does not play in reverse order.
        /// 0x01 The animation plays in reverse order.
        self.fReverse = try bool1(dataStream: &dataStream)
        
        /// fUserSetAnimBackground (1 byte): A bool1 that specifies whether fAnimBackground has been toggled by any users. It MUST be a value
        /// from the following table.
        /// Value Meaning
        /// 0x00 fAnimBackground has never been toggled.
        /// 0x01 fAnimBackground has been toggled.
        self.fUserSetAnimBackground = try bool1(dataStream: &dataStream)
        
        /// fAutomatic (1 byte): A bool1 that specifies whether to automatically proceed to the next build step after the current build step is finished.
        /// It MUST be a value from the following table.
        /// Value Meaning
        /// 0x00 Do not automatically proceed to the next build step.
        /// 0x01 Automatically proceed to the next build step.
        self.fAutomatic = try bool1(dataStream: &dataStream)
        
        /// delayTime (4 bytes): An unsigned integer that specifies the waiting time, in milliseconds, from the time when the current build step is
        /// finished to the time when the next build step starts. It MUST be ignored if fAutomatic is 0x00.
        self.delayTime = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
