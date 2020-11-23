//
//  MSOBLIPTYPE.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

/// [MS-ODRAW] 2.4.1 MSOBLIPTYPE
/// Referenced by: OfficeArtFBSE
/// The MSOBLIPTYPE enumeration, as shown in the following table, specifies the persistence format of bitmap data.
public enum MSOBLIPTYPE: UInt8 {
    /// msoblipERROR 0x00 Error reading the file.
    case error = 0x00
    
    /// msoblipUNKNOWN 0x01 Unknown BLIP type.
    case unknown = 0x01
    
    /// msoblipEMF 0x02 EMF.
    case emf = 0x02
    
    /// msoblipWMF 0x03 WMF.
    case wmf = 0x03
    
    /// msoblipPICT 0x04 Macintosh PICT.
    case pict = 0x04
    
    /// msoblipJPEG 0x05 JPEG.
    case jpeg = 0x05
    
    /// msoblipPNG 0x06 PNG.
    case png = 0x06
    
    /// msoblipDIB 0x07 DIB
    case dib = 0x07
    
    /// msoblipTIFF 0x11 TIFF
    case tiff = 0x11
    
    /// msoblipCMYKJPEG 0x12 JPEG in the YCCK or CMYK color space.
    case cmykJpeg = 0x12
    
}
