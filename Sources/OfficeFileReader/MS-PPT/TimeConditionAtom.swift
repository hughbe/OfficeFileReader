//
//  TimeConditionAtom.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.76 TimeConditionAtom
/// Referenced by: TimeConditionContainer
/// An atom record that specifies the information used to evaluate when a condition will be true.
public struct TimeConditionAtom {
    public let rh: RecordHeader
    public let triggerObject: TriggerObjectEnum
    public let triggerEvent: TriggerEvent
    public let id: UInt32
    public let delay: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_TimeCondition.
        /// rh.recLen MUST be 0x00000010.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .timeCondition else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000010 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// triggerObject (4 bytes): A TriggerObjectEnum enumeration that specifies the type of target that participates in the evaluation of the condition.
        guard let triggerObject = TriggerObjectEnum(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.triggerObject = triggerObject
        
        /// triggerEvent (4 bytes): An unsigned integer that specifies the event that causes the condition to be TRUE. It MUST be a value from the
        /// following table.
        guard let triggerEvent = TriggerEvent(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.triggerEvent = triggerEvent
        
        /// id (4 bytes): An unsigned integer that specifies the target that participates in the evaluation of the condition.
        /// When triggerObject is TL_TOT_TimeNode, this field specifies the time node identifier.
        /// When triggerObject is TL_TOT_RuntimeNodeRef, this field MUST be 0x00000002 that specifies that all child time node of the
        /// ExtTimeNodeContainer record (section 2.8.15) or SubEffectContainer record (section 2.8.16) that contains this record are the target.
        self.id = try dataStream.read(endianess: .littleEndian)
        
        /// delay (4 bytes): A signed integer that specifies the offset time, in milliseconds, that sets when the condition will become TRUE.
        self.delay = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
    
    /// triggerEvent (4 bytes): An unsigned integer that specifies the event that causes the condition to be TRUE. It MUST be a value from the
    /// following table.
    public enum TriggerEvent: UInt32 {
        /// 0x00000000 None.
        case none = 0x00000000
        
        /// 0x00000001 OnBegin event that occurs on the specified target.
        case onBeginEvent = 0x00000001
        
        /// 0x00000003 Start of the time node that is specified by id.
        case startOfTimeNode = 0x00000003
        
        /// 0x00000004 End of the time node that is specified by id.
        case endOfTimeNode = 0x00000004
        
        /// 0x00000005 Mouse click.
        case mouseClick = 0x00000005
        
        /// 0x00000007 Mouse over.
        case mouseOver = 0x00000007
        
        /// 0x00000009 OnNext event that occurs on the specified target.
        case onNextEvent = 0x00000009
        
        /// 0x0000000A OnPrev event that occurs on the specified target.c
        case onPrevEvent = 0x0000000A
        
        /// 0x0000000B Stop audio event that occurs when an "onstopaudio" command is fired.
        case stopAudioEvent = 0x0000000B
    }
}
