//
//  WebScreenSize.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

/// [MS-OSHARED] 2.2.1.4 WebScreenSizeEnum
/// An enumeration that specifies the screen resolution for the target monitor on which the Web page is to be displayed. Values are described in the
/// following table.
public enum WebScreenSizeEnum: UInt8 {
    /// MSOWOPTScreenSize544x376 0x00 544 by 376 pixels
    /// MSOWOPTScreenSizeWebTV 0x00 544 by 376 pixels
    case screenSize544x376 = 0x00
    
    /// MSOWOPTScreenSize640x480 0x01 640 by 480 pixels
    case screenSize640x480 = 0x01
    
    /// MSOWOPTScreenSize720x512 0x02 720 by 512 pixels
    case screenSize720x512 = 0x02
    
    /// MSOWOPTScreenSize800x600 0x03 800 by 600 pixels
    case screenSize800x600 = 0x03
    
    /// MSOWOPTScreenSize1024x768 0x04 1024 by 768 pixels
    case screenSize1024x768 = 0x04
    
    /// MSOWOPTScreenSize1152x882 0x05 1152 by 882 pixels
    case screenSize1152x882 = 0x05
    
    /// MSOWOPTScreenSize1152x900 0x06 1152 by 900 pixels
    case screenSize1152x900 = 0x06
    
    /// MSOWOPTScreenSize1280x1024 0x07 1280 by 1024 pixels
    case screenSize1280x1024 = 0x07
    
    /// MSOWOPTScreenSize1600x1200 0x08 1600 by 1200 pixels
    case screenSize1600x1200 = 0x08
    
    /// MSOWOPTScreenSize1800x1440 0x09 1800 by 1440 pixels
    case screenSize1800x1440 = 0x09
    
    /// MSOWOPTScreenSize1920x1200 0x0A 1920 by 1200 pixels
    case sScreenSize1920x1200 = 0x0A
}
