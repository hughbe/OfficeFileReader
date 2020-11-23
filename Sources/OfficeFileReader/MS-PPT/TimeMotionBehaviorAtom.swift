//
//  TimeMotionBehaviorAtom.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.64 TimeMotionBehaviorAtom
/// Referenced by: TimeMotionBehaviorContainer
/// An atom record that specifies the information of an animation that moves an object along a path.
public struct TimeMotionBehaviorAtom {
    public let rh: RecordHeader
    public let fByPropertyUsed: Bool
    public let fFromPropertyUsed: Bool
    public let fToPropertyUsed: Bool
    public let fOriginPropertyUsed: Bool
    public let fPathPropertyUsed: Bool
    public let reserved1: Bool
    public let fEditRotationPropertyUsed: Bool
    public let fPointsTypesPropertyUsed: Bool
    public let reserved2: UInt32
    public let fXBy: Float
    public let fYBy: Float
    public let fXFrom: Float
    public let fYFrom: Float
    public let fXTo: Float
    public let fYTo: Float
    public let behaviorOrigin: BehaviorOrigin

    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_TimeMotionBehavior.
        /// rh.recLen MUST be 0x00000020.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .timeMotionBehavior else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000020 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fByPropertyUsed (1 bit): A bit that specifies whether fXBy and fYBy were explicitly set by a user interface action.
        self.fByPropertyUsed = flags.readBit()
        
        /// B - fFromPropertyUsed (1 bit): A bit that specifies whether fXFrom and fYFrom were explicitly set by a user interface action If
        /// fFromPropertyUsed is TRUE, fByPropertyUsed or fToPropertyUsed MUST also be TRUE.
        self.fFromPropertyUsed = flags.readBit()
        
        /// C - fToPropertyUsed (1 bit): A bit that specifies whether fXTo and fYTo were explicitly set by a user interface action.
        self.fToPropertyUsed = flags.readBit()
        
        /// D - fOriginPropertyUsed (1 bit): A bit that specifies whether behaviorOrigin was explicitly set by a user interface action.
        self.fOriginPropertyUsed = flags.readBit()
        
        /// E - fPathPropertyUsed (1 bit): A bit that specifies whether the varPath of the TimeMotionBehaviorContainer record (section 2.8.63) that
        /// contains this TimeMotionBehaviorAtom is valid.
        self.fPathPropertyUsed = flags.readBit()
        
        /// F - reserved1 (1 bit): MUST be 0x0.
        self.reserved1 = flags.readBit()
        
        /// G - fEditRotationPropertyUsed (1 bit): A bit that specifies whether the timeContainer.propertyList of the TimeMotionBehaviorContainer
        /// record that contains this TimeMotionBehaviorAtom has items of types TL_TBPID_PathEditRotationAngle, TL_TBPID_PathEditRotationX,
        /// and TL_TBPID_PathEditRotationY as specified in the TimePropertyID4TimeBehavior enumeration.
        self.fEditRotationPropertyUsed = flags.readBit()
        
        /// H - fPointsTypesPropertyUsed (1 bit): A bit that specifies whether the timeContainer.propertyList of the TimeMotionBehaviorContainer record
        /// that contains this TimeMotionBehaviorAtom has items of type TL_TBPID_PointsTypes as specified in the TimePropertyID4TimeBehavior
        /// enumeration.
        self.fPointsTypesPropertyUsed = flags.readBit()
        
        /// reserved2 (24 bits): MUST be 0x000000.
        self.reserved2 = flags.readRemainingBits()
        
        /// fXBy (4 bytes): A floating-point number that specifies the offset value of the object position in the horizontal axis. It MUST be ignored if
        /// fByPropertyUsed is FALSE or if fToPropertyUsed is TRUE.
        self.fXBy = try dataStream.readFloat(endianess: .littleEndian)
        
        /// fYBy (4 bytes): A floating-point number that specifies the offset value of the object position in the vertical axis. It MUST be ignored if
        /// fByPropertyUsed is FALSE or if fToPropertyUsed is TRUE.
        self.fYBy = try dataStream.readFloat(endianess: .littleEndian)
        
        /// fXFrom (4 bytes): A floating-point number that specifies the starting position of the object in the horizontal axis. It MUST be ignored if
        /// fFromPropertyUsed is FALSE and a value of 0x00000000 MUST be used instead.
        self.fXFrom = try dataStream.readFloat(endianess: .littleEndian)
        
        /// fYFrom (4 bytes): A floating-point number that specifies the starting position of the object in the vertical axis. It MUST be ignored if
        /// fFromPropertyUsed is FALSE and a value of 0x00000000 MUST be used instead.
        self.fYFrom = try dataStream.readFloat(endianess: .littleEndian)
        
        /// fXTo (4 bytes): A floating-point number that specifies the end position of the object in the horizontal axis. It MUST be ignored if
        /// fToPropertyUsed is FALSE.
        self.fXTo = try dataStream.readFloat(endianess: .littleEndian)
        
        /// fYTo (4 bytes): A floating-point number that specifies the end position of the object in the vertical axis. It MUST be ignored if
        /// fToPropertyUsed is FALSE.
        self.fYTo = try dataStream.readFloat(endianess: .littleEndian)
        
        /// behaviorOrigin (4 bytes): An unsigned integer that specifies the origin of the motion path. It MUST be ignored if fOriginPropertyUsed is
        /// FALSE and a value of 0x00000002 MUST be used instead. It MUST be a value from the following table.
        guard let behaviorOrigin = BehaviorOrigin(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.behaviorOrigin = behaviorOrigin
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
    
    /// behaviorOrigin (4 bytes): An unsigned integer that specifies the origin of the motion path. It MUST be ignored if fOriginPropertyUsed is
    /// FALSE and a value of 0x00000002 MUST be used instead. It MUST be a value from the following table.
    public enum BehaviorOrigin: UInt32 {
        /// 0x00000000 The origin is at the upper left corner of the slide that contains the object.
        case upperLeftCornerOfSlide1 = 0x00000000
        
        /// 0x00000001 Same as 0x00000000.
        case upperLeftCornerOfSlide2 = 0x00000001
        
        /// 0x00000002 The origin is at the center of the object
        case center = 0x00000002
    }
}
