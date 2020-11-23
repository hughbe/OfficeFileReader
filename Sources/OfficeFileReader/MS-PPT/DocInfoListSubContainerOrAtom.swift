//
//  DocInfoListSubContainerOrAtom.swift
//  
//
//  Created by Hugh Bellamy on 18/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.5 DocInfoListSubContainerOrAtom
/// Referenced by: DocInfoListContainer
/// A variable type record whose type and meaning are dictated by the value of rh.recType, as specified in the following table.
public enum DocInfoListSubContainerOrAtom {
    case progTags(data: DocProgTagsContainer)
    case normalViewSetInfo9(data: NormalViewSetInfoContainer)
    case notesTextViewInfo9(data: NotesTextViewInfoContainer)
    case outlineViewInfo(data: OutlineViewInfoContainer)
    case slideViewInfo(data: SlideViewInfoInstance)
    case sorterViewInfo(data: SorterViewInfoContainer)
    case vbaInfo(data: VBAInfoContainer)
    
    public init(dataStream: inout DataStream) throws {
        switch try dataStream.peekRecordHeader().recType {
        case .progTags:
            self = .progTags(data: try DocProgTagsContainer(dataStream: &dataStream))
        case .normalViewSetInfo9:
            self = .normalViewSetInfo9(data: try NormalViewSetInfoContainer(dataStream: &dataStream))
        case .notesTextViewInfo9:
            self = .notesTextViewInfo9(data: try NotesTextViewInfoContainer(dataStream: &dataStream))
        case .outlineViewInfo:
            self = .outlineViewInfo(data: try OutlineViewInfoContainer(dataStream: &dataStream))
        case .slideViewInfo:
            self = .slideViewInfo(data: try SlideViewInfoInstance(dataStream: &dataStream))
        case .sorterViewInfo:
            self = .sorterViewInfo(data: try SorterViewInfoContainer(dataStream: &dataStream))
        case .vbaInfo:
            self = .vbaInfo(data: try VBAInfoContainer(dataStream: &dataStream))
        default:
            throw OfficeFileError.corrupted
        }
    }
}
