//
//  TimePropertyID4TimeNode.swift
//  
//
//  Created by Hugh Bellamy on 22/11/2020.
//

/// [MS-PPT] 2.13.38 TimePropertyID4TimeNode
/// Referenced by: TimeVariant4TimeNode
/// An enumeration that specifies the type of attributes for a time node.
public enum TimePropertyID4TimeNode: UInt32 {
    /// TL_TPID_Display 0x00000002 Display type in UI.
    case display = 0x00000002

    /// TL_TPID_MasterPos 0x00000005 Relationship to the master time node.
    case masterPos = 0x00000005

    /// TL_TPID_SubType 0x00000006 Type of the subordinate time node.
    case subType = 0x00000006

    /// TL_TPID_EffectID 0x00000009 Identifier of an animation effect.
    case effectID = 0x00000009

    /// TL_TPID_EffectDir 0x0000000A Direction of an animation effect.
    case effectDir = 0x0000000A

    /// TL_TPID_EffectType 0x0000000B Type of an animation effect.
    case effectType = 0x0000000B

    /// TL_TPID_AfterEffect 0x0000000D Whether the time node is an after effect.
    case afterEffect = 0x0000000D

    /// TL_TPID_SlideCount 0x0000000F The number of slides that a media will play across.
    case slideCount = 0x0000000F

    /// TL_TPID_TimeFilter 0x00000010 Time filtering for the time node.
    case timeFilter = 0x00000010

    /// TL_TPID_EventFilter 0x00000011 Event filtering for the time node.
    case eventFilter = 0x00000011

    /// TL_TPID_HideWhenStopped 0x00000012 Whether to display the media when it is stopped.
    case hideWhenStopped = 0x00000012

    /// TL_TPID_GroupID 0x00000013 Build identifier.
    case groupID = 0x00000013

    /// TL_TPID_EffectNodeType 0x00000014 The role of the time node in the timing structure.
    case effectNodeType = 0x00000014

    /// TL_TPID_PlaceholderNode 0x00000015 Whether the time node is a placeholder.
    case placeholderNode = 0x00000015

    /// TL_TPID_MediaVolume 0x00000016 The volume of a media.
    case mediaVolume = 0x00000016

    /// TL_TPID_MediaMute 0x00000017 Whether a media object is mute.
    case mediaMute = 0x00000017

    /// TL_TPID_ZoomToFullScreen 0x0000001A Whether to zoom a media object to full screen.
    case zoomToFullScreen = 0x0000001A

}
