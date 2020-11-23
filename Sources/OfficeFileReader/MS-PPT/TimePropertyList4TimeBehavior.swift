//
//  TimePropertyList4TimeBehavior.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.37 TimePropertyList4TimeBehavior
/// Referenced by: TimeBehaviorContainer
/// A container record that specifies a list of animation attributes that is used in an animation behavior.
/// Let the corresponding time node be specified by the ExtTimeNodeContainer record (section 2.8.15) or the SubEffectContainer record (section 2.8.16)
/// that contains this TimePropertyList4TimeBehavior record.
public struct TimePropertyList4TimeBehavior {
    public let rh: RecordHeader
    public let rgChildRec: [TimeVariant4Behavior]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_TimePropertyList.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .timePropertyList else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// rgChildRec (variable): An array of TimeVariant4Behavior records that specifies the list of animation attributes. The length, in bytes, of the
        /// array is specified by rh.recLen. Each TimePropertyID4TimeBehavior enumeration value MUST NOT occur more than once as a value
        /// of the rh.recInstance field in the array.
        /// If the TL_TBPID_MotionPathEditRelative value does not occur, a TimeVariantBool structure in which the boolValue field is 0x01 SHOULD
        /// be used.
        /// If the TL_TBPID_PathEditRotationAngle value does not occur, a TimeVariantFloat structure in which the floatValue field is 0 SHOULD be used.
        /// If the TL_TBPID_PathEditRotationX value does not occur, a TimeVariantFloat structure in which the floatValue field is 0 SHOULD be used.
        /// If the TL_TBPID_PathEditRotationY value does not occur, a TimeVariantFloat structure in which the floatValue field is 0 SHOULD be used.
        /// If the colorBehaviorAtom.flags.fColorSpacePropertyUsed field of the TimeColorBehaviorContainer record (section 2.8.52) is FALSE, any
        /// item with the
        /// TL_TBPID_ColorColorModel value MUST be ignored and a TimeColorModel record with a colorModel field equal to 0x00000000 MUST
        /// be used instead.
        /// If the colorBehaviorAtom.flags.fDirectionPropertyUsed field of the TimeColorBehaviorContainer record is FALSE, any item with the
        /// TL_TBPID_ColorDirection value MUST be ignored and a TimeColorDirection record with a colorDirection field equal to 0x00000000 MUST
        /// be used instead.
        var rgChildRec: [TimeVariant4Behavior] = []
        while dataStream.position - startPosition < self.rh.recLen {
            rgChildRec.append(try TimeVariant4Behavior(dataStream: &dataStream))
        }
        
        self.rgChildRec = rgChildRec
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
