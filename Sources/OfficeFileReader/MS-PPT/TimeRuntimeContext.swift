//
//  TimeNodeTimeFilter.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.42 TimeRuntimeContext
/// Referenced by: TimeVariant4Behavior
/// An atom record that specifies the runtime context of an animation behavior.
/// Let the corresponding time node be as specified in the TimePropertyList4TimeBehavior record that contains this TimeRuntimeContext record.
public struct TimeRuntimeContext {
    public let rh: RecordHeader
    public let type: TimeVariantTypeEnum
    public let timeRuntimeContext: UnicodeString
    
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
        
        /// timeRuntimeContext (variable): A UnicodeString that specifies the runtime context of the animation behavior of the corresponding time node.
        /// It MUST be a valid RUNTIME_CONTEXT as specified in the following ABNF (specified in [RFC5234]) grammar:
        /// RUNTIME_CONTEXT = CONTEXT_ATOM *(";" CONTEXT_ATOM) [";"]
        /// CONTEXT_ATOM = [RELATION_OPERATOR SPACE] APP_ABBREV [SPACE VERSION]
        /// RELATION_OPERATOR = GTE / GT / LTE / LT / NOT
        /// APP_ABBREV = ("p" / "P") ("p" / "P") ("t" / "T")
        /// VERSION = DEC_NUMBER ["." DEC_NUMBER]
        /// DEC_NUMBER = 1*DIGIT
        /// GTE = "g" "t" "e"
        /// GT = "g" "t"
        /// LTE = "l" "t" "e"
        /// LT = "l" "t"
        /// NOT = "!"
        /// SPACE = 1*" "
        /// The length, in bytes, of the field is specified by the following formula: rh.recLen - 1
        self.timeRuntimeContext = try UnicodeString(dataStream: &dataStream, byteCount: Int(self.rh.recLen) - 1)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
