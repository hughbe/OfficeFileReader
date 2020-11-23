//
//  TextInteractiveInfoInstance.swift
//  
//
//  Created by Hugh Bellamy on 13/11/2020.
//

import DataStream

/// [MS-PPT] 2.9.56 TextInteractiveInfoInstance
/// Referenced by: SlideListWithTextSubContainerOrAtom, TextClientDataSubContainerOrAtom
/// A variable type record whose type and meaning are dictated by the value of rh.recInstance, as specified in the following table.
public enum TextInteractiveInfoInstance {
    /// 0x000 A MouseClickTextInteractiveInfoAtom record that specifies the corresponding text range of the preceding MouseClickInteractiveInfoContainer
    /// record.
    case mouseClick(data: MouseClickTextInteractiveInfoAtom)
    
    /// 0x001 A MouseOverTextInteractiveInfoAtom record that specifies the corresponding text range of the preceding MouseOverInteractiveInfoContainer
    /// record.
    case mouseOver(data: MouseOverTextInteractiveInfoAtom)
    
    public init(dataStream: inout DataStream) throws {
        let position = dataStream.position
        let rh = try RecordHeader(dataStream: &dataStream)
        dataStream.position = position
        
        switch rh.recInstance {
        case 0x000:
            self = .mouseClick(data: try MouseClickTextInteractiveInfoAtom(dataStream: &dataStream))
        case 0x001:
            self = .mouseOver(data: try MouseOverTextInteractiveInfoAtom(dataStream: &dataStream))
        default:
            throw OfficeFileError.corrupted
        }
    }
}
