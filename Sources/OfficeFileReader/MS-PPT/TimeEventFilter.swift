//
//  TimeEventFilter.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.26 TimeEventFilter
/// Referenced by: TimeVariant4TimeNode
/// An atom record that specifies an event filter for a time node.
/// Let the corresponding time node be as specified in the TimePropertyList4TimeNodeContainer record (section 2.8.18) that contains this
/// TimeEventFilter record.
public struct TimeEventFilter {
    public let rh: RecordHeader
    public let type: TimeVariantTypeEnum
    public let timeEventFilter: UnicodeString
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recType MUST be an RT_TimeVariant.
        /// rh.recLen MUST be an odd number.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .timeVariant else {
            throw OfficeFileError.corrupted
        }
        guard (self.rh.recLen % 2) != 0 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// type (1 byte): A TimeVariantTypeEnum enumeration that specifies the data type of this record. It MUST be TL_TVT_String.
        guard let type = TimeVariantTypeEnum(rawValue: try dataStream.read()) else {
            throw OfficeFileError.corrupted
        }
        guard type == .string else {
            throw OfficeFileError.corrupted
        }
        
        self.type = type
        
        /// timeEventFilter (variable): A UnicodeString that specifies the event filter for the corresponding time node. It MUST be "cancelBubble" and
        /// the TimePropertyList4TimeNodeContainer record that contains this TimeEventFilter record MUST contain a TimeEffectNodeType record with
        /// effectNodeType equal to 0x000000005. The length, in bytes, of the field is specified by the following formula: rh.recLen - 1
        self.timeEventFilter = try UnicodeString(dataStream: &dataStream, byteCount: Int(self.rh.recLen) - 1)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
