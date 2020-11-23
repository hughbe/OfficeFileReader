//
//  TimeEffectBehaviorAtom.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.62 TimeEffectBehaviorAtom
/// Referenced by: TimeEffectBehaviorContainer
/// An atom record that specifies the information of an animation that transforms the image of an object.
public struct TimeEffectBehaviorAtom {
    public let rh: RecordHeader
    public let fTransitionPropertyUsed: Bool
    public let fTypePropertyUsed: Bool
    public let fProgressPropertyUsed: Bool
    public let fRuntimeContextObsolete: Bool
    public let reserved: UInt32
    public let effectTransition: EffectTransition

    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_TimeEffectBehavior.
        /// rh.recLen MUST be 0x00000008.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .timeEffectBehavior else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000008 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fTransitionPropertyUsed (1 bit): A bit that specifies whether effectTransition was explicitly set by a user interface action.
        self.fTransitionPropertyUsed = flags.readBit()
        
        /// B - fTypePropertyUsed (1 bit): A bit that specifies whether the varType of the TimeEffectBehaviorContainer record (section 2.8.61) that
        /// contains this TimeEffectBehaviorAtom is valid.
        self.fTypePropertyUsed = flags.readBit()
        
        /// C - fProgressPropertyUsed (1 bit): A bit that specifies whether the varProgress of the TimeEffectBehaviorContainer record that contains
        /// this TimeEffectBehaviorAtom is valid.
        self.fProgressPropertyUsed = flags.readBit()
        
        /// D - fRuntimeContextObsolete (1 bit): A bit that specifies whether the varRuntimeContext of the TimeEffectBehaviorContainer record that
        /// contains this TimeEffectBehaviorAtom is valid.
        self.fRuntimeContextObsolete = flags.readBit()
        
        /// reserved (28 bits): MUST be zero, and MUST be ignored.
        self.reserved = flags.readRemainingBits()
        
        /// effectTransition (4 bytes): An unsigned integer that specifies how the image of the object is transformed. It MUST be ignored if
        /// fTransitionPropertyUsed is FALSE and a value of 0x00000000 MUST be used instead. It MUST be a value from the following table.
        guard let effectTransition = EffectTransition(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.effectTransition = effectTransition
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
    
    /// effectTransition (4 bytes): An unsigned integer that specifies how the image of the object is transformed. It MUST be ignored if
    /// fTransitionPropertyUsed is FALSE and a value of 0x00000000 MUST be used instead. It MUST be a value from the following table.
    public enum EffectTransition: UInt32 {
        /// 0x00000000 Transition in: the object is completely invisible at the beginning of the transformation and becomes completely visible at the
        /// end of the transformation.
        case transitionIn = 0x00000000
        
        /// 0x00000001 Transition out: the object is completely visible at the beginning of the transformation and becomes completely invisible at the
        /// end of the transformation.
        case transitionOut = 0x00000001
    }
}
