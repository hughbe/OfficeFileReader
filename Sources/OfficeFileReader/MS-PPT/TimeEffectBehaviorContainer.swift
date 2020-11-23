//
//  TimeEffectBehaviorContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.61 TimeEffectBehaviorContainer
/// Referenced by: ExtTimeNodeContainer
/// A container record that specifies an effect behavior that transforms the image of an object. The transformation provides the ability to perform transitions
/// on objects. There is no property to be animated in this behavior. The behavior.stringList field is ignored.
public struct TimeEffectBehaviorContainer {
    public let rh: RecordHeader
    public let effectBehaviorAtom: TimeEffectBehaviorAtom
    public let varType: TimeVariantString
    public let varProgress: TimeVariantFloat?
    public let varRuntimeContext: TimeVariantString?
    public let behavior: TimeBehaviorContainer
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_TimeEffectBehaviorContainer.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .timeEffectBehaviorContainer else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// effectBehaviorAtom (16 bytes): A TimeEffectBehaviorAtom record that specifies which attributes of this field and this
        /// TimeEffectBehaviorContainer are valid, and the transformation style of the object.
        self.effectBehaviorAtom = try TimeEffectBehaviorAtom(dataStream: &dataStream)
        
        /// varType (variable): A TimeVariantString record that specifies the object transitions for the effect.
        /// The varType.rh.recInstance sub-field MUST be 0x001. It MUST be ignored if effectBehaviorAtom.fTypePropertyUsed is FALSE.
        /// The varType.stringValue sub-field MUST be a value specified in the following table:
        /// Value Description
        /// blinds(horizontal)
        /// blinds(vertical)
        /// box(in)
        /// box(out)
        /// checkerboard(across)
        /// checkerboard(down)
        /// circle(in)
        /// circle(out)
        /// diamond(in)
        /// diamond(out)
        /// dissolve
        /// fade
        /// plus(in)
        /// plus(out)
        /// barn(inVertical)
        /// barn(inHorizontal)
        /// barn(outVertical)
        /// barn(outHorizontal)
        /// randombar(horizontal)
        /// randombar(vertical)
        /// strips(downLeft)
        /// strips(upLeft)
        /// strips(downRight)
        /// strips(upRight)
        /// wedge
        /// wheel(1)
        /// wheel(2)
        /// wheel(3)
        /// wheel(4)
        /// wheel(8)
        /// wipe(right)
        /// wipe(left)
        /// wipe(up)
        /// wipe(down)
        self.varType = try TimeVariantString(dataStream: &dataStream)
        
        /// varProgress (13 bytes): An optional TimeVariantFloat record that specifies the normalized time for which the state of the animation is
        /// displayed until the end time. It MUST be ignored if effectBehaviorAtom.fProgressPropertyUsed is FALSE. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// varProgress.rh.recInstance MUST be 0x002.
        /// varProgress.floatValue MUST be greater than or equal to 0, the normalized start time of the animation, and less than or equal to 1, the
        /// normalized end time of the animation.
        let nextAtom1 = try dataStream.peekRecordHeader()
        if nextAtom1.recType == .timeVariant && nextAtom1.recInstance == 0x002 {
            let varProgress = try TimeVariantFloat(dataStream: &dataStream)
            guard varProgress.floatValue >= 0 && varProgress.floatValue <= 1 else {
                throw OfficeFileError.corrupted
            }
            
            self.varProgress = varProgress
        } else {
            self.varProgress =  nil
        }
        
        /// varRuntimeContext (variable): An optional TimeVariantString record that specifies the runtime context. It MUST be ignored if
        /// effectBehaviorAtom.fRuntimeContextObsolete is FALSE. Subfields are further specified in the following table.
        /// Field Meaning
        /// varRuntimeContext.rh.recInstance MUST be 0x003.
        /// varRuntimeContext.stringValue MUST have a format as specified by the timeRuntimeContext field of the TimeRuntimeContext record
        let nextAtom2 = try dataStream.peekRecordHeader()
        if nextAtom2.recType == .timeVariant && nextAtom2.recInstance == 0x003 {
            self.varRuntimeContext = try TimeVariantString(dataStream: &dataStream)
        } else {
            self.varRuntimeContext =  nil
        }
        
        /// behavior (variable): A TimeBehaviorContainer record (section 2.8.34) that specifies the common behavior information.
        self.behavior = try TimeBehaviorContainer(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
