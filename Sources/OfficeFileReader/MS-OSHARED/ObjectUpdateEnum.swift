//
//  ObjectUpdateEnum.swift
//  
//
//  Created by Hugh Bellamy on 17/11/2020.
//

/// [MS-OSHARED] 2.2.1.1 ObjectUpdateEnum
/// Specifies how the container updates the linked object embedded in an application.
public enum ObjectUpdateEnum: UInt32 {
    /// OU_Always 0x00000001 The container updates the linked object whenever there is an update associated with it.
    case always = 0x00000001
    
    /// OU_OnCall 0x00000003 The container updates the linked object only when the container calls its update method.
    case onCall = 0x00000003
}
