//
//  File.swift
//  
//
//  Created by Hugh Bellamy on 23/11/2020.
//

/// [MS-PPT] 2.13.6 ConditionEnum
/// Referenced by: TimeConditionContainer
/// An enumeration that specifies the type of a time condition.
public enum ConditionEnum: UInt32 {
    /// TL_CT_None 0x00000001 None.
    case none = 0x00000001
    
    /// TL_CT_Begin 0x00000002 Begin condition that specifies when a time node will be activated.
    case begin = 0x00000002
    
    /// TL_CT_End 0x00000003 End condition that specifies when a time node will be deactivated.
    case end = 0x00000003
    
    /// TL_CT_Next 0x00000004 Next condition that specifies when the next child time node of a sequential time node will be activated.
    case next = 0x00000004
    
    /// TL_CT_Previous 0x00000005 Previous condition that specifies when the previous child time node of a sequential time node will be activated.
    case previous = 0x00000005
    
    /// TL_CT_EndSync 0x00000006 EndSync condition that specifies how to synchronize the stopping of the child nodes of a time node.
    case endSync = 0x00000006
}
