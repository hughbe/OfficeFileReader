//
//  DTTM.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.65 DTTM
/// The DTTM structure specifies date and time.
public struct DTTM {
    public let mint: UInt32
    public let hr: UInt32
    public let dom: UInt32
    public let mon: UInt32
    public let yr: UInt32
    public let wdy: UInt32
    
    public init(dataStream: inout DataStream) throws {
        let rawValue: UInt32 = try dataStream.read(endianess: .littleEndian)
        
        /// mint (6 bits): An unsigned integer that specifies the minute. This value MUST be less than or equal to 0x3B.
        self.mint = rawValue & 0b111111
        if self.mint > 0x3B {
            throw OfficeFileError.corrupted
        }
        
        /// hr (5 bits): An unsigned integer that specifies the hour. This value MUST be less than or equal to 0x17.
        self.hr = (rawValue >> 6) & 0b11111
        if self.hr > 0x17 {
            throw OfficeFileError.corrupted
        }
        
        /// dom (5 bits): An unsigned integer that specifies the day of the month. This value MUST be less than or equal to 0x1F. If this value
        /// is equal to zero, this DTTM MUST be ignored.
        self.dom = (rawValue >> 11) & 0b11111
        if self.dom > 0x1F {
            throw OfficeFileError.corrupted
        }
        
        /// mon (4 bits): An unsigned integer that specifies the month. The values 0x1 through 0xC specify the months January through
        /// December, respectively. This value MUST be less than or equal to 0xC. If this value is equal to zero, this DTTM MUST be ignored.
        self.mon = (rawValue >> 16) & 0b1111
        if self.mon > 0x1F {
            throw OfficeFileError.corrupted
        }
        
        /// yr (9 bits): An unsigned integer that specifies the year, offset from 1900.
        self.yr = (rawValue >> 20) & 0b111111111
        
        /// wdy (3 bits): An unsigned integer that specifies the day of the week, starting from Sunday (0x0). This value MUST be less than or
        /// equal to 0x6.
        self.wdy = (rawValue >> 29) & 0b111
        if self.wdy > 0x06 {
            throw OfficeFileError.corrupted
        }
    }
}
