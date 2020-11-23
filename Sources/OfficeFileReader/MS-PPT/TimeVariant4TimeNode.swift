//
//  TimeVariant4TimeNode.swift
//  
//
//  Created by Hugh Bellamy on 22/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.19 TimeVariant4TimeNode
/// Referenced by: TimePropertyList4TimeNodeContainer
/// A variable type record that specifies an attribute of a time node and whose type and meaning are specified by the value of the rh.recInstance field,
/// as specified in the following table.
public enum TimeVariant4TimeNode {
    /// TL_TPID_Display A TimeDisplayType record that specifies the visibility of the time node in the user interface.
    case display(data: TimeDisplayType)
    
    /// TL_TPID_MasterPos A TimeMasterRelType record that specifies the relationship of a subordinate time node to its master time node.
    case masterPos(data: TimeMasterRelType)
    
    /// TL_TPID_SubType A TimeSubType record that specifies the type of subordinate time node.
    case subType(data: TimeSubType)
    
    /// TL_TPID_EffectID A TimeEffectID record that specifies an identifier of an animation effect.
    case effectID(data: TimeEffectID)
    
    /// TL_TPID_EffectDir A TimeVariantInt record that specifies the direction or other attributes of an animation effect. The values for each animation
    /// effect are specified in the TimeEffectID record.
    case effectDir(data: TimeVariantInt)
    
    /// TL_TPID_EffectType A TimeEffectType record that specifies the type of animation effect.
    case effectType(data: TimeEffectType)
    
    /// TL_TPID_AfterEffect A TimeVariantBool record that specifies whether the time node is an after effect.
    case afterEffect(data: TimeVariantBool)
    
    /// TL_TPID_SlideCount A TimeVariantInt record that specifies the number of slides that a media will play across.
    case slideCount(data: TimeVariantInt)
    
    /// TL_TPID_TimeFilter A TimeNodeTimeFilter record that specifies a time filter that transforms a given time to the local time of a time node.
    case timeFilter(data: TimeNodeTimeFilter)
    
    /// TL_TPID_EventFilter A TimeEventFilter structure that specifies an event filter for a time node.
    case eventFilter(data: TimeEventFilter)
    
    /// TL_TPID_HideWhenStopped A TimeVariantBool structure that specifies whether to display the media when it is stopped.
    case hideWhenStopped(data: TimeVariantBool)
    
    /// TL_TPID_GroupID A TimeGroupID structure that specifies a reference to a build identifier of an animation effect.
    case groupID(data: TimeGroupID)
    
    /// TL_TPID_EffectNodeType A TimeEffectNodeType structure that specifies the role of a time node in the timing structure.
    case effectNodeType(data: TimeEffectNodeType)
    
    /// TL_TPID_PlaceholderNode A TimeVariantBool structure that specifies whether the time node is a placeholder node that is not played during
    /// a slide show.
    case placeholderNode(data: TimeVariantBool)
    
    /// TL_TPID_MediaVolume A TimeVariantFloat structure that specifies the volume of a media. The floatValue sub-field MUST be greater than or
    /// equal to 0 and less than or equal to 100000.
    case mediaVolume(data: TimeVariantFloat)
    
    /// TL_TPID_MediaMute A TimeVariantBool structure that specifies whether a media is muted.
    case mediaMute(data: TimeVariantBool)
    
    /// TL_TPID_ZoomToFullScreen A TimeVariantBool structure that specifies whether to zoom a media to full screen when it plays.
    case zoomToFullScreen(data: TimeVariantBool)
    
    public init(dataStream: inout DataStream) throws {
        let rh = try dataStream.peekRecordHeader()
        guard rh.recType == .timeVariant else {
            throw OfficeFileError.corrupted
        }
        guard let type = TimePropertyID4TimeNode(rawValue: UInt32(rh.recInstance)) else {
            throw OfficeFileError.corrupted
        }
        
        switch type {
        case .display:
            self = .display(data: try TimeDisplayType(dataStream: &dataStream))
        case .masterPos:
            self = .masterPos(data: try TimeMasterRelType(dataStream: &dataStream))
        case .subType:
            self = .subType(data: try TimeSubType(dataStream: &dataStream))
        case .effectID:
            self = .effectID(data: try TimeEffectID(dataStream: &dataStream))
        case .effectDir:
            self = .effectDir(data: try TimeVariantInt(dataStream: &dataStream))
        case .effectType:
            self = .effectType(data: try TimeEffectType(dataStream: &dataStream))
        case .afterEffect:
            self = .afterEffect(data: try TimeVariantBool(dataStream: &dataStream))
        case .slideCount:
            self = .slideCount(data: try TimeVariantInt(dataStream: &dataStream))
        case .timeFilter:
            self = .timeFilter(data: try TimeNodeTimeFilter(dataStream: &dataStream))
        case .eventFilter:
            self = .eventFilter(data: try TimeEventFilter(dataStream: &dataStream))
        case .hideWhenStopped:
            self = .hideWhenStopped(data: try TimeVariantBool(dataStream: &dataStream))
        case .groupID:
            self = .groupID(data: try TimeGroupID(dataStream: &dataStream))
        case .effectNodeType:
            self = .effectNodeType(data: try TimeEffectNodeType(dataStream: &dataStream))
        case .placeholderNode:
            self = .placeholderNode(data: try TimeVariantBool(dataStream: &dataStream))
        case .mediaVolume:
            self = .mediaVolume(data: try TimeVariantFloat(dataStream: &dataStream))
        case .mediaMute:
            self = .mediaMute(data: try TimeVariantBool(dataStream: &dataStream))
        case .zoomToFullScreen:
            self = .zoomToFullScreen(data: try TimeVariantBool(dataStream: &dataStream))
        }
    }
}
