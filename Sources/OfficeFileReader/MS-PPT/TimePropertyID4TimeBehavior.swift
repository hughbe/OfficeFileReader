//
//  TimePropertyID4TimeBehavior.swift
//  
//
//  Created by Hugh Bellamy on 22/11/2020.
//

/// [MS-PPT] 2.13.37 TimePropertyID4TimeBehavior
// Referenced by: TimeVariant4Behavior
// An enumeration that specifies the type of attributes for an animation behavior.
public enum TimePropertyID4TimeBehavior: UInt32 {
    /// TL_TBPID_UnknownPropertyList 0x00000001 Unknown property list.
    case unknownPropertyList = 0x00000001

    /// TL_TBPID_RuntimeContext 0x00000002 Runtime context that specifies which versions of the application can run the behavior.
    case runtimeContext = 0x00000002

    /// TL_TBPID_MotionPathEditRelative 0x00000003 Whether a motion path moves with the object that it applies to during editing.
    case motionPathEditRelative = 0x00000003

    /// TL_TBPID_ColorColorModel 0x00000004 Color model of a color animation.
    case colorColorModel = 0x00000004

    /// TL_TBPID_ColorDirection 0x00000005 Color direction of a color animation.
    case colorDirection = 0x00000005

    /// TL_TBPID_Override 0x00000006 How to override animated values.
    case override = 0x00000006

    /// TL_TBPID_PathEditRotationAngle 0x00000007 Rotation angle of a motion path.
    case pathEditRotationAngle = 0x00000007

    /// TL_TBPID_PathEditRotationX 0x00000008 Horizontal position of the rotation center of the motion path.
    case pathEditRotationX = 0x00000008

    /// TL_TBPID_PathEditRotationY 0x00000009 Vertical position of the rotation center of the motion path.
    case pathEditRotationY = 0x00000009

    /// TL_TBPID_PointsTypes 0x0000000A The type of points in the motion path.
    case pointTypes = 0x0000000A
}
