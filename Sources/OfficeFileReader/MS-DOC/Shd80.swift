//
//  Shd80.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.248 Shd80
/// The Shd80 structure specifies the colors and pattern that are used for background shading. As an exception to the constraints that are specified by Ico
/// and Ipat, a Shd80 can be set to Shd80Nil and specifies that no shading is applied. Shd80Nil is defined as the following Shd80.
/// Field Value
/// icoFore 0x1F
/// icoBack 0x1F
/// ipat 0x3F
public struct Shd80 {
    public let icoFore: Ico?
    public let icoBack: Ico?
    public let ipat: Ipat?
    
    public init(dataStream: inout DataStream) throws {
        let rawValue: UInt16 = try dataStream.read(endianess: .littleEndian)
        
        /// icoFore (5 bits): An Ico that specifies the foreground color of ipat.
        let icoForeRaw = UInt8(rawValue & 0b11111)
        
        /// icoBack (5 bits): An Ico that specifies the background color of ipat.
        let icoBackRaw = UInt8((rawValue >> 5) & 0b11111)
        
        /// ipat (6 bits): An Ipat that specifies the pattern used for shading.
        let ipatRaw = UInt8((rawValue >> 10) & 0b111111)
        
        if icoForeRaw == 0x1F && icoBackRaw == 0x1F && ipatRaw == 0x3F {
            self.icoFore = nil
            self.icoBack = nil
            self.ipat = nil
        } else {
            self.icoFore = try Ico(value: icoForeRaw)
            self.icoBack = try Ico(value: icoBackRaw)
            self.ipat = Ipat(rawValue: rawValue)
        }
    }
}
