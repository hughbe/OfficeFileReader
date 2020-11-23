//
//  TextTypeEnum.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

/// [MS-PPT] 2.13.33 TextTypeEnum
/// Referenced by: OutlineTextPropsHeaderExAtom, TextHeaderAtom
/// An enumeration that specifies the types of text.
public enum TextTypeEnum: UInt32 {
    /// Tx_TYPE_TITLE 0x00000000 Title placeholder shape text.
    case title = 0x00000000
    
    /// Tx_TYPE_BODY 0x00000001 Body placeholder shape text.
    case body = 0x00000001
    
    /// Tx_TYPE_NOTES 0x00000002 Notes placeholder shape text.
    case notes = 0x00000002
    
    /// Tx_TYPE_OTHER 0x00000004 Any other text.
    case other = 0x00000004
    
    /// Tx_TYPE_CENTERBODY 0x00000005 Center body placeholder shape text.
    case centerBody = 0x00000005
    
    /// Tx_TYPE_CENTERTITLE 0x00000006 Center title placeholder shape text.
    case centerTitle = 0x00000006
    
    /// Tx_TYPE_HALFBODY 0x00000007 Half-sized body placeholder shape text.
    case halfBody = 0x00000007
    
    /// Tx_TYPE_QUARTERBODY 0x00000008 Quarter-sized body placeholder shape text.
    case quarterBody = 0x00000008
}
