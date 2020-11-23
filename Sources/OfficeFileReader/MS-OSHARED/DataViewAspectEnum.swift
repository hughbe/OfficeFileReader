//
//  DataViewAspectEnum.swift
//  
//
//  Created by Hugh Bellamy on 16/11/2020.
//

/// [MS-OSHARED] 2.2.1.2 DataViewAspectEnum
/// Specifies the desired data or view aspect of the object when drawing or obtaining data.
public enum DataViewAspectEnum: UInt32 {
    /// OR_Content 0x00000001 Specifies that the object is displayed as an embedded object inside of a container.
    case content = 0x00000001
    
    /// OR_Thumbnail 0x00000002 Specifies that the object is displayed as a thumbnail image.
    case thumbnail = 0x00000002
    
    /// OR_Icon 0x00000004 Specifies that the object is displayed as an icon.
    case icon = 0x00000004
    
    /// OR_DocPrint 0x00000008 Specifies that the object is displayed on the screen as though it were printed to a printer.
    case docPrint = 0x00000008
}
