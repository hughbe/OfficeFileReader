//
//  BITMAPINFOHEADER.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.1.2 BITMAPINFOHEADER
/// Referenced by: TBCBitmap
/// Bitmap header. Contains information about a bitmap.
public struct BITMAPINFOHEADER {
    public let bData: UInt32
    public let biWidth: Int16
    public let biHeight: Int16
    public let biPlanes: UInt8
    public let biBitCount: UInt8
    public let biCompression: UInt16
    public let biSizeImage: UInt16
    public let biXPelsPerMeter: UInt32
    public let biYPelsPerMeter: UInt32
    public let biClrUsed: UInt32
    public let biClrImportant: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// bData (4 bytes): Unsigned integer. MUST be 0x00000028.
        self.bData = try dataStream.read(endianess: .littleEndian)
        if self.bData != 0x00000028 {
            throw OfficeFileError.corrupted
        }
        
        /// biWidth (2 bytes): Signed integer that specifies the width of the bitmap in pixels. MUST be positive and less than or equal to 0x0080.
        let biWidth: Int16 = try dataStream.read(endianess: .littleEndian)
        if biWidth < 0 || biWidth > 0x80 {
            throw OfficeFileError.corrupted
        }
        
        self.biWidth = biWidth
        
        /// biHeight (2 bytes): Signed integer that specifies the height of the bitmap in pixels. MUST be positive and less than or equal to 0x0080.
        let biHeight: Int16 = try dataStream.read(endianess: .littleEndian)
        if biHeight < 0 || biHeight > 0x80 {
            throw OfficeFileError.corrupted
        }
        
        self.biHeight = biHeight
        
        /// biPlanes (1 byte): Unsigned integer that MUST be 0x01.
        self.biPlanes = try dataStream.read()
        if self.biPlanes != 0x01 {
            throw OfficeFileError.corrupted
        }

        /// biBitCount (1 byte): Unsigned integer that specifies the number of bits per pixel. MUST be equal to one of the values in the following table.
        /// Value of biBitCount
        /// 0x01
        /// 0x04
        /// 0x08
        /// 0x10
        /// 0x18
        /// 0x20
        let biBitCount: UInt8 = try dataStream.read()
        if biBitCount != 0x01 &&
            biBitCount != 0x04 &&
            biBitCount != 0x08 &&
            biBitCount != 0x10 &&
            biBitCount != 0x18 &&
            biBitCount != 0x20 {
            throw OfficeFileError.corrupted
        }
        
        self.biBitCount = biBitCount
        
        /// biCompression (2 bytes): Unsigned integer that specifies the bitmap compression format. A value of 0x0000 means that the bitmap is
        /// uncompressed. The value MUST be 0x0000.
        self.biCompression = try dataStream.read(endianess: .littleEndian)
        if self.biCompression != 0x0000 {
            throw OfficeFileError.corrupted
        }
        
        /// biSizeImage (2 bytes): Unsigned integer that specifies the size, in bytes, of the image. The value SHOULD specify the size of the
        /// bitmapData array of the TBCBitmap structure (section 2.3.1.1) that contains this structure and is given by the following formula.
        /// For uncompressed bitmaps, this value is equal to 0x0000 and does not specify the size of the image.
        /// biSizeImage = ((biHeader.biWidth * biHeader.biBitCount + 31) & ~31) / 8 * biHeader.biHeight
        self.biSizeImage = try dataStream.read(endianess: .littleEndian)
        
        /// biXPelsPerMeter (4 bytes): MUST be 0x00000000 and MUST be ignored.
        self.biXPelsPerMeter = try dataStream.read(endianess: .littleEndian)
        
        /// biYPelsPerMeter (4 bytes): MUST be 0x00000000 and MUST be ignored.
        self.biYPelsPerMeter = try dataStream.read(endianess: .littleEndian)
        
        /// biClrUsed (4 bytes): Unsigned integer as specified by the ColorUsed field of the BitmapInfoHeader object specified in [MS-WMF] section
        /// 2.2.2.3. MUST be 0x00000000.
        self.biClrUsed = try dataStream.read(endianess: .littleEndian)
        if self.biClrUsed != 0x00000000 {
            throw OfficeFileError.corrupted
        }
        
        /// biClrImportant (4 bytes): Unsigned integer as specified by the ColorImportant field of the BitmapInfoHeader object specified in [MS-WMF]
        /// section 2.2.2.3. MUST be 0x00000000.
        self.biClrImportant = try dataStream.read(endianess: .littleEndian)
        if self.biClrImportant != 0x00000000 {
            throw OfficeFileError.corrupted
        }
    }
}
