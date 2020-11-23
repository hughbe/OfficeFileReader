//
//  TimeIterateDataAtom.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.73 TimeIterateDataAtom
/// Referenced by: ExtTimeNodeContainer
/// An atom record that specifies how an animation is applied to sub-elements of the target object for a repeated effect. It can be applied to the
/// letters, words, or shapes within a target object.
public struct TimeIterateDataAtom {
    public let rh: RecordHeader
    public let iterateInterval: UInt32
    public let iterateType: IterateType
    public let iterateDirection: IterateDirection
    public let iterateIntervalType: IterateIntervalType
    public let fIterateDirectionPropertyUsed: Bool
    public let fIterateTypePropertyUsed: Bool
    public let fIterateIntervalPropertyUsed: Bool
    public let fIterateIntervalTypePropertyUsed: Bool
    public let reserved: UInt32

    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_TimeIterateData.
        /// rh.recLen MUST be 0x00000014.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .timeIterateData else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000014 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// iterateInterval (4 bytes): An unsigned integer that specifies the interval time of iterations, which can be either absolute time or a percentage
        /// as specified in iterateIntervalType. It MUST be ignored if fIterateIntervalPropertyUsed is FALSE and a value of 0x00000000 MUST be used
        /// instead.
        self.iterateInterval = try dataStream.read(endianess: .littleEndian)
        
        /// iterateType (4 bytes): An unsigned integer that specifies the type of iteration behavior. It MUST be ignored if fIterateTypePropertyUsed is
        /// FALSE and a value of 0x00000000 MUST be used instead. It MUST be a value from the following table.
        guard let iterateType = IterateType(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.iterateType = iterateType
        
        /// iterateDirection (4 bytes): An unsigned integer that specifies the direction of the iteration behavior. It MUST be ignored if
        /// fIterateDirectionPropertyUsed is FALSE and a value of 0x00000001 MUST be used instead. It MUST be a value from the following table.
        guard let iterateDirection = IterateDirection(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.iterateDirection = iterateDirection
        
        /// iterateIntervalType (4 bytes): An unsigned integer that specifies the type of interval time as specified in iterateInterval. It MUST be ignored
        /// if fIterateIntervalTypePropertyUsed is FALSE and a value of 0x00000000 MUST be used instead. It MUST be a value from the following
        /// table.
        guard let iterateIntervalType = IterateIntervalType(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.iterateIntervalType = iterateIntervalType
        
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fIterateDirectionPropertyUsed (1 bit): A bit that specifies whether iterateDirection was explicitly set by a user interface action.
        self.fIterateDirectionPropertyUsed = flags.readBit()
        
        /// B - fIterateTypePropertyUsed (1 bit): A bit that specifies whether iterateType was explicitly set by a user interface action.
        self.fIterateTypePropertyUsed = flags.readBit()
        
        /// C - fIterateIntervalPropertyUsed (1 bit): A bit that specifies whether iterateInterval was explicitly set by a user interface action.
        self.fIterateIntervalPropertyUsed = flags.readBit()
        
        /// D - fIterateIntervalTypePropertyUsed (1 bit): A bit that specifies whether iterateIntervalType was explicitly set by a user interface action.r
        self.fIterateIntervalTypePropertyUsed = flags.readBit()
        
        /// reserved (28 bits): MUST be zero, and MUST be ignored.
        self.reserved = flags.readRemainingBits()
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
    
    /// iterateType (4 bytes): An unsigned integer that specifies the type of iteration behavior. It MUST be ignored if fIterateTypePropertyUsed is
    /// FALSE and a value of 0x00000000 MUST be used instead. It MUST be a value from the following table.
    public enum IterateType: UInt32 {
        /// 0x00000000 All at once: all sub-elements animate together with no interval time.
        case allAtOnce = 0x00000000
        
        /// 0x00000001 By word: sub-elements are words.
        case byWord = 0x00000001
        
        /// 0x00000002 By letter: sub-elements are letters.
        case byLetter = 0x00000002
    }
    
    /// iterateDirection (4 bytes): An unsigned integer that specifies the direction of the iteration behavior. It MUST be ignored if
    /// fIterateDirectionPropertyUsed is FALSE and a value of 0x00000001 MUST be used instead. It MUST be a value from the following table.
    public enum IterateDirection: UInt32 {
        /// 0x00000000 Backwards: from the last sub-element to the first sub-element.
        case backwards = 0x00000000
        
        /// 0x00000001 Forwards: from the first sub-element to the last sub-element.
        case forwards = 0x00000001
    }
    
    /// iterateIntervalType (4 bytes): An unsigned integer that specifies the type of interval time as specified in iterateInterval. It MUST be ignored if
    /// fIterateIntervalTypePropertyUsed is FALSE and a value of 0x00000000 MUST be used instead. It MUST be a value from the following table.
    public enum IterateIntervalType: UInt32 {
        /// 0x00000000 Seconds: iterateInterval is absolute time in milliseconds.
        case seconds = 0x00000000
        
        /// 0x00000001 Percentage: iterateInterval is a percentage of animation duration, in tenths of a percent.
        case percentage = 0x00000001
    }
}
