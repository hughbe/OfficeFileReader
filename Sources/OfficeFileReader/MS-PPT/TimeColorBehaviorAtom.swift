//
//  TimeColorBehaviorAtom.swift
//
//
//  Created by Hugh Bellamy on 16/11/2020.
//

import DataStream

/// [MS-PPT] 2.8.53 TimeColorBehaviorAtom
/// Referenced by: TimeColorBehaviorContainer
/// An atom record that specifies the information for an animation that changes the color of an object.
public struct TimeColorBehaviorAtom {
    public let rh: RecordHeader
    public let flag: TimeColorBehaviorPropertyUsedFlag
    public let colorBy: TimeAnimateColorBy
    public let colorFrom: TimeAnimateColor
    public let colorTo: TimeAnimateColor

    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be an RT_TimeColorBehavior.
        /// rh.recLen MUST be 0x00000034.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .timeColorBehavior else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000034 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        /// flag (4 bytes): A TimeColorBehaviorPropertyUsedFlag structure that specifies which fields are valid.
        self.flag = try TimeColorBehaviorPropertyUsedFlag(dataStream: &dataStream)
        
        /// colorBy (16 bytes): A TimeAnimateColorBy structure that specifies the offset color value. MUST be ignored if colorTo exists. It MUST
        /// be ignored if flag.fByPropertyUsed is FALSE.
        self.colorBy = try TimeAnimateColorBy(dataStream: &dataStream)
        
        /// colorFrom (16 bytes): A TimeAnimateColor structure that specifies the starting color value. If colorFrom exists, colorBy or colorTo MUST
        /// also exist. It MUST be ignored if flag.fFromPropertyUsed is FALSE.
        self.colorFrom = try TimeAnimateColor(dataStream: &dataStream)
        
        /// colorTo (16 bytes): A TimeAnimateColor structure that specifies the end color value. MUST be ignored if flag.fToPropertyUsed is FALSE.
        self.colorTo = try TimeAnimateColor(dataStream: &dataStream)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
