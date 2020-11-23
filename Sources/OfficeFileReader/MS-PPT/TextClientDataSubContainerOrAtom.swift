//
//  TextClientDataSubContainerOrAtom.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

public enum TextClientDataSubContainerOrAtom {
    /// RT_OutlineTextRefAtom An OutlineTextRefAtom record that specifies a reference to a TextHeaderAtom record contained in the
    /// SlideListWithTextContainer record (section 2.4.14.3). The TextHeaderAtom record specifies the text for the shape that contains this record.
    case outlineTextRefAtom(data: OutlineTextRefAtom)
    
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
    
    /// RT_GenericDateMetaCharAtom A GenericDateMCAtom record that specifies a generic date metacharacter.
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
    
    /// RT_TextRulerAtom A TextRulerAtom record that specifies a text ruler.
    case textRulerAtom(data: TextRulerAtom)

    /// RT_MasterTextPropAtom A MasterTextPropAtom record that specifies style properties for text on a master slide.
    case masterTextPropAtom(data: MasterTextPropAtom)
    
    public init(dataStream: inout DataStream, textCount: Int) throws {
        switch try dataStream.peekRecordHeader().recType {
        case .outlineTextRefAtom:
            self = .outlineTextRefAtom(data: try OutlineTextRefAtom(dataStream: &dataStream))
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
        case .textRulerAtom:
            self = .textRulerAtom(data: try TextRulerAtom(dataStream: &dataStream))
        case .masterTextPropAtom:
            self = .masterTextPropAtom(data: try MasterTextPropAtom(dataStream: &dataStream, textCount: textCount))
        default:
            throw OfficeFileError.corrupted
        }
    }
}
