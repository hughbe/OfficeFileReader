//
//  SubEffectContainer.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.16 SubEffectContainer
/// A container record that specifies a subordinate time node whose start time depends on the relation to its master time node.
/// At most one of the following fields MUST exist: timeColorBehavior, timeSetBehavior, or timeCommandBehavior.
public struct SubEffectContainer {
    public let rh: RecordHeader
    public let timeNodeAtom: TimeNodeAtom
    public let timePropertyList: TimePropertyList4TimeNodeContainer?
    public let timeColorBehavior: TimeColorBehaviorContainer?
    public let timeSetBehavior: TimeSetBehaviorContainer?
    public let timeCommandBehavior: TimeCommandBehaviorContainer?
    public let clientVisualElement: ClientVisualElementContainer?
    public let rgBeginTimeCondition: [TimeConditionContainer]
    public let rgEndTimeCondition: [TimeConditionContainer]
    public let rgTimeModifierAtom: [TimeModifierAtom]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x001.
        /// rh.recType MUST be an RT_TimeSubEffectContainer.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x001 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .timeSubEffectContainer else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// timeNodeAtom (40 bytes): A TimeNodeAtom record that specifies time-based attributes of this time node.
        self.timeNodeAtom = try TimeNodeAtom(dataStream: &dataStream)
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.timePropertyList = nil
            self.timeColorBehavior = nil
            self.timeSetBehavior = nil
            self.timeCommandBehavior = nil
            self.clientVisualElement = nil
            self.rgBeginTimeCondition = []
            self.rgEndTimeCondition = []
            self.rgTimeModifierAtom = []
            return
        }
        
        /// timePropertyList (variable): An optional TimePropertyList4TimeNodeContainer record (section 2.8.18) that specifies a list of attributes of the
        /// subordinate time node.
        if try dataStream.peekRecordHeader().recType == .timePropertyList {
            self.timePropertyList = try TimePropertyList4TimeNodeContainer(dataStream: &dataStream)
        } else {
            self.timePropertyList = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.timeColorBehavior = nil
            self.timeSetBehavior = nil
            self.timeCommandBehavior = nil
            self.clientVisualElement = nil
            self.rgBeginTimeCondition = []
            self.rgEndTimeCondition = []
            self.rgTimeModifierAtom = []
            return
        }
        
        /// timeColorBehavior (variable): An optional TimeColorBehaviorContainer record (section 2.8.52) that specifies a color animation behavior that
        /// changes the color of an object. It MUST exist only if timeNodeAtom.type is TL_TNT_Behavior.
        if try dataStream.peekRecordHeader().recType == .timeColorBehaviorContainer {
            self.timeColorBehavior = try TimeColorBehaviorContainer(dataStream: &dataStream)
        } else {
            self.timeColorBehavior = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.timeSetBehavior = nil
            self.timeCommandBehavior = nil
            self.clientVisualElement = nil
            self.rgBeginTimeCondition = []
            self.rgEndTimeCondition = []
            self.rgTimeModifierAtom = []
            return
        }
        
        /// timeSetBehavior (variable): An optional TimeSetBehaviorContainer record (section 2.8.69) that specifies a set animation behavior that
        /// assigns a value to a property of an object. It MUST exist only if timeNodeAtom.type is TL_TNT_Behavior.
        if try dataStream.peekRecordHeader().recType == .timeSetBehaviorContainer {
            self.timeSetBehavior = try TimeSetBehaviorContainer(dataStream: &dataStream)
        } else {
            self.timeSetBehavior = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.timeCommandBehavior = nil
            self.clientVisualElement = nil
            self.rgBeginTimeCondition = []
            self.rgEndTimeCondition = []
            self.rgTimeModifierAtom = []
            return
        }
        
        /// timeCommandBehavior (variable): An optional TimeCommandBehaviorContainer record (section 2.8.71) that specifies a command-animation
        /// behavior that performs a command as an animation. It MUST exist if and only if the timeCommandBehavior.rh.recType field is
        /// RT_TimeCommandBehaviorContainer and the timeNodeAtom.type field is TL_TNT_Behavior.
        if try dataStream.peekRecordHeader().recType == .timeCommandBehaviorContainer {
            self.timeCommandBehavior = try TimeCommandBehaviorContainer(dataStream: &dataStream)
        } else {
            self.timeCommandBehavior = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.clientVisualElement = nil
            self.rgBeginTimeCondition = []
            self.rgEndTimeCondition = []
            self.rgTimeModifierAtom = []
            return
        }
        
        /// clientVisualElement (variable): An optional ClientVisualElementContainer record (section 2.8.44) that specifies a media to be played. It MUST
        /// exist only if timeNodeAtom.type is TL_TNT_Media.
        if try dataStream.peekRecordHeader().recType == .timeClientVisualElement {
            self.clientVisualElement = try ClientVisualElementContainer(dataStream: &dataStream)
        } else {
            self.clientVisualElement = nil
        }
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.rgBeginTimeCondition = []
            self.rgEndTimeCondition = []
            self.rgTimeModifierAtom = []
            return
        }
        
        /// rgBeginTimeCondition (variable): An optional array of TimeConditionContainer records (section 2.8.75) that specifies the time conditions. It
        /// MUST be used when the rh.recInstance field of a TimeConditionContainer record is TL_CT_Begin. Any of these time conditions determine
        /// when this subordinate time node will be activated.
        /// The array continues while the rh.recType field of the TimeConditionContainer record is equal to RT_TimeConditionContainer and the
        /// situation in the previous paragraph applies.
        var rgBeginTimeCondition: [TimeConditionContainer] = []
        while dataStream.position - startPosition < self.rh.recLen {
            let nextAtom = try dataStream.peekRecordHeader()
            guard nextAtom.recType == .timeConditionContainer else {
                break
            }
            guard nextAtom.recInstance != ConditionEnum.end.rawValue else {
                break
            }
            
            rgBeginTimeCondition.append(try TimeConditionContainer(dataStream: &dataStream))
        }
        
        self.rgBeginTimeCondition = rgBeginTimeCondition
        
        if dataStream.position - startPosition == self.rh.recLen {
            self.rgEndTimeCondition = []
            self.rgTimeModifierAtom = []
            return
        }
        
        /// rgEndTimeCondition (variable): An optional array of TimeConditionContainer records that specifies the time conditions. It MUST be used
        /// when the rh.recInstance field of a TimeConditionContainer item is TL_CT_End. Any of these time conditions determines when this
        /// subordinate time node will be deactivated.
        /// The array continues while the rh.recType field of the TimeConditionContainer record is equal to RT_TimeConditionContainer and the previous
        /// situation applies.
        var rgEndTimeCondition: [TimeConditionContainer] = []
        while dataStream.position - startPosition < self.rh.recLen {
            let nextAtom = try dataStream.peekRecordHeader()
            guard nextAtom.recType == .timeConditionContainer else {
                break
            }
            guard nextAtom.recInstance == ConditionEnum.end.rawValue else {
                break
            }
            
            rgEndTimeCondition.append(try TimeConditionContainer(dataStream: &dataStream))
        }
        
        self.rgEndTimeCondition = rgEndTimeCondition

        if dataStream.position - startPosition == self.rh.recLen {
            self.rgTimeModifierAtom = []
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

        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
