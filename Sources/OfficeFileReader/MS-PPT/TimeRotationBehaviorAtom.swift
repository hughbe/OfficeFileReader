//
//  TimeRotationBehaviorAtom.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.66 TimeRotationBehaviorAtom
/// Referenced by: TimeRotationBehaviorContainer
/// An atom record that specifies animation information for object rotation.
public struct TimeRotationBehaviorAtom {
    public let rh: RecordHeader
    public let fByPropertyUsed: Bool
    public let fFromPropertyUsed: Bool
    public let fToPropertyUsed: Bool
    public let fDirectionPropertyUsed: Bool
    public let reserved: UInt32
    public let fBy: Float
    public let fFrom: Float
    public let fTo: Float
    public let rotationDirection: RotationDirection

    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_TimeRotationBehavior.
        /// rh.recLen MUST be 0x00000014.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .timeRotationBehavior else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000014 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fByPropertyUsed (1 bit): A bit that specifies whether fBy was explicitly set by a user interface action.
        self.fByPropertyUsed = flags.readBit()
        
        /// B - fFromPropertyUsed (1 bit): A bit that specifies whether fFrom was explicitly set by a user interface action. If fFromPropertyUsed is
        /// TRUE, fByPropertyUsed or fToPropertyUsed MUST also be TRUE.
        self.fFromPropertyUsed = flags.readBit()
        
        /// C - fToPropertyUsed (1 bit): A bit that specifies whether fTo was explicitly set by a user interface action.
        self.fToPropertyUsed = flags.readBit()
        
        /// D - fDirectionPropertyUsed (1 bit): A bit that specifies whether rotationDirection was explicitly set by a user interface action.
        self.fDirectionPropertyUsed = flags.readBit()
        
        /// reserved (28 bits): MUST be zero, and MUST be ignored.
        self.reserved = flags.readRemainingBits()
        
        /// fBy (4 bytes): A floating-point number that specifies the offset degree of rotation. It MUST be ignored if fByPropertyUsed is FALSE or if
        /// fToPropertyUsed is TRUE.
        self.fBy = try dataStream.readFloat(endianess: .littleEndian)
        
        /// fFrom (4 bytes): A floating-point number that specifies the starting degree of rotation. It MUST be ignored if fFromPropertyUsed is FALSE
        /// and a value of 0 MUST be used instead.
        self.fFrom = try dataStream.readFloat(endianess: .littleEndian)
        
        /// fTo (4 bytes): A floating-point number that specifies the end degree of rotation. It MUST be ignored if fToPropertyUsed is FALSE and a
        /// value of 360 MUST be used instead.
        self.fTo = try dataStream.readFloat(endianess: .littleEndian)
        
        /// rotationDirection (4 bytes): An unsigned integer that specifies the rotation direction. It MUST be ignored if fDirectionPropertyUsed is
        /// FALSE and a value of 0x00000000 MUST be used instead. It MUST be a value from the following table.
        guard let rotationDirection = RotationDirection(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.rotationDirection = rotationDirection
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
    
    /// rotationDirection (4 bytes): An unsigned integer that specifies the rotation direction. It MUST be ignored if fDirectionPropertyUsed is
    /// FALSE and a value of 0x00000000 MUST be used instead. It MUST be a value from the following table.
    public enum RotationDirection: UInt32 {
        /// 0x00000000 Rotate clockwise.
        case clockwise = 0x00000000
        
        /// 0x00000001 Rotate counter clockwise.
        case counterClockwise = 0x00000001
    }
}
