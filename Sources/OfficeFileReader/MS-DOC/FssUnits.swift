//
//  FssUnits.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

/// [MS-DOC] 2.9.99 FssUnits
/// The FssUnits enumerated type specifies the units in an Fssd. A field of this type MUST contain one of the following values.
public enum FssUnits: UInt32 {
    /// iFssUnitsNil 0x00000000 No units are specified.
    case `nil` = 0x00000000
    
    /// iFssUnitsPxl 0x00000001 The value is in pixels.
    case pixels = 0x00000001
    
    /// iFssUnitsPct 0x00000002 The value is a percentage of the size of the parent frame.
    case percentageOfParentFrame = 0x00000002
    
    /// iFssUnitsRel 0x00000003 The value is a relative position. The actual position is a fraction of the parent frame size with this value as the
    /// numerator and the sum of all relative sizes for this row or column as the denominator.
    case relativePosition = 0x00000003
}
