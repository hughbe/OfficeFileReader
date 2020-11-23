//
//  TimeSequenceDataAtom.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.74 TimeSequenceDataAtom
/// Referenced by: ExtTimeNodeContainer
/// An atom record that specifies sequencing information for the child nodes of a time node. Each child can only be activated after its prior sibling has
/// been activated.
/// Let the corresponding time node be specified by the ExtTimeNodeContainer record (section 2.8.15) that contains this TimeSequenceDataAtom record.
/// Let the corresponding next time condition list be specified by the rgBeginTimeCondition field in corresponding time node, which specifies the time
/// conditions to activate the next child time node.
public struct TimeSequenceDataAtom {
    public let rh: RecordHeader
    public let concurrency: UInt32
    public let nextAction: UInt32
    public let previousAction: UInt32
    public let reserved1: UInt32
    public let fConcurrencyPropertyUsed: Bool
    public let fNextActionPropertyUsed: Bool
    public let fPreviousActionPropertyUsed: Bool
    public let reserved2: UInt32

    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_TimeSequenceData.
        /// rh.recLen MUST be 0x00000014.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .timeSequenceData else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000014 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// concurrency (4 bytes): An unsigned integer that specifies the concurrency behavior of the child nodes of the corresponding time node.
        /// It MUST be ignored if fConcurrencyPropertyUsed is FALSE and a value of 0x00000000 MUST be used instead. It MUST be a value from
        /// the following table.
        /// Value Meaning
        /// 0x00000000 No concurrency: the next child is activated only after the current child ends and conditions in the corresponding next time
        /// condition list are met.
        /// 0x00000001 Concurrency enabled: the next child can be activated after the current child is activated and conditions in the corresponding
        /// next time condition list are met.
        self.concurrency = try dataStream.read(endianess: .littleEndian)
        
        /// nextAction (4 bytes): An unsigned integer that specifies actions when traversing forward in the sequence of child nodes of the corresponding
        /// time node. It MUST be ignored if fNextActionPropertyUsed is FALSE and a value of 0x00000000 MUST be used instead. It MUST be a value
        /// from the following table.
        /// Value Meaning
        /// 0x00000000 Take no action.
        /// 0x00000001 Traverse forward the current child node along the timeline to a natural end time. The natural end time of a child node is the time
        /// when the child node will end without interventions. If the end time is infinite, the child node will never stop. The natural end time of the child
        /// node is specified as the latest non-infinite end time of its child nodes.
        self.nextAction = try dataStream.read(endianess: .littleEndian)
        
        /// previousAction (4 bytes): An unsigned integer that specifies actions when traversing backward in the sequence of child nodes of the
        /// corresponding time node. It MUST be ignored if fPreviousActionPropertyUsed is FALSE and a value of 0x0000000 MUST be used instead.
        /// It MUST be a value from the following table.
        /// Value Meaning
        /// 0x00000000 Take no action.
        /// 0x00000001 Continue backwards in the sequence until reaching a child that starts only on the next time condition as specified in the
        /// corresponding next time condition list.
        self.previousAction = try dataStream.read(endianess: .littleEndian)
        
        /// reserved1 (4 bytes): MUST be zero, and MUST be ignored.
        self.reserved1 = try dataStream.read(endianess: .littleEndian)
        
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fConcurrencyPropertyUsed (1 bit): A bit that specifies whether concurrency was explicitly set by a user interface action.
        self.fConcurrencyPropertyUsed = flags.readBit()
        
        /// B - fNextActionPropertyUsed (1 bit): A bit that specifies whether nextAction was explicitly set by a user interface action.
        self.fNextActionPropertyUsed = flags.readBit()
        
        /// C - fPreviousActionPropertyUsed (1 bit): A bit that specifies whether previousAction was explicitly set by a user interface action.
        self.fPreviousActionPropertyUsed = flags.readBit()
        
        /// reserved2 (29 bits): MUST be zero, and MUST be ignored.
        self.reserved2 = flags.readRemainingBits()
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
