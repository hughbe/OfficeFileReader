//
//  StkParaLPUpxGrLPUpxRM.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.268 StkParaLPUpxGrLPUpxRM
/// The StkParaLPUpxGrLPUpxRM structure specifies revision-marking information and formatting for paragraph styles. This structure is
/// length-prefixed and of variable length.
public struct StkParaLPUpxGrLPUpxRM {
    public let cbStkParaUpxGrLpUpxRM: UInt16
    public let stkParaUpxGrLpUpxRM: StkParaUpxGrLPUpxRM
    
    public init(dataStream: inout DataStream) throws {
        /// cbStkParaUpxGrLpUpxRM (2 bytes): An unsigned 16-bit integer that specifies the size, in bytes, of StkParaUpxGrLpUpxRM,
        /// including the padding.
        self.cbStkParaUpxGrLpUpxRM = try dataStream.read(endianess: .littleEndian)
        
        /// StkParaUpxGrLpUpxRM (variable): An StkParaUpxGrLPUpxRM structure that specifies revisionmarking information and formatting.
        self.stkParaUpxGrLpUpxRM = try StkParaUpxGrLPUpxRM(dataStream: &dataStream, size: Int(self.cbStkParaUpxGrLpUpxRM))
    }
}
