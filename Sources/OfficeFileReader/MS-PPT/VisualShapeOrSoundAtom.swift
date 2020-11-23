//
//  VisualShapeOrSoundAtom.swift
//
//
//  Created by Hugh Bellamy on 22/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.47 VisualShapeOrSoundAtom
/// Referenced by: VisualElementAtom
/// A variable type record whose type and meaning are dictated by the value of refType, as specified in the following table.
public enum VisualShapeOrSoundAtom {
    /// TL_ET_SoundType A VisualSoundAtom record that specifies the sound information for an animation target.
    case sound(data: VisualSoundAtom)
    
    /// TL_ET_ShapeType A VisualShapeAtom record that specifies the shape information for an animation target
    case shape(data: VisualShapeAtom)
    
    public init(dataStream: inout DataStream) throws {
        let position = dataStream.position
        let rh = try RecordHeader(dataStream: &dataStream)
        guard rh.recType == .visualShapeAtom else {
            throw OfficeFileError.corrupted
        }
        
        /// type (4 bytes): A TimeVisualElementEnum enumeration that specifies the target element type for the shape that the animation is applied to. 
        guard let _ = TimeVisualElementEnum(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        /// refType (4 bytes): An ElementTypeEnum enumeration that specifies the target element type of the animation.
        guard let refType = ElementTypeEnum(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        dataStream.position = position
        
        switch refType {
        case .sound:
            self = .sound(data: try VisualSoundAtom(dataStream: &dataStream))
        case .shape:
            self = .shape(data: try VisualShapeAtom(dataStream: &dataStream))
        }
    }
}
