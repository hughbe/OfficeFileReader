//
//  TimeBehaviorContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.34 TimeBehaviorContainer
/// Referenced by: TimeAnimateBehaviorContainer, TimeColorBehaviorContainer, TimeCommandBehaviorContainer, TimeEffectBehaviorContainer,
/// TimeMotionBehaviorContainer, TimeRotationBehaviorContainer, TimeScaleBehaviorContainer, TimeSetBehaviorContainer
/// A container record that specifies the common information of an animation behavior.
public struct TimeBehaviorContainer {
    public let rh: RecordHeader
    public let behaviorAtom: TimeBehaviorAtom
    public let stringList: TimeStringListContainer?
    public let propertyList: TimePropertyList4TimeBehavior?
    public let clientVisualElement: ClientVisualElementContainer
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_TimeBehaviorContainer.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .timeBehaviorContainer else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// behaviorAtom (24 bytes): A TimeBehaviorAtom record that specifies the type of transform used in the animation, how to compose animated
        /// values, and which attributes of this field and this TimeBehaviorContainer record are valid.
        self.behaviorAtom = try TimeBehaviorAtom(dataStream: &dataStream)
        
        /// stringList (variable): An optional TimeStringListContainer record (section 2.8.36) that specifies the list of the names of properties to be
        /// animated. It MUST be ignored if behaviorAtom.fAttributeNamesPropertyUsed is FALSE.
        if try dataStream.peekRecordHeader().recType == .timeVariantList {
            self.stringList = try TimeStringListContainer(dataStream: &dataStream)
        } else {
            self.stringList = nil
        }
        
        /// propertyList (variable): An optional TimePropertyList4TimeBehavior record that specifies a list of animation attributes that are used in the
        /// animation behavior.
        if try dataStream.peekRecordHeader().recType == .timePropertyList {
            self.propertyList = try TimePropertyList4TimeBehavior(dataStream: &dataStream)
        } else {
            self.propertyList = nil
        }
        
        /// clientVisualElement (variable): A ClientVisualElementContainer record (section 2.8.44) that specifies the target object that is animated.
        self.clientVisualElement = try ClientVisualElementContainer(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
