//
//  TimeAnimationValueAtom.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.33 TimeAnimationValueAtom
/// Referenced by: TimeAnimationValueListEntry
/// An atom record that specifies a value of time that is used in the TimeAnimationValueListEntry structure to determine the overall timeline for the
/// corresponding animation.
public struct TimeAnimationValueAtom {
    public let rh: RecordHeader
    public let time: Int32

    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_TimeAnimationValue.
        /// rh.recLen MUST be 0x00000004.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .timeAnimationValue else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000004 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// time (4 bytes): A signed integer that specifies a percentage value of time in 1000ths that is utilized in the TimeAnimationValueListEntry record.
        /// For example, 1000 means 100% of time of an animation. This field MUST be either equal to -1000, or greater than or equal to 0 and less
        /// than or equal to 1000.
        self.time = try dataStream.read(endianess: .littleEndian)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
