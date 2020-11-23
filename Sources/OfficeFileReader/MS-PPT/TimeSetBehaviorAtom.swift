//
//  TimeSetBehaviorAtom.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.70 TimeSetBehaviorAtom
/// Referenced by: TimeSetBehaviorContainer
/// An atom record that specifies animation information for an object or object property.
/// TimeAnimateBehaviorValueTypeEnum enumeration specifies the object or object property that will be animated.
public struct TimeSetBehaviorAtom {
    public let rh: RecordHeader
    public let fToPropertyUsed: Bool
    public let fValueTypePropertyUsed: Bool
    public let reserved: UInt32
    public let valueType: TimeAnimateBehaviorValueTypeEnum

    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_TimeSetBehavior.
        /// rh.recLen MUST be 0x00000008.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .timeSetBehavior else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000008 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fToPropertyUsed (1 bit): A bit that specifies whether the varTo of the TimeSetBehaviorContainer record (section 2.8.69) that contains this
        /// TimeSetBehaviorAtom is valid.
        self.fToPropertyUsed = flags.readBit()
        
        /// B - fValueTypePropertyUsed (1 bit): A bit that specifies whether valueType was explicitly set by a user interface action.
        self.fValueTypePropertyUsed = flags.readBit()
        
        /// reserved (30 bits): MUST be zero, and MUST be ignored.
        self.reserved = flags.readRemainingBits()
        
        /// valueType (4 bytes): A TimeAnimateBehaviorValueTypeEnum enumeration that specifies the type of object or object property to which to
        /// apply an animation. It MUST be ignored if fValueTypePropertyUsed is FALSE and a value of TL_TABVT_Number MUST be used instead.
        guard let valueType = TimeAnimateBehaviorValueTypeEnum(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.valueType = valueType
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
