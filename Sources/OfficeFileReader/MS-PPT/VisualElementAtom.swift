//
//  VisualElementAtom.swift
//  
//
//  Created by Hugh Bellamy on 22/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.45 VisualElementAtom
/// Referenced by: ClientVisualElementContainer
/// A variable type record whose type and meaning are dictated by the value of rh.recType, as specified in the following table.
public enum VisualElementAtom {
    /// RT_VisualPageAtom A VisualPageAtom record that specifies the slide as the target for a time condition.
    case visualPageAtom(data: VisualPageAtom)
    
    /// RT_VisualShapeAtom A VisualShapeOrSoundAtom record that specifies the shape or sound information for an animation target.
    case visualShapeAtom(data: VisualShapeOrSoundAtom)
    
    public init(dataStream: inout DataStream) throws {
        switch try dataStream.peekRecordHeader().recType {
        case .visualPageAtom:
            self = .visualPageAtom(data: try VisualPageAtom(dataStream: &dataStream))
        case .visualShapeAtom:
            self = .visualShapeAtom(data: try VisualShapeOrSoundAtom(dataStream: &dataStream))
        default:
            throw OfficeFileError.corrupted
        }
    }
}
