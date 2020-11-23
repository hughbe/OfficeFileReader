//
//  TimeAnimationValueListContainer.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.31 TimeAnimationValueListContainer
/// Referenced by: TimeAnimateBehaviorContainer
/// A container record that specifies the list of key points that are used during a property animation to set a property to a value at a point within the
/// timeline as specified in the TimeAnimateBehaviorContainer record (section 2.8.29).
public struct TimeAnimationValueListContainer {
    public let rh: RecordHeader
    public let rgTimeAnimValueList: [TimeAnimationValueListEntry]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0xF.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_TimeAnimationValueList.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0xF else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .timeAnimationValueList else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// rgTimeAnimValueList (variable): An array of TimeAnimationValueListEntry structures that specifies the key points that are used during the
        /// animation. The length, in bytes, of the array is specified by rh.recLen.
        /// If the value of the timeAnimationValueAtom.time field in any TimeAnimationValueListEntry record in this array is -1000, the time for the key
        /// points is evenly partitioned between 0 and 1.
        var rgTimeAnimValueList: [TimeAnimationValueListEntry] = []
        while dataStream.position - startPosition < self.rh.recLen {
            rgTimeAnimValueList.append(try TimeAnimationValueListEntry(dataStream: &dataStream, startPosition: startPosition, length: Int(self.rh.recLen)))
        }
        
        self.rgTimeAnimValueList = rgTimeAnimValueList
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
