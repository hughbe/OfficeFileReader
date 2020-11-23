//
//  TimeRotationBehaviorContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.65 TimeRotationBehaviorContainer
/// Referenced by: ExtTimeNodeContainer
/// A container record that specifies a rotation behavior that rotates an object. This animation behavior is applied to the object specified by the
/// behavior.clientVisualElement field and used to animate one property specified by the behavior.stringList field. The property MUST be "r" or
/// "ppt_r" from the list that is specified in the TimeStringListContainer record (section 2.8.36).
public struct TimeRotationBehaviorContainer {
    public let rh: RecordHeader
    public let rotationBehaviorAtom: TimeRotationBehaviorAtom
    public let behavior: TimeBehaviorContainer
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_TimeRotationBehaviorContainer.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .timeRotationBehaviorContainer else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// rotationBehaviorAtom (28 bytes): A TimeRotationBehaviorAtom record that specifies how to rotate the object and which attributes within
        /// this field are valid.
        self.rotationBehaviorAtom = try TimeRotationBehaviorAtom(dataStream: &dataStream)
        
        /// behavior (variable): A TimeBehaviorContainer record (section 2.8.34) that specifies the common behavior information.
        self.behavior = try TimeBehaviorContainer(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
