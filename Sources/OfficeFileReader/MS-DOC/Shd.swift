//
//  Shd.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.247 Shd
/// The Shd structure specifies the colors and pattern that are used for background shading. ShdAuto is a special value for Shd that specifies that no
/// shading is applied and is defined as the following Shd.
/// ShdNil is a special value for Shd. If ShdNil is used in a Table Style definition, ShdNil is ignored and the shading of the cell is not affected. If ShdNil
/// is applied outside of a Table Style, ShdNil specifies that no shading is applied. ShdNil is defined as the following Shd.
public struct Shd {
    public let cvFore: COLORREF
    public let cvBack: COLORREF
    public let ipat: Ipat
    
    public init(dataStream: inout DataStream) throws {
        /// cvFore (4 bytes): A COLORREF that specifies the foreground color of ipat.
        self.cvFore = try COLORREF(dataStream: &dataStream)
        
        /// cvBack (4 bytes): A COLORREF that specifies the background color of ipat.
        self.cvBack = try COLORREF(dataStream: &dataStream)
        
        /// ipat (2 bytes): An Ipat that specifies the pattern used for shading.
        let ipatRaw: UInt16 = try dataStream.read(endianess: .littleEndian)
        guard let ipat = Ipat(rawValue: ipatRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.ipat = ipat
    }
}
