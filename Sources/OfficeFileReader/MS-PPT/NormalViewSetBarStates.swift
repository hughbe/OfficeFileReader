//
//  NormalViewSetBarStates.swift
//  
//
//  Created by Hugh Bellamy on 18/11/2020.
//

/// [MS-PPT] 2.13.16 NormalViewSetBarStates
/// Referenced by: NormalViewSetInfoAtom
/// An enumeration that specifies different states of a region of a view.
public enum NormalViewSetBarStates: UInt8 {
    /// BS_Minimized 0x00 The region occupies a minimal area of the view.
    case minimized = 0x00
    
    /// BS_Restored 0x01 The region has an intermediate size.
    case restored = 0x01
    
    /// BS_Maximized 0x02 The region occupies a maximal area of the view.
    case maximized = 0x02
}
