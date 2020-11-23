//
//  TimeAnimateBehaviorValueTypeEnum.swift
//  
//
//  Created by Hugh Bellamy on 22/11/2020.
//

/// [MS-PPT] 2.13.34 TimeAnimateBehaviorValueTypeEnum
/// Referenced by: TimeAnimateBehaviorAtom, TimeSetBehaviorAtom
/// An enumeration that specifies the data type of a property to be animated.
public enum TimeAnimateBehaviorValueTypeEnum: UInt32 {
    /// TL_TABVT_String 0x00000000 Animate text content.
    case string = 0x00000000
    
    /// TL_TABVT_Number 0x00000001 Animate a numeric property.
    case number = 0x00000001
    
    /// TL_TABVT_Color 0x00000002 Animate a color property.
    case color = 0x00000002
}
