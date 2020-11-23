//
//  MSOCR.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.44 MSOCR
/// Referenced by: OfficeArtColorMRUContainer, OfficeArtSplitMenuColorContainer
/// The MSOCR record specifies either the RGB color or the scheme color index.
public struct MSOCR {
    public let red: UInt8
    public let green: UInt8
    public let blue: UInt8
    public let unused1: UInt8
    public let fSchemeIndex: Bool
    public let unused2: UInt8
    
    public init(dataStream: inout DataStream) throws {
        /// red (1 byte): An unsigned byte that specifies the intensity of the red color channel. A value of 0x00 specifies no red color. A value of 0xFF
        /// specifies full red intensity.
        self.red = try dataStream.read()
        
        /// green (1 byte): An unsigned byte that specifies the intensity of the green color channel. A value of 0x00 specifies no green color. A value of
        /// 0xFF specifies full green intensity.
        let green: UInt8 = try dataStream.read()
        self.green = green
        
        /// blue (1 byte): An unsigned byte that specifies the intensity of the blue color channel. A value of 0x00 specifies no blue color. A value of 0xFF
        /// specifies full blue intensity.
        let blue: UInt8 = try dataStream.read()
        self.blue = blue
        
        var flags: BitFieldReader<UInt8> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - unused1 (3 bits): A value that is undefined and MUST be ignored.
        self.unused1 = flags.readBits(count: 3)
        
        /// B - fSchemeIndex (1 bit): A bit that specifies whether the current color scheme will be used to determine the color. A value of 0x1 specifies that
        /// red is an index into the current scheme color table. If this value is 0x1, green and blue MUST be 0x00.
        self.fSchemeIndex = flags.readBit()
        if self.fSchemeIndex && (green != 0x00 || blue != 0x00) {
            //throw OfficeFileError.corrupted
        }
        
        /// unused2 (4 bits): A value that is undefined and MUST be ignored.
        self.unused2 = flags.readRemainingBits()
    }
}
