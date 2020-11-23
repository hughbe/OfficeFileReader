//
//  CDB.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.25 CDB
/// The CDB structure contains implementation-specific binary data that represents a grammar checker cookie that is stored by the given grammar checker.
public struct CDB {
    public let cbData: UInt32
    public let rgbCookieData: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        /// cbData (4 bytes): An unsigned integer value that specifies the length of rgbCookieData, in bytes.
        self.cbData = try dataStream.read(endianess: .littleEndian)
        
        /// rgbCookieData (variable): An array of BYTE. The grammar checker cookie data.
        self.rgbCookieData = try dataStream.readBytes(count: Int(self.cbData))
    }
}
