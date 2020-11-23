//
//  Ico.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.119 Ico
/// The Ico structure specifies an entry in the color palette that is listed in the following table.
public struct Ico {
    public let value: UInt8
    
    public var colorref: COLORREF {
        switch value {
        case 0x00:
            return COLORREF(red: 0x00, green: 0x00, blue: 0x00, fAuto: 0xFF)
        case 0x01:
            return COLORREF(red: 0x00, green: 0x00, blue: 0x00, fAuto: 0x00)
        case 0x02:
            return COLORREF(red: 0x00, green: 0x00, blue: 0xFF, fAuto: 0x00)
        case 0x03:
            return COLORREF(red: 0x00, green: 0xFF, blue: 0xFF, fAuto: 0x00)
        case 0x04:
            return COLORREF(red: 0x00, green: 0xFF, blue: 0x00, fAuto: 0x00)
        case 0x05:
            return COLORREF(red: 0xFF, green: 0x00, blue: 0xFF, fAuto: 0x00)
        case 0x06:
            return COLORREF(red: 0xFF, green: 0x00, blue: 0x00, fAuto: 0x00)
        case 0x07:
            return COLORREF(red: 0xFF, green: 0xFF, blue: 0x00, fAuto: 0x00)
        case 0x08:
            return COLORREF(red: 0xFF, green: 0xFF, blue: 0xFF, fAuto: 0x00)
        case 0x09:
            return COLORREF(red: 0x00, green: 0x00, blue: 0x80, fAuto: 0x00)
        case 0x0A:
            return COLORREF(red: 0x00, green: 0x80, blue: 0x80, fAuto: 0x00)
        case 0x0B:
            return COLORREF(red: 0x00, green: 0x80, blue: 0x00, fAuto: 0x00)
        case 0x0C:
            return COLORREF(red: 0x80, green: 0x00, blue: 0x80, fAuto: 0x00)
        case 0x0D:
            return COLORREF(red: 0x80, green: 0x00, blue: 0x80, fAuto: 0x00)
        case 0x0E:
            return COLORREF(red: 0x80, green: 0x80, blue: 0x00, fAuto: 0x00)
        case 0x0F:
            return COLORREF(red: 0x80, green: 0x80, blue: 0x80, fAuto: 0x00)
        default:
            return COLORREF(red: 0xC0, green: 0xC0, blue: 0xC0, fAuto: 0x00)
        }
    }
    
    public init(dataStream: inout DataStream) throws {
        /// value (1 byte): An unsigned integer which maps to a COLORREF according to the following. The value MUST be less than 0x11.
        try self.init(value: try dataStream.read())
    }
    
    public init(value: UInt8) throws {
        self.value = value
        if self.value > 0x11 {
            throw OfficeFileError.corrupted
        }
    }
}
