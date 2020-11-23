//
//  TimeVariant4Behavior.swift
//  
//
//  Created by Hugh Bellamy on 22/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.38 TimeVariant4Behavior
/// Referenced by: TimePropertyList4TimeBehavior
/// A variable type record that specifies an attribute of an animation behavior and whose type and meaning are dictated by the value of the rh.recInstance
/// field of any of these attributes, as specified in the following table.
public enum TimeVariant4Behavior {
    /// TL_TBPID_UnknownPropertyList A TimeVariantString record that specifies unknown attributes.
    case unknownPropertyList(data: TimeVariantString)
    
    /// TL_TBPID_RuntimeContext A TimeRuntimeContext record that specifies which versions of the hosting applications can run this behavior.
    case runtimeContext(data: TimeRuntimeContext)
    
    /// TL_TBPID_MotionPathEditRelative A TimeVariantBool record that specifies whether a motion path moves along with the object that it applies to
    /// during editing. This record is only used by the TimeMotionBehaviorContainer record (section 2.8.63).
    case motionPathEditRelative(data: TimeVariantBool)
    
    /// TL_TBPID_ColorColorModel A TimeColorModel record that specifies the color model. This record is only used by the TimeColorBehaviorContainer
    /// record (section 2.8.52).
    case colorColorModel(data: TimeColorModel)
    
    /// TL_TBPID_ColorDirection A TimeColorDirection record that specifies the interpolation direction in the HSL color space. This record is only used
    /// by the TimeColorBehaviorContainer record.
    case colorDirection(data: TimeColorDirection)
    
    /// TL_TBPID_Override A TimeOverride record that specifies how to override animated values.
    case override(data: TimeOverride)
    
    /// TL_TBPID_PathEditRotationAngle A TimeVariantFloat record that specifies the rotation angle of a motion path. This record is only used by the
    /// TimeMotionBehaviorContainer record.
    case pathEditRotationAngle(data: TimeVariantFloat)

    /// TL_TBPID_PathEditRotationX A TimeVariantFloat record that specifies the horizontal position of the rotation center of a motion path. This record
    /// is only used by the TimeMotionBehaviorContainer record.
    case pathEditRotationX(data: TimeVariantFloat)
    
    /// TL_TBPID_PathEditRotationY A TimeVariantFloat record that specifies the vertical position of the rotation center of a motion path. This record
    /// is only used by the TimeMotionBehaviorContainer record.
    case pathEditRotationY(data: TimeVariantFloat)
    
    /// TL_TBPID_PointsTypes A TimePointsTypes record that specifies the type of points in a motion path. This record is only used by the
    /// TimeMotionBehaviorContainer record.
    case pointTypes(data: TimePointsTypes)
    
    public init(dataStream: inout DataStream) throws {
        let rh = try dataStream.peekRecordHeader()
        guard rh.recType == .timeVariant else {
            throw OfficeFileError.corrupted
        }
        guard let id = TimePropertyID4TimeBehavior(rawValue: UInt32(rh.recInstance)) else {
            throw OfficeFileError.corrupted
        }
        
        switch id {
        case .unknownPropertyList:
            self = .unknownPropertyList(data: try TimeVariantString(dataStream: &dataStream))
        case .runtimeContext:
            self = .runtimeContext(data: try TimeRuntimeContext(dataStream: &dataStream))
        case .motionPathEditRelative:
            self = .motionPathEditRelative(data: try TimeVariantBool(dataStream: &dataStream))
        case .colorColorModel:
            self = .colorColorModel(data: try TimeColorModel(dataStream: &dataStream))
        case .colorDirection:
            self = .colorDirection(data: try TimeColorDirection(dataStream: &dataStream))
        case .override:
            self = .override(data: try TimeOverride(dataStream: &dataStream))
        case .pathEditRotationAngle:
            self = .pathEditRotationAngle(data: try TimeVariantFloat(dataStream: &dataStream))
        case .pathEditRotationX:
            self = .pathEditRotationX(data: try TimeVariantFloat(dataStream: &dataStream))
        case .pathEditRotationY:
            self = .pathEditRotationY(data: try TimeVariantFloat(dataStream: &dataStream))
        case .pointTypes:
            self = .pointTypes(data: try TimePointsTypes(dataStream: &dataStream))
        }
    }
}
