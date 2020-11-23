//
//  TimeNodeTypeEnum.swift
//  
//
//  Created by Hugh Bellamy on 22/11/2020.
//

/// [MS-PPT] 2.13.36 TimeNodeTypeEnum
/// Referenced by: TimeNodeAtom
/// An enumeration that specifies the type of a time node.
public enum TimeNodeTypeEnum: UInt32 {
    /// TL_TNT_Parallel 0x00000000 Parallel time node whose child nodes can start simultaneously.
    case parallel = 0x00000000
    
    /// TL_TNT_Sequential 0x00000001 Sequential time node whose child nodes can only start sequentially and each child can only start after its
    /// previous sibling has started.
    case sequential = 0x00000001
    
    /// TL_TNT_Behavior 0x00000003 Behavior time node that contains a behavior.
    case behavior = 0x00000003
    
    /// TL_TNT_Media 0x00000004 Media time node that contains a media object.
    case media = 0x00000004
}
