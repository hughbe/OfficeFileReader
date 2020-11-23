//
//  TimeVariantTypeEnum.swift
//  
//
//  Created by Hugh Bellamy on 22/11/2020.
//

/// [MS-PPT] 2.13.39 TimeVariantTypeEnum
/// Referenced by: TimeColorDirection, TimeColorModel, TimeDisplayType, TimeEffectID, TimeEffectNodeType, TimeEffectType, TimeEventFilter,
/// TimeGroupID, TimeMasterRelType, TimeNodeTimeFilter, TimeOverride, TimePointsTypes, TimeRuntimeContext, TimeSubType, TimeVariantBool,
/// TimeVariantFloat, TimeVariantInt, TimeVariantString
/// An enumeration that specifies the data type of a value.
public enum TimeVariantTypeEnum: UInt8 {
    /// TL_TVT_Bool 0x00 A Boolean value.
    case bool = 0x00

    /// TL_TVT_Int 0x01 A signed integer.
    case int = 0x01

    /// TL_TVT_Float 0x02 A floating-point number.
    case float = 0x02

    /// TL_TVT_String 0x03 A Unicode string.
    case string = 0x03
}
