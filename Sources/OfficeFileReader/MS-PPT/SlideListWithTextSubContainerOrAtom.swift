//
//  SlideListWithTextSubContainerOrAtom.swift
//  
//
//  Created by Hugh Bellamy on 21/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.14.4 SlideListWithTextSubContainerOrAtom
/// Referenced by: SlideListWithTextContainer
/// A variable type record whose type and meaning are dictated by the value of rh.recType, as specified in the following table.
public enum SlideListWithTextSubContainerOrAtom {
    /// RT_SlidePersistAtom A SlidePersistAtom record (section 2.4.14.5) that specifies a reference to a presentation slide.
    case slidePersistAtom(data: SlidePersistAtom)
    
    /// RT_TextHeaderAtom A TextHeaderAtom record that specifies the type of a body of text.
    case textHeaderAtom(data: TextHeaderAtom)
    
    /// RT_TextCharsAtom A TextCharsAtom record that specifies text characters.
    case textCharsAtom(data: TextCharsAtom)
   
    /// RT_TextBytesAtom A TextBytesAtom record that specifies text characters.
    case textBytesAtom(data: TextBytesAtom)
    
    /// RT_StyleTextPropAtom A StyleTextPropAtom record that specifies text character and paragraph properties.
    case styleTextPropAtom(data: StyleTextPropAtom)
    
    /// RT_SlideNumberMetaCharAtom A SlideNumberMCAtom record that specifies a slide number metacharacter.
    case slideNumberMetaCharAtom(data: SlideNumberMCAtom)
    
    /// RT_DateTimeMetaCharAtom A DateTimeMCAtom record that specifies a datetime metacharacter.
    case dateTimeMetaCharAtom(data: DateTimeMCAtom)
    
    /// RT_GenericDateMetaCharAtom A GenericDateMCAtom record that specifies a datetime metacharacter.
    case genericDateMetaCharAtom(data: GenericDateMCAtom)
    
    /// RT_HeaderMetaCharAtom A HeaderMCAtom record that specifies a header metacharacter.
    case headerMetaCharAtom(data: HeaderMCAtom)
    
    /// RT_FooterMetaCharAtom A FooterMCAtom record that specifies a footer metacharacter.
    case footerMetaCharAtom(data: FooterMCAtom)
    
    /// RT_RtfDateTimeMetaCharAtom A RTFDateTimeMCAtom record that specifies an RTF datetime metacharacter.
    case rtfDateTimeMetaCharAtom(data: RTFDateTimeMCAtom)
    
    /// RT_TextBookmarkAtom A TextBookmarkAtom record that specifies a text bookmark.
    case textBookmarkAtom(data: TextBookmarkAtom)
    
    /// RT_TextSpecialInfoAtom A TextSpecialInfoAtom record that specifies additional text properties.
    case textSpecialInfoAtom(data: TextSpecialInfoAtom)
    
    /// RT_InteractiveInfo An InteractiveInfoInstance record that specifies text interactive information.
    case interactiveInfo(data: InteractiveInfoInstance)
    
    /// RT_TextInteractiveInfoAtom A TextInteractiveInfoInstance record that specifies the anchor for text interactive information.
    case textInteractiveInfoAtom(data: TextInteractiveInfoInstance)
    
    public init(dataStream: inout DataStream, textCount: Int) throws {
        switch try dataStream.peekRecordHeader().recType {
        case .slidePersistAtom:
            self = .slidePersistAtom(data: try SlidePersistAtom(dataStream: &dataStream))
        case .textHeaderAtom:
            self = .textHeaderAtom(data: try TextHeaderAtom(dataStream: &dataStream))
        case .textCharsAtom:
            self = .textCharsAtom(data: try TextCharsAtom(dataStream: &dataStream))
        case .textBytesAtom:
            self = .textBytesAtom(data: try TextBytesAtom(dataStream: &dataStream))
        case .styleTextPropAtom:
            self = .styleTextPropAtom(data: try StyleTextPropAtom(dataStream: &dataStream, textCount: textCount))
        case .slideNumberMetaCharAtom:
            self = .slideNumberMetaCharAtom(data: try SlideNumberMCAtom(dataStream: &dataStream))
        case .dateTimeMetaCharAtom:
            self = .dateTimeMetaCharAtom(data: try DateTimeMCAtom(dataStream: &dataStream))
        case .genericDateMetaCharAtom:
            self = .genericDateMetaCharAtom(data: try GenericDateMCAtom(dataStream: &dataStream))
        case .headerMetaCharAtom:
            self = .headerMetaCharAtom(data: try HeaderMCAtom(dataStream: &dataStream))
        case .footerMetaCharAtom:
            self = .footerMetaCharAtom(data: try FooterMCAtom(dataStream: &dataStream))
        case .rtfDateTimeMetaCharAtom:
            self = .rtfDateTimeMetaCharAtom(data: try RTFDateTimeMCAtom(dataStream: &dataStream))
        case .textBookmarkAtom:
            self = .textBookmarkAtom(data: try TextBookmarkAtom(dataStream: &dataStream))
        case .textSpecialInfoAtom:
            self = .textSpecialInfoAtom(data: try TextSpecialInfoAtom(dataStream: &dataStream, textCount: textCount))
        case .interactiveInfo:
            self = .interactiveInfo(data: try InteractiveInfoInstance(dataStream: &dataStream))
        case .textInteractiveInfoAtom:
            self = .textInteractiveInfoAtom(data: try TextInteractiveInfoInstance(dataStream: &dataStream))
        default:
            throw OfficeFileError.corrupted
        }
    }
}
