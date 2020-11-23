//
//  DiagramBuildEnum.swift
//  
//
//  Created by Hugh Bellamy on 22/11/2020.
//

/// [MS-PPT] 2.13.7 DiagramBuildEnum
/// Referenced by: DiagramBuildAtom
/// An enumeration that specifies the animation diagram build type to be applied to a diagram.
public enum DiagramBuildEnum: UInt32 {
    /// TLDB_AsOneObject 0x00000000 The diagram and all corresponding parts animate as one graphical object.
    case asOneObject = 0x00000000
    
    /// TLDB_DepthByNode 0x00000001 The root shape of the diagram animates first, followed by its branches from left to right. For each branch,
    /// the root shape of the branch animates first, followed by the branches of this branch. This process is recursive for each shape in the diagram.
    case depthByNode = 0x00000001
    
    /// TLDB_DepthByBranch 0x00000002 The root shape of the diagram animates first, followed by its branches from left to right; and each of its
    /// branches animates as one graphical object.
    case depthByBranch = 0x00000002
    
    /// TLDB_BreadthByNode 0x00000003 The root shape of the diagram animates first, followed by its levels from top to bottom. Shapes in each
    /// level animate separately from left to right.
    case breadthByNode = 0x00000003
    
    /// TLDB_BreadthByLevel 0x00000004 The root shape of the diagram animates first, followed by its levels from top to bottom. Each level animates
    /// as one graphical object.
    case breadthByLevel = 0x00000004
    
    /// TLDB_ClockWise 0x00000005 Shapes in the diagram animate in the clockwise direction.
    case clockWise = 0x00000005
    
    /// TLDB_ClockWiseIn 0x00000006 Shapes in the diagram animate in the clockwise direction. Shapes animate inwardly starting from the outermost
    /// ring.
    case clockWiseIn = 0x00000006
    
    /// TLDB_ClockWiseOut 0x00000007 Shapes in the diagram animate in the clockwise direction. Shapes animate outwardly starting from the
    /// innermost ring.
    case clockWiseOut = 0x00000007
    
    /// TLDB_CounterClockWise 0x00000008 Shapes in the diagram animate in the counterclockwise direction.
    case counterClockWise = 0x00000008
    
    /// TLDB_CounterClockWiseIn 0x00000009 Shapes in the diagram animate in the counterclockwise direction. Shapes animate inwardly starting
    /// from the outermost ring.
    case counterClockWiseIn = 0x00000009
    
    /// TLDB_CounterClockWiseOut 0x0000000A Shapes in the diagram animate in the counterclockwise direction. Shapes animate outwardly starting
    /// from the innermost ring.
    case counterClockWiseOut = 0x0000000A
    
    /// TLDB_InByRing 0x0000000B Rings in the diagram animate from the outside to the inside. All shapes in each ring animate at the same time.
    case inByRing = 0x0000000B
    
    /// TLDB_OutByRing 0x0000000C Rings in the diagram animate from the inside to the outside. All shapes in each ring animate at the same time.
    case outByRing = 0x0000000C
    
    /// TLDB_Up 0x0000000D Shapes in the diagram animate from bottom to top.
    case up = 0x0000000D
    
    /// TLDB_Down 0x0000000E Shapes in the diagram animate from top to bottom.
    case down = 0x0000000E
    
    /// TLDB_AllAtOnce 0x0000000F All shapes in the diagram animate at the same time.
    case allAtOnce = 0x0000000F
    
    /// TLDB_Custom 0x00000010 Shapes in the diagram animate in a custom way not otherwise specified by one of the allowed diagram build types.
    case custom = 0x00000010
}
