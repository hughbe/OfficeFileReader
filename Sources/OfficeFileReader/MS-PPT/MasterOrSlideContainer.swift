//
//  MasterOrSlideContainer.swift
//  
//
//  Created by Hugh Bellamy on 23/11/2020.
//

import DataStream

/// [MS-PPT] 2.5.5 MasterOrSlideContainer
/// A variable type record whose type and meaning is dictated by the value of rh.recType, as specified in the following table.
public enum MasterOrSlideContainer {
    /// RT_Slide A SlideContainer record (section 2.5.1) that specifies a title master slide.
    case slide(data: SlideContainer)
    
    /// RT_MainMaster A MainMasterContainer record (section 2.5.3) that specifies a main master slide.
    case mainMaster(data: MainMasterContainer)
    
    public init(dataStream: inout DataStream) throws {
        switch try dataStream.peekRecordHeader().recType {
        case .slide:
            self = .slide(data: try SlideContainer(dataStream: &dataStream))
        case .mainMaster:
            self = .mainMaster(data: try MainMasterContainer(dataStream: &dataStream))
        default:
            throw OfficeFileError.corrupted
        }
    }
}
