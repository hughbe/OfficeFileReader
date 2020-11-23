//
//  AnimBuildTypeEnum.swift
//  
//
//  Created by Hugh Bellamy on 23/11/2020.
//

/// [MS-PPT] 2.13.2 AnimBuildTypeEnum
/// Referenced by: AnimationInfoAtom
/// An enumeration that specifies animation build types.
public enum AnimBuildTypeEnum: UInt8 {
    /// BT_FollowMaster 0xFE The shape follows the build type of the placeholder shape on its main master slide or its title master slide.
    case followMaster = 0xFE
    
    /// BT_NoBuild 0x00 No build for the shape.
    case noBuild = 0x00
    
    /// BT_OneBuild 0x01 The shape animates in its entirety.
    case oneBuild = 0x01
    
    /// BT_Level1Build 0x02 Each paragraph of level 1 animates separately, and paragraphs of all other levels animate at the same time as their level 1
    /// paragraphs.
    case level1Build = 0x02
    
    /// BT_Level2Build 0x03 Each paragraph from level 1 to level 2 animates separately, and paragraphs of all other levels animate at the same time as
    /// their level 2 paragraphs.
    case level2Build = 0x03
    
    /// BT_Level3Build 0x04 Each paragraph from level 1 to level 3 animates separately, and paragraphs of all other levels animate at the same time as
    /// their level 3 paragraphs.
    case level3Build = 0x04
    
    /// BT_Level4Build 0x05 Each paragraph from level 1 to level 4 animates separately, and paragraphs of level 5 animate at the same time as their
    /// level 4 paragraphs.
    case level4Build = 0x05
    
    /// BT_Level5Build 0x06 Each paragraph from level 1 to level 5 animates separately.
    case level5Build = 0x06
    
    /// BT_GraphBySeries 0x07 Each series animates separately, and all elements in each series animate at the same time.
    case graphBySeries = 0x07
    
    /// BT_GraphByCategory 0x08 Each category animates separately, and all elements in each category animate at the same time.
    case graphByCategory = 0x08
    
    /// BT_GraphByElementInSeries 0x09
    /// Elements in the chart animate in the following order:
    /// Element in series 1 and category 1
    /// Element in series 1 and category 2
    /// Element in series 1 and category 3
    /// …
    /// Element in series 2 and category 1
    /// Element in series 2 and category 2
    /// Element in series 2 and category 3
    /// …
    /// Element in series 3 and category 1
    /// Element in series 3 and category 2
    /// Element in series 3 and category 3
    /// …
    /// BT_GraphByElementInCategory 0x0A
    /// Elements in the chart animate in the following order:
    /// Element in category 1 and series 1
    /// Element in category 1 and series 2
    /// Element in category 1 and series 3
    /// …
    /// Element in category 2 and series 1
    /// Element in category 2 and series 2
    /// Element in category 2 and series 3
    /// …
    /// Element in category 3 and series 1
    /// Element in category 3 and series 2
    /// Element in category 3 and series 3
    /// …
    case graphByElementInSeries = 0x09
}
