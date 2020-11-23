//
//  BuildTypeEnum.swift
//  
//
//  Created by Hugh Bellamy on 21/11/2020.
//

/// [MS-PPT] 2.13.3 BuildTypeEnum
/// Referenced by: BuildAtom
/// An enumeration that specifies different types of builds.
public enum BuildTypeEnum: UInt32 {
    /// TL_BuildParagraph 0x00000001 Paragraph build type.
    case paragraph = 0x00000001
    
    /// TL_BuildChart 0x00000002 Chart build type.
    case chart = 0x00000002
    
    /// TL_BuildDiagram 0x00000003 Diagram build type.
    case diagram = 0x00000003
}
