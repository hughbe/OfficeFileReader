//
//  ExtTimeNodeContainer.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.15 ExtTimeNodeContainer
/// Referenced by: ParaBuildLevel, PP10SlideBinaryTagExtension
/// A container record that specifies a time node. This time node is used to store all information necessary to cause a time-based or an action-based
/// effect to occur during a slide show. Each time node effect has a corresponding object to which the effect applies.
/// At most one of the following fields MUST exist: timeAnimateBehavior, timeColorBehavior, timeEffectBehavior, timeMotionBehavior,
/// timeRotationBehavior, timeScaleBehavior, timeSetBehavior, or timeCommandBehavior.
public struct ExtTimeNodeContainer {
    public let rh: RecordHeader
    public let timeNodeAtom: TimeNodeAtom
    public let timePropertyList: TimePropertyList4TimeNodeContainer?
    public let timeAnimateBehavior: TimeAnimateBehaviorContainer?
    public let timeColorBehavior: TimeColorBehaviorContainer?
    public let timeEffectBehavior: TimeEffectBehaviorContainer?
    public let timeMotionBehavior: TimeMotionBehaviorContainer?
    public let timeRotationBehavior: TimeRotationBehaviorContainer?
    public let timeScaleBehavior: TimeScaleBehaviorContainer?
    public let timeSetBehavior: TimeSetBehaviorContainer?
    public let timeCommandBehavior: TimeCommandBehaviorContainer?
    public let clientVisualElement: ClientVisualElementContainer?
    public let timeIterateDataAtom: TimeIterateDataAtom?
    public let timeSequenceDataAtom: TimeSequenceDataAtom?
    public let rgBeginTimeCondition: [TimeConditionContainer]
    public let rgEndTimeCondition: [TimeConditionContainer]
    public let timeEndSyncTimeCondition: TimeConditionContainer?
    public let rgTimeModifierAtom: [TimeModifierAtom]
    public let rgSubEffect: [SubEffectContainer]
    public let rgExtTimeNodeChildren: [ExtTimeNodeContainer]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x001.
        /// rh.recType MUST be an RT_TimeExtTimeNodeContainer.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x001 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .timeExtTimeNodeContainer else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// timeNodeAtom (40 bytes): A TimeNodeAtom record that specifies time-based attributes of this time node.
        self.timeNodeAtom = try TimeNodeAtom(dataStream: &dataStream)
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.timePropertyList = nil
            self.timeAnimateBehavior = nil
            self.timeColorBehavior = nil
            self.timeEffectBehavior = nil
            self.timeMotionBehavior = nil
            self.timeRotationBehavior = nil
            self.timeScaleBehavior = nil
            self.timeSetBehavior = nil
            self.timeCommandBehavior = nil
            self.clientVisualElement = nil
            self.timeIterateDataAtom = nil
            self.timeSequenceDataAtom = nil
            self.rgBeginTimeCondition = []
            self.rgEndTimeCondition = []
            self.timeEndSyncTimeCondition = nil
            self.rgTimeModifierAtom = []
            self.rgSubEffect = []
            self.rgExtTimeNodeChildren = []
            return
        }
        
        /// timePropertyList (variable): An optional TimePropertyList4TimeNodeContainer record (section 2.8.18) that specifies a list of attributes of the
        /// time node. timeAnimateBehavior (variable): An optional TimeAnimateBehaviorContainer record (section 2.8.29) that specifies a generic
        /// animation behavior that can animate any property of an object. It MUST exist only if timeNodeAtom.type is TL_TNT_Behavior.
        if try dataStream.peekRecordHeader().recType == .timePropertyList {
            self.timePropertyList = try TimePropertyList4TimeNodeContainer(dataStream: &dataStream)
        } else {
            self.timePropertyList = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.timeAnimateBehavior = nil
            self.timeColorBehavior = nil
            self.timeEffectBehavior = nil
            self.timeMotionBehavior = nil
            self.timeRotationBehavior = nil
            self.timeScaleBehavior = nil
            self.timeSetBehavior = nil
            self.timeCommandBehavior = nil
            self.clientVisualElement = nil
            self.timeIterateDataAtom = nil
            self.timeSequenceDataAtom = nil
            self.rgBeginTimeCondition = []
            self.rgEndTimeCondition = []
            self.timeEndSyncTimeCondition = nil
            self.rgTimeModifierAtom = []
            self.rgSubEffect = []
            self.rgExtTimeNodeChildren = []
            return
        }
        
        /// timeAnimateBehavior (variable): An optional TimeAnimateBehaviorContainer record (section 2.8.29) that specifies a generic animation
        /// behavior that can animate any property of an object. It MUST exist only if timeNodeAtom.type is TL_TNT_Behavior.
        if try dataStream.peekRecordHeader().recType == .timeAnimateBehaviorContainer {
            self.timeAnimateBehavior = try TimeAnimateBehaviorContainer(dataStream: &dataStream)
        } else {
            self.timeAnimateBehavior = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.timeColorBehavior = nil
            self.timeEffectBehavior = nil
            self.timeMotionBehavior = nil
            self.timeRotationBehavior = nil
            self.timeScaleBehavior = nil
            self.timeSetBehavior = nil
            self.timeCommandBehavior = nil
            self.clientVisualElement = nil
            self.timeIterateDataAtom = nil
            self.timeSequenceDataAtom = nil
            self.rgBeginTimeCondition = []
            self.rgEndTimeCondition = []
            self.timeEndSyncTimeCondition = nil
            self.rgTimeModifierAtom = []
            self.rgSubEffect = []
            self.rgExtTimeNodeChildren = []
            return
        }
        
        /// timeColorBehavior (variable): An optional TimeColorBehaviorContainer record (section 2.8.52) that specifies a color animation behavior
        /// that changes the color of an object. It MUST only if timeNodeAtom.type is TL_TNT_Behavior.
        if try dataStream.peekRecordHeader().recType == .timeColorBehaviorContainer {
            self.timeColorBehavior = try TimeColorBehaviorContainer(dataStream: &dataStream)
        } else {
            self.timeColorBehavior = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.timeEffectBehavior = nil
            self.timeMotionBehavior = nil
            self.timeRotationBehavior = nil
            self.timeScaleBehavior = nil
            self.timeSetBehavior = nil
            self.timeCommandBehavior = nil
            self.clientVisualElement = nil
            self.timeIterateDataAtom = nil
            self.timeSequenceDataAtom = nil
            self.rgBeginTimeCondition = []
            self.rgEndTimeCondition = []
            self.timeEndSyncTimeCondition = nil
            self.rgTimeModifierAtom = []
            self.rgSubEffect = []
            self.rgExtTimeNodeChildren = []
            return
        }
        
        /// timeEffectBehavior (variable): An optional TimeEffectBehaviorContainer record (section 2.8.61) that specifies an effect-animation behavior
        /// that transforms the image of an object. It MUST exist only if timeNodeAtom.type is TL_TNT_Behavior.
        if try dataStream.peekRecordHeader().recType == .timeEffectBehaviorContainer {
            self.timeEffectBehavior = try TimeEffectBehaviorContainer(dataStream: &dataStream)
        } else {
            self.timeEffectBehavior = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.timeMotionBehavior = nil
            self.timeRotationBehavior = nil
            self.timeScaleBehavior = nil
            self.timeSetBehavior = nil
            self.timeCommandBehavior = nil
            self.clientVisualElement = nil
            self.timeIterateDataAtom = nil
            self.timeSequenceDataAtom = nil
            self.rgBeginTimeCondition = []
            self.rgEndTimeCondition = []
            self.timeEndSyncTimeCondition = nil
            self.rgTimeModifierAtom = []
            self.rgSubEffect = []
            self.rgExtTimeNodeChildren = []
            return
        }
        
        /// timeMotionBehavior (variable): An optional TimeMotionBehaviorContainer record (section 2.8.63) that specifies a motion-animation
        /// behavior that moves a positioned object along a path. It MUST exist only if timeNodeAtom.type is TL_TNT_Behavior.
        if try dataStream.peekRecordHeader().recType == .timeMotionBehaviorContainer {
            self.timeMotionBehavior = try TimeMotionBehaviorContainer(dataStream: &dataStream)
        } else {
            self.timeMotionBehavior = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.timeRotationBehavior = nil
            self.timeScaleBehavior = nil
            self.timeSetBehavior = nil
            self.timeCommandBehavior = nil
            self.clientVisualElement = nil
            self.timeIterateDataAtom = nil
            self.timeSequenceDataAtom = nil
            self.rgBeginTimeCondition = []
            self.rgEndTimeCondition = []
            self.timeEndSyncTimeCondition = nil
            self.rgTimeModifierAtom = []
            self.rgSubEffect = []
            self.rgExtTimeNodeChildren = []
            return
        }
        
        /// timeRotationBehavior (variable): An optional TimeRotationBehaviorContainer record (section 2.8.65) that specifies a rotation animation
        /// behavior that rotates an object. It MUST exist only if timeNodeAtom.type is TL_TNT_Behavior.
        if try dataStream.peekRecordHeader().recType == .timeRotationBehaviorContainer {
            self.timeRotationBehavior = try TimeRotationBehaviorContainer(dataStream: &dataStream)
        } else {
            self.timeRotationBehavior = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.timeScaleBehavior = nil
            self.timeSetBehavior = nil
            self.timeCommandBehavior = nil
            self.clientVisualElement = nil
            self.timeIterateDataAtom = nil
            self.timeSequenceDataAtom = nil
            self.rgBeginTimeCondition = []
            self.rgEndTimeCondition = []
            self.timeEndSyncTimeCondition = nil
            self.rgTimeModifierAtom = []
            self.rgSubEffect = []
            self.rgExtTimeNodeChildren = []
            return
        }
        
        /// timeScaleBehavior (variable): An optional TimeScaleBehaviorContainer record (section 2.8.67) that specifies a scale-animation behavior
        /// that changes the size of an object. It MUST exist only if timeNodeAtom.type is TL_TNT_Behavior.
        if try dataStream.peekRecordHeader().recType == .timeScaleBehaviorContainer {
            self.timeScaleBehavior = try TimeScaleBehaviorContainer(dataStream: &dataStream)
        } else {
            self.timeScaleBehavior = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.timeSetBehavior = nil
            self.timeCommandBehavior = nil
            self.clientVisualElement = nil
            self.timeIterateDataAtom = nil
            self.timeSequenceDataAtom = nil
            self.rgBeginTimeCondition = []
            self.rgEndTimeCondition = []
            self.timeEndSyncTimeCondition = nil
            self.rgTimeModifierAtom = []
            self.rgSubEffect = []
            self.rgExtTimeNodeChildren = []
            return
        }
        
        /// timeSetBehavior (variable): An optional TimeSetBehaviorContainer record (section 2.8.69) that specifies a set-animation behavior that
        /// assigns a value to a property of an object. It MUST exist if timeNodeAtom.type is TL_TNT_Behavior.
        if try dataStream.peekRecordHeader().recType == .timeSetBehaviorContainer {
            self.timeSetBehavior = try TimeSetBehaviorContainer(dataStream: &dataStream)
        } else {
            self.timeSetBehavior = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.timeCommandBehavior = nil
            self.clientVisualElement = nil
            self.timeIterateDataAtom = nil
            self.timeSequenceDataAtom = nil
            self.rgBeginTimeCondition = []
            self.rgEndTimeCondition = []
            self.timeEndSyncTimeCondition = nil
            self.rgTimeModifierAtom = []
            self.rgSubEffect = []
            self.rgExtTimeNodeChildren = []
            return
        }
        
        /// timeCommandBehavior (variable): An optional TimeCommandBehaviorContainer record (section 2.8.71) that specifies a command-animation
        /// behavior that performs a command as an animation. It MUST exist only if timeNodeAtom.type field is TL_TNT_Behavior.
        if try dataStream.peekRecordHeader().recType == .timeCommandBehaviorContainer {
            self.timeCommandBehavior = try TimeCommandBehaviorContainer(dataStream: &dataStream)
        } else {
            self.timeCommandBehavior = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.clientVisualElement = nil
            self.timeIterateDataAtom = nil
            self.timeSequenceDataAtom = nil
            self.rgBeginTimeCondition = []
            self.rgEndTimeCondition = []
            self.timeEndSyncTimeCondition = nil
            self.rgTimeModifierAtom = []
            self.rgSubEffect = []
            self.rgExtTimeNodeChildren = []
            return
        }
        
        /// clientVisualElement (variable): An optional ClientVisualElementContainer record (section 2.8.44) that specifies a media file to be played.
        /// It MUST exist only if timeNodeAtom.type is TL_TNT_Media.
        if try dataStream.peekRecordHeader().recType == .timeClientVisualElement {
            self.clientVisualElement = try ClientVisualElementContainer(dataStream: &dataStream)
        } else {
            self.clientVisualElement = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.timeIterateDataAtom = nil
            self.timeSequenceDataAtom = nil
            self.rgBeginTimeCondition = []
            self.rgEndTimeCondition = []
            self.timeEndSyncTimeCondition = nil
            self.rgTimeModifierAtom = []
            self.rgSubEffect = []
            self.rgExtTimeNodeChildren = []
            return
        }
        
        /// timeIterateDataAtom (28 bytes): An optional TimeIterateDataAtom record that specifies how an animation is applied to the subelements
        /// of a target object for a repeated effect.
        if try dataStream.peekRecordHeader().recType == .timeIterateData {
            self.timeIterateDataAtom = try TimeIterateDataAtom(dataStream: &dataStream)
        } else {
            self.timeIterateDataAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.timeSequenceDataAtom = nil
            self.rgBeginTimeCondition = []
            self.rgEndTimeCondition = []
            self.timeEndSyncTimeCondition = nil
            self.rgTimeModifierAtom = []
            self.rgSubEffect = []
            self.rgExtTimeNodeChildren = []
            return
        }
        
        /// timeSequenceDataAtom (28 bytes): An optional TimeSequenceDataAtom record that specifies sequencing information for the child nodes
        /// of this time node. It MUST exist only if timeNodeAtom.type is TL_TNT_Sequential.
        if try dataStream.peekRecordHeader().recType == .timeSequenceData {
            self.timeSequenceDataAtom = try TimeSequenceDataAtom(dataStream: &dataStream)
        } else {
            self.timeSequenceDataAtom = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.rgBeginTimeCondition = []
            self.rgEndTimeCondition = []
            self.timeEndSyncTimeCondition = nil
            self.rgTimeModifierAtom = []
            self.rgSubEffect = []
            self.rgExtTimeNodeChildren = []
            return
        }
        
        /// rgBeginTimeCondition (variable): An optional array of TimeConditionContainer record (section 2.8.75) that specifies the time conditions that
        /// MUST be used in one of the following situations:
        ///  When the rh.recInstance field of a TimeConditionContainer record is TL_CT_Begin, any of these time conditions determines when this
        /// time node will be activated.
        ///  When the rh.recInstance field of a TimeConditionContainer record is TL_CT_Next and the timeNodeAtom.type field is TL_TNT_Sequential,
        /// any of these time conditions determines when the next child time node will be activated.
        /// The array continues while the rh.recType field of the TimeConditionContainer record is equal to RT_TimeConditionContainer and one of the
        /// two aforementioned situations applies.
        var rgBeginTimeCondition: [TimeConditionContainer] = []
        while dataStream.position - startPosition < self.rh.recLen {
            let nextAtom = try dataStream.peekRecordHeader()
            guard nextAtom.recType == .timeConditionContainer else {
                break
            }
            guard nextAtom.recInstance != ConditionEnum.end.rawValue &&
                    nextAtom.recInstance != ConditionEnum.previous.rawValue else {
                break
            }
            
            rgBeginTimeCondition.append(try TimeConditionContainer(dataStream: &dataStream))
        }
        
        self.rgBeginTimeCondition = rgBeginTimeCondition
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.rgEndTimeCondition = []
            self.timeEndSyncTimeCondition = nil
            self.rgTimeModifierAtom = []
            self.rgSubEffect = []
            self.rgExtTimeNodeChildren = []
            return
        }
        
        /// rgEndTimeCondition (variable): An optional array of TimeConditionContainer records (section 2.8.75) that specifies the time conditions that
        /// MUST be utilized in one of the following situations:
        ///  When the rh.recInstance field of a TimeConditionContainer record is TL_CT_End, any of these time conditions determines when this time
        /// node will be deactivated.
        ///  When the rh.recInstance field of a TimeConditionContainer record is TL_CT_Previous and the timeNodeAtom.type field is
        /// TL_TNT_Sequential, any of these time conditions determines when the next child time node will be deactivated.
        /// The array continues while the rh.recType field of the TimeConditionContainer record is equal to RT_TimeConditionContainer and one of the
        /// two aforementioned situations is applies.
        var rgEndTimeCondition: [TimeConditionContainer] = []
        while dataStream.position - startPosition < self.rh.recLen {
            let nextAtom = try dataStream.peekRecordHeader()
            guard nextAtom.recType == .timeConditionContainer else {
                break
            }
            guard nextAtom.recInstance != ConditionEnum.endSync.rawValue else {
                break
            }
            
            rgEndTimeCondition.append(try TimeConditionContainer(dataStream: &dataStream))
        }
        
        self.rgEndTimeCondition = rgEndTimeCondition
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.timeEndSyncTimeCondition = nil
            self.rgTimeModifierAtom = []
            self.rgSubEffect = []
            self.rgExtTimeNodeChildren = []
            return
        }
        
        /// timeEndSyncTimeCondition (variable): An optional TimeConditionContainer record (section 2.8.75) that specifies how to synchronize the
        /// stopping of the child nodes of this time node. The timeEndSyncTimeCondition.rh.recInstance sub-field MUST be TL_CT_EndSync.
        if try dataStream.peekRecordHeader().recType == .timeConditionContainer {
            let timeEndSyncTimeCondition = try TimeConditionContainer(dataStream: &dataStream)
            guard timeEndSyncTimeCondition.rh.recInstance == ConditionEnum.endSync.rawValue else {
                throw OfficeFileError.corrupted
            }

            self.timeEndSyncTimeCondition = timeEndSyncTimeCondition
        } else {
            self.timeEndSyncTimeCondition = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.rgTimeModifierAtom = []
            self.rgSubEffect = []
            self.rgExtTimeNodeChildren = []
            return
        }
        
        /// rgTimeModifierAtom (variable): An optional array of TimeModifierAtom records that specifies the modification records that store the type of
        /// data to be modified and the new data value. The array continues while the rh.recType field of the TimeModifierAtom record is equal to
        /// RT_TimeModifier.
        var rgTimeModifierAtom: [TimeModifierAtom] = []
        while dataStream.position - startPosition < self.rh.recLen {
            guard try dataStream.peekRecordHeader().recType == .timeModifier else {
                break
            }
            
            rgTimeModifierAtom.append(try TimeModifierAtom(dataStream: &dataStream))
        }
        
        self.rgTimeModifierAtom = rgTimeModifierAtom
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.rgSubEffect = []
            self.rgExtTimeNodeChildren = []
            return
        }
        
        /// rgSubEffect (variable): An optional array of SubEffectContainer that specifies the subordinate time nodes whose start time depends on the
        /// relation to this time node. The relationship is specified in the TimeMasterRelType record contained in the timePropertyList field of the
        /// SubEffectContainer record. The array continues while the rh.recType field of the SubEffectContainer record is equal to
        /// RT_TimeSubEffectContainer.
        var rgSubEffect: [SubEffectContainer] = []
        while dataStream.position - startPosition < self.rh.recLen {
            guard try dataStream.peekRecordHeader().recType == .timeSubEffectContainer else {
                break
            }
             
            rgSubEffect.append(try SubEffectContainer(dataStream: &dataStream))
        }
        
        self.rgSubEffect = rgSubEffect
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.rgExtTimeNodeChildren = []
            return
        }
        
        /// rgExtTimeNodeChildren (variable): An array of ExtTimeNodeContainer that specifies the child time nodes of this time node.
        var rgExtTimeNodeChildren: [ExtTimeNodeContainer] = []
        while dataStream.position - startPosition < self.rh.recLen {
            guard try dataStream.peekRecordHeader().recType == .timeExtTimeNodeContainer else {
                break
            }
            
            rgExtTimeNodeChildren.append(try ExtTimeNodeContainer(dataStream: &dataStream))
        }
        
        self.rgExtTimeNodeChildren = rgExtTimeNodeChildren

        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
