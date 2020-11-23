//
//  RecolorEntryBrush.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.7.13 RecolorEntryBrush
/// Referenced by: RecolorEntryVariant
/// A structure that specifies a source color for a RecolorEntry that corresponds to a LogBrush Object as specified in [MS-WMF] section 2.2.2.10.
/// The meaning of the fields corresponds to the meaning of the fields of a LogBrush Object.
public struct RecolorEntryBrush {
    public let type: UInt16
    public let lbStyle: BrushStyle
    public let lbColor: WideColorStruct
    public let lbHatch: HatchStyle
    public let fgColor: WideColorStruct
    public let bgColor: WideColorStruct
    public let bitmapType: BitmapType
    public let pattern: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        /// type (2 bytes): An unsigned integer that specifies the variant of the containing RecolorEntryVariant structure. It MUST be 0x0001.
        self.type = try dataStream.read(endianess: .littleEndian)
        if self.type != 0x0001 {
            throw OfficeFileError.corrupted
        }
        
        /// lbStyle (2 bytes): An unsigned integer that specifies a brush type. It MUST be a BrushStyle Enumeration as specified in [MS-WMF] section 2.1.1.4.
        let lbStyleRaw: UInt16 = try dataStream.read(endianess: .littleEndian)
        guard let lbStyle = BrushStyle(rawValue: lbStyleRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.lbStyle = lbStyle
        
        /// lbColor (6 bytes): A WideColorStruct structure that specifies the color of the LogBrush Object. Its interpretation depends on the value of lbStyle
        /// and is specified in [MS-WMF] section 2.2.2.10.
        self.lbColor = try WideColorStruct(dataStream: &dataStream)
        
        /// lbHatch (2 bytes): An unsigned integer that specifies a brush hatch type. Its interpretation depends on the value of lbStyle and is specified in
        /// [MS-WMF] section 2.1.1.12.
        let lbHatchRaw: UInt16 = try dataStream.read(endianess: .littleEndian)
        guard let lbHatch = HatchStyle(rawValue: lbHatchRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.lbHatch = lbHatch
        
        /// fgColor (6 bytes): A WideColorStruct structure that specifies a foreground color. Only used for metafile records of type
        /// META_DIBCREATEPATTERNBRUSH, specified in [MS-WMF] section 2.3.4.8. This field represents the color of the first entry of the DIB color table,
        /// specified in [MS-WMF] section 2.2.2.3. Undefined and MUST be ignored if lbStyle is not equal to 0x0003.
        self.fgColor = try WideColorStruct(dataStream: &dataStream)
        
        /// bgColor (6 bytes): A WideColorStruct structure that specifies a background color. Only used for metafile records of type
        /// META_DIBCREATEPATTERNBRUSH, as specified in [MS-WMF] section 2.3.4.8. This field represents the color of the second entry of the DIB
        /// color table, as specified in [MS-WMF] section 2.2.2.3. Undefined and MUST be ignored if lbStyle is not equal to 0x0003.
        self.bgColor = try WideColorStruct(dataStream: &dataStream)
        
        /// bitmapType (2 bytes): An unsigned integer that specifies the type of the bitmap if lbStyle is equal to 0x0003. It MUST also be a value from the
        /// following table.
        let bitmapTypeRaw: UInt16 = try dataStream.read(endianess: .littleEndian)
        guard let bitmapType = BitmapType(rawValue: bitmapTypeRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.bitmapType = bitmapType
        
        /// pattern (8 bytes): An array of bytes that specifies the bit pattern for a monochrome 8x8 pixel brush. Undefined and MUST be ignored if lbStyle
        /// is not equal to 0x0003 or if bitmapType is equal to 0x0003. If bitmapType is equal to 0x0000 it specifies the Bits field for a
        /// META_CREATEPATTERNBRUSH record as specified in [MS-WMF] section 2.3.4.4. If bitmapType is equal to 0x0001 it specifies the Bits field
        /// of a DeviceIndependentBitmap (DIB) Object ([MS-WMF] section 2.2.2.3) for a META_DIBCREATEPATTERNBRUSH record as specified in
        /// [MS-WMF] sections 2.3.4.8.
        self.pattern = try dataStream.readBytes(count: 8)
    }
    
    /// bitmapType (2 bytes): An unsigned integer that specifies the type of the bitmap if lbStyle is equal to 0x0003. It MUST also be a value from the
    /// following table.
    public enum BitmapType: UInt16 {
        /// 0x0000 Color mapping is used for META_CREATEPATTERNBRUSH records with a monochrome pattern bitmap.
        case CREATEPATTERNBRUSHWithMonochromePatternBitmap = 0x0000
        
        /// 0x0001 Color mapping is used for META_DIBCREATEPATTERNBRUSH records.
        case DIBCREATEPATTERNBRUSH = 0x0001
        
        /// 0x0003 Color mapping is used for META_CREATEBRUSHINDIRECT records and META_CREATEPATTERNBRUSH records with a
        /// non-monochrome pattern bitmap.
        case CREATEPATTERNBRUSHWithNonMonochromePatternBitmap = 0x0003
    }
}
