//
//  ExColorFollowEnum.swift
//  
//
//  Created by Hugh Bellamy on 17/11/2020.
//

/// [MS-PPT] 2.13.10 ExColorFollowEnum
/// Referenced by: ExOleEmbedAtom
/// An enumeration that specifies how an OLE object follows the color scheme.
public enum ExColorFollowEnum: UInt32 {
    /// ExColor_FollowNone 0x00000000 Does not follow the color scheme.
    case followNone = 0x00000000
    
    /// ExColor_FollowScheme 0x00000001 Follows the color scheme.
    case followScheme = 0x00000001
    
    /// ExColor_FollowTextAndBackground 0x00000002 Follows only the text and background colors of the color scheme.
    case followTextAndBackground = 0x00000002
}
