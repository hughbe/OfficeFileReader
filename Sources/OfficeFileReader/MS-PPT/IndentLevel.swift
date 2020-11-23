//
//  IndentLevel.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-PPT] 2.2.13 IndentLevel
/// Referenced by: MasterTextPropRun, TextPFRun
/// A 2-byte unsigned integer that specifies a text paragraph indent level. It MUST be less than or equal to 0x0004.
public struct IndentLevel {
    public let value: UInt16
    
    public init(dataStream: inout DataStream) throws {
        self.value = try dataStream.read(endianess: .littleEndian)
        if self.value > 0x0004 {
            throw OfficeFileError.corrupted
        }
    }
}
