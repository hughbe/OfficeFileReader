//
//  LPUpxTapx.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.143 LPUpxTapx
/// The LPUpxTapx structure specifies table formatting properties. This structure is padded to an even length, but the length in cbUpx MUST NOT
/// include this padding.
public struct LPUpxTapx {
    public let cbUpx: UInt16
    public let tapx: UpxTapx
    
    public init(dataStream: inout DataStream) throws {
        /// cbUpx (2 bytes): An unsigned integer that specifies the size, in bytes, of TAPX. This value does not include padding.
        self.cbUpx = try dataStream.read(endianess: .littleEndian)
        
        /// TAPX (variable): A UpxTapx that specifies table formatting properties.
        self.tapx = try UpxTapx(dataStream: &dataStream, size: Int(self.cbUpx))
    }
}
