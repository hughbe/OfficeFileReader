//
//  StkCharLPUpxGrLPUpxRM.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.264 StkCharLPUpxGrLPUpxRM
/// The StkCharLPUpxGrLPUpxRM structure specifies revision-marking information and formatting for character styles. The structure is padded
/// to be an even length. The length in cbStkCharUpxGrLpUpxRM MUST include this padding.
public struct StkCharLPUpxGrLPUpxRM {
    public let cbStkCharUpxGrLpUpxRM: UInt16
    public let stkCharUpxGrLpUpxRM: StkCharUpxGrLPUpxRM
    
    public init(dataStream: inout DataStream) throws {
        /// cbStkCharUpxGrLpUpxRM (2 bytes): An unsigned 16-bit integer that specifies the size, in bytes, of StkCharUpxGrLpUpxRM.
        /// This field MUST include padding if it is needed to make StkCharLPUpxGrLPUpxRM an even length.
        self.cbStkCharUpxGrLpUpxRM = try dataStream.read(endianess: .littleEndian)
        
        /// StkCharUpxGrLpUpxRM (variable): A StkCharUpxGrLPUpxRM that specifies revision-marking information and formatting.
        self.stkCharUpxGrLpUpxRM = try StkCharUpxGrLPUpxRM(dataStream: &dataStream, size: Int(self.cbStkCharUpxGrLpUpxRM))
    }
}
