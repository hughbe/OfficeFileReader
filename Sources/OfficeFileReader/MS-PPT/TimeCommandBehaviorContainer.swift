//
//  TimeCommandBehaviorContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.71 TimeCommandBehaviorContainer
/// Referenced by: ExtTimeNodeContainer, SubEffectContainer
/// A container record that specifies a command behavior that performs a command as an animation.
/// There is no property to be animated in this behavior. The behavior.stringList field is ignored.
public struct TimeCommandBehaviorContainer {
    public let rh: RecordHeader
    public let commandBehaviorAtom: TimeCommandBehaviorAtom
    public let varCommand: TimeVariantString?
    public let behavior: TimeBehaviorContainer
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_TimeCommandBehaviorContainer.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .timeCommandBehaviorContainer else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// commandBehaviorAtom (16 bytes): A TimeCommandBehaviorAtom record that specifies the property usage flag of the command behavior
        /// and the type of the command behavior.
        self.commandBehaviorAtom = try TimeCommandBehaviorAtom(dataStream: &dataStream)
        
        /// varCommand (variable): An optional TimeVariantString record that specifies the command to be performed. It MUST be ignored if
        /// commandBehaviorAtom.fCommandPropertyUsed is FALSE.
        /// The varCommand.rh.recInstance sub-field MUST be 0x001.
        /// When commandBehaviorAtom.commandBehaviorType is TL_TCBT_Event, the command MUST be "onstopaudio" that specifies to stop
        /// playing of all audio.
        /// When commandBehaviorAtom.commandBehaviorType is TL_TCBT_Call, the command MUST be one from the following table.
        /// Command Meaning
        /// play Play corresponding media.
        /// playFrom(s) Play corresponding media starting from s, where s is the number of seconds from the beginning of the clip.
        /// pause Pause corresponding media.
        /// resume Resume playing of corresponding media.
        /// stop Stop playing of corresponding media.
        /// togglePause Play corresponding media if media is paused, or pause corresponding media if media is playing. If the corresponding media
        /// is not active, this command will restart the media and play from its beginning.
        /// When commandBehaviorAtom.commandBehaviorType is TL_TCBT_OleVerb, the command MUST be the string representation of an
        /// integer that specifies the embedded object verb number that determines the action.
        if try dataStream.peekRecordHeader().recType == .timeVariant {
            self.varCommand = try TimeVariantString(dataStream: &dataStream)
        } else {
            self.varCommand =  nil
        }
        
        /// behavior (variable): A TimeBehaviorContainer record (section 2.8.34) that specifies the common behavior information.
        self.behavior = try TimeBehaviorContainer(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
