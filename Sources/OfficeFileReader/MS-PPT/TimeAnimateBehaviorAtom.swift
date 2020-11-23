//
//  TimeAnimateBehaviorAtom.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.30 TimeAnimateBehaviorAtom
/// Referenced by: TimeAnimateBehaviorContainer
/// An atom record that specifies the information of a generic animation that can animate any property.
public struct TimeAnimateBehaviorAtom {
    public let rh: RecordHeader
    public let calcMode: CalculationMode
    public let fByPropertyUsed: Bool
    public let fFromPropertyUsed: Bool
    public let fToPropertyUsed: Bool
    public let fCalcModePropertyUsed: Bool
    public let fAnimationValuesPropertyUsed: Bool
    public let fValueTypePropertyUsed: Bool
    public let reserved: UInt32
    public let valueType: TimeAnimateBehaviorValueTypeEnum

    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_TimeAnimateBehavior.
        /// rh.recLen MUST be 0x0000000C.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .timeAnimateBehavior else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x0000000C else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// calcMode (4 bytes): An unsigned integer that specifies how the property value is calculated. It MUST be ignored if fCalcModePropertyUsed
        /// is FALSE and a value of 0x00000001 MUST be used instead. It MUST be a value from the following table:
        guard let calcMode = CalculationMode(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.calcMode = calcMode
        
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fByPropertyUsed (1 bit): A bit that specifies whether the varBy field of the TimeAnimateBehaviorContainer record (section 2.8.29) that
        /// contains this TimeAnimateBehaviorAtom record is valid.
        self.fByPropertyUsed = flags.readBit()
        
        /// B - fFromPropertyUsed (1 bit): A bit that specifies whether the varFrom field of the TimeAnimateBehaviorContainer record (section 2.8.29)
        /// that contains this TimeAnimateBehaviorAtom record is valid.
        self.fFromPropertyUsed = flags.readBit()
        
        /// C - fToPropertyUsed (1 bit): A bit that specifies whether the varTo field of the TimeAnimateBehaviorContainer record (section 2.8.29) that
        /// contains this TimeAnimateBehaviorAtom record is valid.
        self.fToPropertyUsed = flags.readBit()
        
        /// D - fCalcModePropertyUsed (1 bit): A bit that specifies whether calcMode was explicitly set by a user interface action.
        self.fCalcModePropertyUsed = flags.readBit()
        
        /// E - fAnimationValuesPropertyUsed (1 bit): A bit that specifies whether the animateValueList field of the TimeAnimateBehaviorContainer
        /// record (section 2.8.29) that contains this TimeAnimateBehaviorAtom record is valid.
        self.fAnimationValuesPropertyUsed = flags.readBit()
        
        /// F - fValueTypePropertyUsed (1 bit): A bit that specifies whether valueType was explicitly set by a user interface action.
        self.fValueTypePropertyUsed = flags.readBit()
        
        /// reserved (26 bits): MUST be zero, and MUST be ignored.
        self.reserved = flags.readRemainingBits()
        
        /// valueType (4 bytes): A TimeAnimateBehaviorValueTypeEnum enumeration that specifies the value type of the property to be animated.
        /// It MUST be ignored if fValueTypePropertyUsed is FALSE and a value of TL_TABVT_Number MUST be used instead.
        guard let valueType = TimeAnimateBehaviorValueTypeEnum(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.valueType = valueType
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
    
    /// calcMode (4 bytes): An unsigned integer that specifies how the property value is calculated. It MUST be ignored if fCalcModePropertyUsed
    /// is FALSE and a value of 0x00000001 MUST be used instead. It MUST be a value from the following table:
    public enum CalculationMode: UInt32 {
        /// 0x00000000 Discrete mode, which specifies that the value will jump from one to another without any interpolation.
        case discrete = 0x00000000
        
        /// 0x00000001 Linear mode, which specifies that the values are linearly interpolated.
        case linear = 0x00000001
        
        /// 0x00000002 Formula mode, which specifies that a formula specified by the animateValueList field of the TimeAnimateBehaviorContainer
        /// record (section 2.8.29) that contains this TimeAnimateBehaviorAtom record is used in the interpolation.
        case formula = 0x00000002
    }
}
