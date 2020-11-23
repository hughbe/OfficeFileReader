//
//  TimeCommandBehaviorAtom.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.72 TimeCommandBehaviorAtom
/// Referenced by: TimeCommandBehaviorContainer
/// An atom record that specifies the information of a command that is performed as an animation.
public struct TimeCommandBehaviorAtom {
    public let rh: RecordHeader
    public let fTypePropertyUsed: Bool
    public let fCommandPropertyUsed: Bool
    public let reserved: UInt32
    public let commandBehaviorType: TimeCommandBehaviorTypeEnum

    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_TimeCommandBehavior.
        /// rh.recLen MUST be 0x00000008.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .timeCommandBehavior else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000008 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fTypePropertyUsed (1 bit): A bit that specifies whether commandBehaviorType was explicitly set by a user interface action.
        self.fTypePropertyUsed = flags.readBit()
        
        /// B - fCommandPropertyUsed (1 bit): A bit that specifies whether varCommand of the TimeCommandBehaviorContainer record
        /// (section 2.8.71) that contains this TimeCommandBehaviorAtom is valid.
        self.fCommandPropertyUsed = flags.readBit()
        
        /// reserved (30 bits): MUST be zero, and MUST be ignored.
        self.reserved = flags.readRemainingBits()
        
        /// commandBehaviorType (4 bytes): A TimeCommandBehaviorTypeEnum enumeration that specifies the type of the command. It MUST
        /// be ignored if fTypePropertyUsed is FALSE and a value of TL_TCBT_Call MUST be used instead.
        guard let commandBehaviorType = TimeCommandBehaviorTypeEnum(rawValue: try dataStream.read(endianess: .littleEndian)) else {
            throw OfficeFileError.corrupted
        }
        
        self.commandBehaviorType = commandBehaviorType
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
