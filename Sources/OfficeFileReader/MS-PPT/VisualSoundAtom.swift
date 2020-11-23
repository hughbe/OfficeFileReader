//
//  VisualSoundAtom.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.48 VisualSoundAtom
/// Referenced by: VisualShapeOrSoundAtom
/// An atom record that specifies the sound information for an animation target.
public struct VisualSoundAtom {
    public let rh: RecordHeader
    public let type: TimeVisualElementEnum
    public let refType: ElementTypeEnum
    public let soundIdRef: SoundIdRef
    public let data1: UInt32
    public let data2: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_VisualShapeAtom.
        /// rh.recLen MUST be 0x00000014.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .visualShapeAtom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000014 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// type (4 bytes): A TimeVisualElementEnum enumeration that specifies the target element type for the shape that the animation is applied to.
        /// It MUST NOT be TL_TVET_Page.
        guard let type = TimeVisualElementEnum(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        guard type != .page else {
            throw OfficeFileError.corrupted
        }
        
        self.type = type
        
        /// refType (4 bytes): An ElementTypeEnum enumeration that specifies the target element type of the animation. It MUST be TL_ET_SoundType.
        guard let refType = ElementTypeEnum(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        guard refType == .sound else {
            throw OfficeFileError.corrupted
        }
        
        self.refType = refType
        
        /// soundIdRef (4 bytes): A SoundIdRef that specifies the value to look up in the SoundCollectionContainer record (section 2.4.16.1) to find
        /// the embedded audio.
        self.soundIdRef = try dataStream.read(endianess: .littleEndian)
        
        /// data1 (4 bytes): MUST be 0xFFFFFFFF, and MUST be ignored.
        self.data1 = try dataStream.read(endianess: .littleEndian)
        
        /// data2 (4 bytes): MUST be 0xFFFFFFFF, and MUST be ignored.
        self.data2 = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
