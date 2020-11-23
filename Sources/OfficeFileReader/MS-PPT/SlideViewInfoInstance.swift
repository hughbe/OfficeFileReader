//
//  SlideViewInfoInstance.swift
//  
//
//  Created by Hugh Bellamy on 18/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.21.8 SlideViewInfoInstance
/// Referenced by: DocInfoListSubContainerOrAtom
/// A variable type record whose type and meaning are dictated by the value of rh.recInstance, as specified in the following table.
public enum SlideViewInfoInstance {
    /// 0x000 A SlideViewInfoContainer record (section 2.4.21.9) that specifies display preferences for when a user interface shows the presentation in
    /// a manner optimized for the display of presentation slides.
    case slideViewInfoContainer(data: SlideViewInfoContainer)

    /// 0x001 A NotesViewInfoContainer record (section 2.4.21.12) that specifies display preferences for when a user interface shows the presentation in
    /// a manner optimized for the display of notes slides.
    case notesViewInfoContainer(data: NotesViewInfoContainer)
    
    public init(dataStream: inout DataStream) throws {
        switch try dataStream.peekRecordHeader().recInstance {
        case 0x000:
            self = .slideViewInfoContainer(data: try SlideViewInfoContainer(dataStream: &dataStream))
        case 0x001:
            self = .notesViewInfoContainer(data: try NotesViewInfoContainer(dataStream: &dataStream))
        default:
            throw OfficeFileError.corrupted
        }
    }
}
