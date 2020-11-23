//
//  IScrollType.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

/// [MS-DOC] 2.9.122 IScrollType
/// The IScrollType enumerated type specifies the scrollbar behavior for a frame. A field of this type MUST contain one of the following values.
public enum IScrollType: UInt32 {
    /// iScrollAuto 0x00000000 A scrollbar appears only if it is needed.
    case auto = 0x00000000
    
    /// iScrollYes 0x00000001 A scrollbar appears even if not needed.
    case yes = 0x00000001
    
    /// iScrollNo 0x00000002 The frame never has a scrollbar.
    case no = 0x00000002
}
