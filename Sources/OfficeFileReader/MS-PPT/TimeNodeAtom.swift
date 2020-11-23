//
//  TimeNodeAtom.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.17 TimeNodeAtom
/// Referenced by: ExtTimeNodeContainer, SubEffectContainer
/// An atom record that specifies the attributes of a time node.
/// Let the corresponding time node be specified by the ExtTimeNodeContainer record (section 2.8.15) or the SubEffectContainer record that contains
/// this TimeNodeAtom record.
public struct TimeNodeAtom {
    public let rh: RecordHeader
    public let reserved1: UInt32
    public let restart: RestartType
    public let type: TimeNodeTypeEnum
    public let fill: FillState
    public let reserved2: UInt32
    public let reserved3: UInt8
    public let unused: [UInt8]
    public let duration: Int32
    public let fFillProperty: Bool
    public let fRestartProperty: Bool
    public let reserved4: Bool
    public let fGroupingTypeProperty: Bool
    public let fDurationProperty: Bool
    public let reserved5: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_TimeNode.
        /// rh.recLen MUST be 0x00000020.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .timeNode else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000020 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// reserved1 (4 bytes): MUST be zero, and MUST be ignored.
        self.reserved1 = try dataStream.read(endianess: .littleEndian)
        
        /// restart (4 bytes): An unsigned integer that specifies how the corresponding time node restarts when it completes its action. It MUST be
        /// ignored if fRestartProperty is FALSE and a value of 0x00000000 MUST be used instead. It MUST be a value from the following table:
        guard let restart = RestartType(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.restart = restart
        
        /// type (4 bytes): A TimeNodeTypeEnum enumeration that specifies the type of the corresponding time node. It MUST be ignored if
        /// fGroupingTypeProperty is FALSE and a value of TL_TNT_Parallel MUST be used instead.
        guard let type = TimeNodeTypeEnum(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.type = type
        
        /// fill (4 bytes): An unsigned integer that specifies the state of the target object's properties when the animation ends. It MUST be ignored
        /// if fFillProperty is FALSE and a value of 0x00000000 MUST be used instead. It MUST be a value from the following table.
        guard let fill = FillState(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.fill = fill
        
        /// reserved2 (4 bytes): MUST be zero, and MUST be ignored.
        self.reserved2 = try dataStream.read(endianess: .littleEndian)
        
        /// reserved3 (1 byte): MUST be zero, and MUST be ignored.
        self.reserved3 = try dataStream.read()
        
        /// unused (3 bytes): Undefined and MUST be ignored.
        self.unused = try dataStream.readBytes(count: 3)
        
        /// duration (4 bytes): A signed integer that specifies the duration of the corresponding time node in milliseconds. It MUST be ignored if
        /// fDurationProperty is FALSE and a value of 0x00000000 MUST be used instead.
        self.duration = try dataStream.read(endianess: .littleEndian)
        
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fFillProperty (1 bit): A bit that specifies whether fill was explicitly set by a user interface action.
        self.fFillProperty = flags.readBit()
        
        /// B - fRestartProperty (1 bit): A bit that specifies whether restart was explicitly set by a user interface action.
        self.fRestartProperty = flags.readBit()
        
        /// C - reserved4 (1 bit): MUST be zero, and MUST be ignored.
        self.reserved4 = flags.readBit()
        
        /// D - fGroupingTypeProperty (1 bit): A bit that specifies whether type was explicitly set by a user interface action.
        self.fGroupingTypeProperty = flags.readBit()
        
        /// E - fDurationProperty (1 bit): A bit that specifies whether duration was explicitly set by a user interface action.
        self.fDurationProperty = flags.readBit()
        
        /// reserved5 (27 bits): MUST be zero, and MUST be ignored.
        self.reserved5 = flags.readRemainingBits()
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
    
    /// restart (4 bytes): An unsigned integer that specifies how the corresponding time node restarts when it completes its action. It MUST be ignored
    /// if fRestartProperty is FALSE and a value of 0x00000000 MUST be used instead. It MUST be a value from the following table:
    public enum RestartType: UInt32 {
        /// 0x00000000 Does not restart.
        case doesNotRestart = 0x00000000
        
        /// 0x00000001 Can restart at any time.
        case canRestartAtAnyTime = 0x00000001
        
        /// 0x00000002 Can restart when the corresponding time node is not active.
        case restartWhenCorrespondingTimeNodeNotActive = 0x00000002
        
        /// 0x00000003 Same as 0x00000000.
        case doesNotRestart2 = 0x00000003
    }
    
    /// fill (4 bytes): An unsigned integer that specifies the state of the target object's properties when the animation ends. It MUST be ignored if
    /// fFillProperty is FALSE and a value of 0x00000000 MUST be used instead. It MUST be a value from the following table.
    public enum FillState: UInt32 {
        /// 0x00000000 The properties remain at their ending values while the parent time node is still running or holding. After which, the properties
        /// reset to their original values.
        case propertiesResetToOriginalValuesAfterParentTimeNodeRunningOrHolding1 = 0x00000000
        
        /// 0x00000001 The properties reset to their original values after the time node becomes inactive.
        case propertiesResetToOriginalValuesAfterTimeNodeBecomesInactive1 = 0x00000001
        
        /// 0x00000002 The properties remain at their ending values while the parent time node is still running or holding, or until another sibling time
        /// node is started under a sequential time node as specified in the type field. After which, the properties reset to their original values.
        case propertiesResetToOriginalValuesAfterParentTimeNodeRunningOrHoldingOrSiblingNodeStarted = 0x00000002
        
        /// 0x00000003 Same as 0x00000000.
        case propertiesResetToOriginalValuesAfterParentTimeNodeRunningOrHolding2 = 0x00000003
        
        /// 0x00000004 Same as 0x00000001.
        case propertiesResetToOriginalValuesAfterTimeNodeBecomesInactive2 = 0x00000004
    }
}
