//
//  TriggerObjectEnum.swift
//  
//
//  Created by Hugh Bellamy on 22/11/2020.
//

/// [MS-PPT] 2.13.41 TriggerObjectEnum
/// Referenced by: TimeConditionAtom
/// An enumeration that specifies the type of a target that participates in the evaluation of a time condition.
public enum TriggerObjectEnum: UInt32 {
    /// TL_TOT_None 0x00000000 None.
    case none = 0x00000000
    
    /// TL_TOT_VisualElement 0x00000001 An animatable object.
    case visualElement = 0x00000001
    
    /// TL_TOT_TimeNode 0x00000002 A time node.
    case timeNode = 0x00000002
    
    /// TL_TOT_RuntimeNodeRef 0x00000003 Runtime child time nodes.
    case runtimeNodeRef = 0x00000003
}
