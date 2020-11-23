//
//  TimeNodeTimeFilter.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.25 TimeNodeTimeFilter
/// Referenced by: TimeVariant4TimeNode
/// An atom record that specifies a time filter that transforms a given time to the local time of a time node.
/// Let the corresponding time node be as specified in the TimePropertyList4TimeNodeContainer record (section 2.8.18) that contains this
/// TimeNodeTimeFilter record.
public struct TimeNodeTimeFilter {
    public let rh: RecordHeader
    public let type: TimeVariantTypeEnum
    public let timeFilter: UnicodeString
    
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
        
        /// timeFilter (variable): A UnicodeString that specifies the time filter that transforms a given time value into the local time of the corresponding
        /// time node. It MUST be a valid TIMESEQUENCE as specified in the following ABNF (specified in [RFC5234]) grammar:
        /// TIMESEQUENCE = TIME "," TRANSTIME *(";" TIMESEQUENCE)
        /// TIME = "0" "." 1*DIGIT / "1" "." "0"
        /// TRANSTIME = "0" "." 1*DIGIT / "1" "." "0"
        /// Each TIME is the normalized local time for the time node whose value ranges from 0.0 to 1.0, and TRANSTIME is the transformed local time
        /// for the time node. The length, in bytes, of the field is specified by the following formula: rh.recLen - 1
        self.timeFilter = try UnicodeString(dataStream: &dataStream, byteCount: Int(self.rh.recLen) - 1)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
