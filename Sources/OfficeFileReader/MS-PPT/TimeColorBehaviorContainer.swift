//
//  TimeColorBehaviorContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.52 TimeColorBehaviorContainer
/// Referenced by: ExtTimeNodeContainer, SubEffectContainer
/// A container record that specifies a behavior that changes the color of an object. This animation behavior is applied to the object specified by the
/// behavior.clientVisualElement field and used to animate one property specified by the behavior.stringList field. The property MUST be one from the
/// following list that is a subset of the properties specified in the TimeStringListContainer record (section 2.8.36): "ppt_c", "style.color",
/// "imageData.chromakey", "fill.color", "fill.color2", "stroke.color", "stroke.color2", "shadow.color", "shadow.color2", "extrusion.color", and "fillcolor".
public struct TimeColorBehaviorContainer {
    public let rh: RecordHeader
    public let colorBehaviorAtom: TimeColorBehaviorAtom
    public let behavior: TimeBehaviorContainer
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_TimeColorBehaviorContainer.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .timeColorBehaviorContainer else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// colorBehaviorAtom (60 bytes): A TimeColorBehaviorAtom record that specifies how to change the color of the object and which attributes
        /// within this field are valid.
        self.colorBehaviorAtom = try TimeColorBehaviorAtom(dataStream: &dataStream)
        
        /// behavior (variable): A TimeBehaviorContainer record (section 2.8.34) that specifies the common behavior information.
        self.behavior = try TimeBehaviorContainer(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
