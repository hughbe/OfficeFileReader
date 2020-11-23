//
//  RgxOcxInfo.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.229 RgxOcxInfo
/// The RgxOcxInfo structure is an array of OcxInfo structures.
public struct RgxOcxInfo {
    public let cOcxInfo: UInt32
    public let rgocxinfo: [OcxInfo]
    
    public init(dataStream: inout DataStream) throws {
        /// cOcxInfo (4 bytes): An unsigned integer that specifies the number of OcxInfo structures in rgocxinfo.
        self.cOcxInfo = try dataStream.read(endianess: .littleEndian)

        /// rgocxinfo (variable): An array of OcxInfo structures.
        var rgocxinfo: [OcxInfo] = []
        rgocxinfo.reserveCapacity(Int(self.cOcxInfo))
        for _ in 0..<self.cOcxInfo {
            rgocxinfo.append(try OcxInfo(dataStream: &dataStream))
        }
        
        self.rgocxinfo = rgocxinfo
    }
}
