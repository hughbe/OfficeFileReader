//
//  SlideProgTagsSubContainerOrAtom.swift
//  
//
//  Created by Hugh Bellamy on 21/11/2020.
//

import DataStream

/// [MS-PPT] 2.5.20 SlideProgTagsSubContainerOrAtom
/// Referenced by: SlideProgTagsContainer
/// A variable type record whose type and meaning are dictated by the value of rh.recType, as specified in the following table.
public enum SlideProgTagsSubContainerOrAtom {
    /// RT_ProgStringTag A ProgStringTagContainer record that specifies additional slide data.
    case progStringTag(data: ProgStringTagContainer)
    
    /// RT_ProgBinaryTag A SlideProgBinaryTagContainer record that specifies additional slide data.
    case progBinaryTag(data: SlideProgBinaryTagContainer)
    
    public init(dataStream: inout DataStream) throws {
        switch try dataStream.peekRecordHeader().recType {
        case .progStringTag:
            self = .progStringTag(data: try ProgStringTagContainer(dataStream: &dataStream))
        case .progBinaryTag:
            self = .progBinaryTag(data: try SlideProgBinaryTagContainer(dataStream: &dataStream))
        default:
            throw OfficeFileError.corrupted
        }
    }
}
