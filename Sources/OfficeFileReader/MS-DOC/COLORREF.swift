//
//  COLORREF.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.43 COLORREF
/// The COLORREF structure specifies a color in terms of its red, green, and blue components.
public struct COLORREF {
    public let red: UInt8
    public let green: UInt8
    public let blue: UInt8
    public let fAuto: UInt8
    
    public init(red: UInt8, green: UInt8, blue: UInt8, fAuto: UInt8) {
        self.red = red
        self.green = green
        self.blue = blue
        self.fAuto = fAuto
    }
    
    public init(dataStream: inout DataStream) throws {
        /// red (1 byte): An unsigned integer that specifies the intensity of the color red. A value of zero specifies that there is no red. Larger numbers
        /// specify a more intense red than smaller numbers.
        self.red = try dataStream.read()
        
        /// green (1 byte): An unsigned integer that specifies the intensity of the color green. A value of zero specifies that there is no green. Larger numbers
        /// specify a more intense green than smaller numbers.
        self.green = try dataStream.read()
        
        /// blue (1 byte): An unsigned integer that specifies the intensity of the color blue. A value of zero specifies that there is no blue. Larger numbers
        /// specify a more intense blue than smaller numbers.
        self.blue = try dataStream.read()
        
        /// fAuto (1 byte): An unsigned integer whose value MUST be either 0xFF or 0x00. If the value is 0xFF, the values of red, green, and blue in this
        /// COLORREF SHOULD<209> all be 0x00. If fAuto is 0xFF, this COLORREF designates the default color for the application. An application
        /// MAY<210> use different default colors based on context. This documentation refers to the COLORREF with fAuto set to 0xFF as cvAuto.
        let fAuto: UInt8 = try dataStream.read()
        if fAuto != 0x00 && fAuto != 0xFF {
            throw OfficeFileError.corrupted
        }
        
        self.fAuto = fAuto
    }
}
