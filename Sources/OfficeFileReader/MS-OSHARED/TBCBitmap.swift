//
//  TBCBitmap.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.1.1 TBCBitmap
/// Referenced by: TBCBSpecific
/// Specifies a bitmap used to store a custom icon used by a toolbar control.
public struct TBCBitmap {
    public let cbDIB: Int32
    public let biHeader: BITMAPINFOHEADER
    public let colors: [RGBQuad]?
    public let bitmapData: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        /// cbDIB (4 bytes): Signed integer that specifies the count of total bytes, excluding this field, in the TBCBitmap structure plus 10. The value
        /// is given by the following formula: cbDIB = sizeOf(biHeader) + sizeOf(colors) + sizeOf(bitmapData) + 10
        /// The value MUST be greater than or equal to 40, and MUST be less than or equal to 65576 (which is a bitmap that is 128 pixels high, 128
        /// pixels wide at 32 bits of color per pixel plus 40 ((128 * 128 * 32 / 8) + 40)).
        let cbDIB: Int32 = try dataStream.read(endianess: .littleEndian)
        if cbDIB < 40 || cbDIB > 65576 {
            throw OfficeFileError.corrupted
        }
        
        self.cbDIB = cbDIB
        
        /// biHeader (30 bytes): A BITMAPINFOHEADER structure (section 2.3.1.2) that contains information about this bitmap.
        self.biHeader = try BITMAPINFOHEADER(dataStream: &dataStream)
        
        /// colors (variable): Zero-based array of RGBQuad structures (section 2.3.1.3). MUST exist only if biHeader.biBitCount is less than or equal
        /// to 0x08. The number of elements in this array MUST be equal to 2^biHeader.biBitCount.
        if self.biHeader.biBitCount <= 0x08 {
            var colors: [RGBQuad] = []
            let count = 2 << (biHeader.biBitCount - 1)
            colors.reserveCapacity(Int(count))
            for _ in 0..<count {
                colors.append(try RGBQuad(dataStream: &dataStream))
            }
            
            self.colors = colors
        } else {
            self.colors = nil
        }
        
        /// bitmapData (variable): An array of bytes as specified by the aData field of a DeviceIndependentBitmap object specified in [MS-WMF]
        /// section 2.2.2.9. The number of bytes in this array MUST be equal to cbDIB – sizeOf(colors) – sizeOf(biHeader) -10. The number of bytes
        /// in this array is also calculated with the following formula: Number of bytes in bitmapData = ((biHeader.biWidth * biHeader.biBitCount + 31)
        /// & ~31) / 8 * biHeader.biHeight
        let width = ((UInt32(self.biHeader.biWidth) * UInt32(self.biHeader.biBitCount) + 31) & ~31)
        let size = width / 8 * UInt32(self.biHeader.biHeight)
        self.bitmapData = try dataStream.readBytes(count: Int(size))
    }
}
