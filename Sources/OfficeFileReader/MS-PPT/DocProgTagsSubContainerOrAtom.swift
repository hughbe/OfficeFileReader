//
//  DocProgTagsSubContainerOrAtom.swift
//
//
//  Created by Hugh Bellamy on 18/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.23.2 DocProgTagsSubContainerOrAtom
/// Referenced by: DocProgTagsContainer
/// A variable type record whose type and meaning are dictated by the value of rh.recType, as specified in the following table.
public enum DocProgTagsSubContainerOrAtom {
    /// RT_ProgStringTag A ProgStringTagContainer record that specifies additional document data.
    case progStringTag(data: ProgStringTagContainer)
    
    /// RT_ProgBinaryTag A DocProgBinaryTagContainer record that specifies additional document data.
    case progBinaryTag(data: DocProgBinaryTagContainer)
    
    public init(dataStream: inout DataStream) throws {
        switch try dataStream.peekRecordHeader().recType {
        case .progStringTag:
            self = .progStringTag(data: try ProgStringTagContainer(dataStream: &dataStream))
        case .progBinaryTag:
            self = .progBinaryTag(data: try DocProgBinaryTagContainer(dataStream: &dataStream))
        default:
            throw OfficeFileError.corrupted
        }
    }
}
