//
//  TimeBehaviorAtom.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.35 TimeBehaviorAtom
/// Referenced by: TimeBehaviorContainer
/// An atom record that specifies the common information of an animation behavior.
public struct TimeBehaviorAtom {
    public let rh: RecordHeader
    public let fAdditivePropertyUsed: Bool
    public let reserved1: Bool
    public let fAttributeNamesPropertyUsed: Bool
    public let reserved2: Bool
    public let reserved3: UInt32
    public let behaviorAdditive: UInt32
    public let behaviorAccumulate: UInt32
    public let behaviorTransform: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_TimeBehavior.
        /// rh.recLen MUST be 0x00000010.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .timeBehavior else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000010 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fAdditivePropertyUsed (1 bit): A bit that specifies whether the behaviorAdditive field was explicitly set by a user interface action.
        self.fAdditivePropertyUsed = flags.readBit()
        
        /// B - reserved1 (1 bit): MUST be zero, and MUST be ignored.
        self.reserved1 = flags.readBit()
        
        /// C - fAttributeNamesPropertyUsed (1 bit): A bit that specifies whether the stringList field of the TimeBehaviorContainer record (section 2.8.34)
        /// that contains this TimeBehaviorAtom record is valid.
        self.fAttributeNamesPropertyUsed = flags.readBit()
        
        /// D - reserved2 (1 bit): MUST be zero, and MUST be ignored.
        self.reserved2 = flags.readBit()
        
        /// reserved3 (28 bits): MUST be zero, and MUST be ignored.
        self.reserved3 = flags.readRemainingBits()
        
        /// behaviorAdditive (4 bytes): An unsigned integer that specifies how to compose the animated value with the original value of the property
        /// that is animated. It MUST be ignored if fAdditivePropertyUsed is FALSE and a value of 0x00000000 MUST be used instead. It MUST be
        /// a value from the following table.
        /// Value Meaning
        /// 0x00000000 Override the original value with the animated value.
        /// 0x00000001 Add the animated value to the original value.
        self.behaviorAdditive = try dataStream.read(endianess: .littleEndian)
        
        /// behaviorAccumulate (4 bytes): An unsigned integer that specifies how to compose the animated values of the property in repeating
        /// animations. It MUST be 0x00000000 that specifies that no accumulation is used.
        self.behaviorAccumulate = try dataStream.read(endianess: .littleEndian)
        
        /// behaviorTransform (4 bytes): An unsigned integer that specifies the type of animation transform to use. It MUST be 0x00000000 that
        /// specifies that the animation animates properties of the target object.
        self.behaviorTransform = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
