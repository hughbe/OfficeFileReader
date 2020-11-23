//
//  ShapeProgTagsSubContainerOrAtom.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-PPT] 2.7.15 ShapeProgTagsSubContainerOrAtom
/// Referenced by: ShapeProgTagsContainer
/// A variable type record whose type and meaning are dictated by the value of rh.recType, as specified in the following table.
public enum ShapeProgTagsSubContainerOrAtom {
    /// RT_ProgStringTag A ProgStringTagContainer record that specifies additional shape data.
    case progStringTag(data: ProgStringTagContainer)
    
    /// RT_ProgBinaryTag A ShapeProgBinaryTagContainer record that specifies additional shape data.
    case progBinaryTag(data: ShapeProgBinaryTagContainer)
    
    public init(dataStream: inout DataStream) throws {
        let position = dataStream.position
        let rh = try RecordHeader(dataStream: &dataStream)
        dataStream.position = position
        
        switch rh.recType {
        case .progStringTag:
            self = .progStringTag(data: try ProgStringTagContainer(dataStream: &dataStream))
        case .progBinaryTag:
            self = .progBinaryTag(data: try ShapeProgBinaryTagContainer(dataStream: &dataStream))
        default:
            throw OfficeFileError.corrupted
        }
    }
}
