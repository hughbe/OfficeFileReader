//
//  TimePointsTypes.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.43 TimePointsTypes
/// Referenced by: TimeVariant4Behavior
/// An atom record that specifies the type of points in a motion path.
/// Let the corresponding time node be as specified in the TimePropertyList4TimeBehavior record that contains this TimePointsTypes record.
public struct TimePointsTypes {
    public let rh: RecordHeader
    public let type: TimeVariantTypeEnum
    public let timePointsTypes: UnicodeString
    
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
        
        /// timePointsTypes (variable): A UnicodeString that specifies the type of points in the path attribute and the description of the motion path
        /// near the current point. The length, in bytes, of the field is specified by the following formula: rh.recLen - 1
        /// This field has no effect on the playing of the animation. It is only used when the motion path is edited in a user interface.
        /// Each character in this string sequentially maps to a point defined in the path string as specified in the varPath field of the
        /// TimeMotionBehaviorContainer record (section 2.8.63). It MUST be a sequence formed with characters from the following table.
        /// Character Meaning
        /// A Auto line point.
        /// a Auto curve point.
        /// F Corner line point.
        /// f Corner curve point.
        /// T Straight line point.
        /// t Straight curve point.
        /// S Smooth line point.
        /// s Smooth curve point.
        self.timePointsTypes = try UnicodeString(dataStream: &dataStream, byteCount: Int(self.rh.recLen) - 1)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
