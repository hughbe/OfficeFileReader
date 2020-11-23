//
//  GuideAtom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.21.11 GuideAtom
/// Referenced by: NotesViewInfoContainer, SlideViewInfoContainer
/// An atom record that specifies a guide. A guide can be used to align objects on a slide and to display visual positioning cues.
public struct GuideAtom {
    public let rh: RecordHeader
    public let type: GuideType
    public let pos: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x007.
        /// rh.recType MUST be RT_GuideAtom.
        /// rh.recLen MUST be 0x00000008.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x007 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .guideAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000008 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// type (4 bytes): An unsigned integer that specifies whether the guide is horizontal or vertical. It MUST be a value from the following table.
        guard let type = GuideType(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }

        self.type = type
        
        /// pos (4 bytes): A signed integer that specifies the position of the guide in master units relative to the top-left corner of the slide. It MUST
        /// be greater than or equal to -15840 or -27.5 inches and less than or equal to 32255 or 56 inches. Typical values range from zero to slide
        /// height for a horizontal guide and from zero to slide width for a vertical guide.
        self.pos = try dataStream.read(endianess: .littleEndian)
        guard self.pos >= -15840 && self.pos <= 32255 else {
            throw OfficeFileError.corrupted
        }
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
    
    /// type (4 bytes): An unsigned integer that specifies whether the guide is horizontal or vertical. It MUST be a value from the following table.
    public enum GuideType: UInt32 {
        /// 0x00000000 The guide is horizontal.
        case horizontal = 0x00000000

        /// 0x00000001 The guide is vertical.
        case vertical = 0x00000001
    }
}
