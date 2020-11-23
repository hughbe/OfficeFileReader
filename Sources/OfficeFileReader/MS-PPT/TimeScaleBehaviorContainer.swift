//
//  TimeScaleBehaviorContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.67 TimeScaleBehaviorContainer
/// Referenced by: ExtTimeNodeContainer
/// A container record that specifies a scale behavior that animates the size of an object. This animation behavior is applied to the object specified by the
/// behavior.clientVisualElement field and used to animate two properties including "ScaleX" and "ScaleY" from the list that is specified in the
/// TimeStringListContainer record (section 2.8.36). The behavior.stringList field is ignored.
public struct TimeScaleBehaviorContainer {
    public let rh: RecordHeader
    public let scaleBehaviorAtom: TimeScaleBehaviorAtom
    public let behavior: TimeBehaviorContainer
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_TimeScaleBehaviorContainer.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .timeScaleBehaviorContainer else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// scaleBehaviorAtom (40 bytes): A TimeScaleBehaviorAtom record that specifies how to scale the size of an object and which attributes within
        /// this field are valid.
        self.scaleBehaviorAtom = try TimeScaleBehaviorAtom(dataStream: &dataStream)
        
        /// behavior (variable): A TimeBehaviorContainer record (section 2.8.34) that specifies the common behavior information.
        self.behavior = try TimeBehaviorContainer(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
