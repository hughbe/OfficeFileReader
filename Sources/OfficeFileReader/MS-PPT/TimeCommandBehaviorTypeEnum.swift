//
//  TimeCommandBehaviorTypeEnum.swift
//  
//
//  Created by Hugh Bellamy on 22/11/2020.
//

/// [MS-PPT] 2.13.35 TimeCommandBehaviorTypeEnum
/// Referenced by: TimeCommandBehaviorAtom
/// An enumeration that specifies the type of a command.
public enum TimeCommandBehaviorTypeEnum: UInt32 {
    /// TL_TCBT_Event 0x00000000 Send out an event to the target object.
    case event = 0x00000000
    
    /// TL_TCBT_Call 0x00000001 Call a method or function on the target object.
    case call = 0x00000001
    
    /// TL_TCBT_OleVerb 0x00000002 Send an OLE verb to the target object.
    case oleVerb = 0x00000002
}
