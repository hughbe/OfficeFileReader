//
//  TimeVariantString.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.82 TimeVariantString
/// Referenced by: TimeAnimateBehaviorContainer, TimeAnimationValueListEntry, TimeCommandBehaviorContainer, TimeEffectBehaviorContainer,
/// TimeMotionBehaviorContainer, TimeSetBehaviorContainer, TimeStringListContainer, TimeVariant, TimeVariant4Behavior
/// An atom record that specifies a Unicode string.
public struct TimeVariantString {
    public let rh: RecordHeader
    public let type: TimeVariantTypeEnum
    public let stringValue: UnicodeString
    
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
        
        /// stringValue (variable): A UnicodeString that specifies the value. The length, in bytes, of the field is specified by the following formula:
        /// rh.recLen – 1.
        self.stringValue = try UnicodeString(dataStream: &dataStream, byteCount: Int(self.rh.recLen) - 1)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
