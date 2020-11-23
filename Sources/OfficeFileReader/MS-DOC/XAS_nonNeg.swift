//
//  XAS_nonNeg.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.350 XAS_nonNeg
/// The XAS_nonNeg value is a 16-bit unsigned integer that specifies horizontal distance, in twips. This value MUST be less than or equal to 31680.
public struct XAS_nonNeg {
    public let value: UInt16
    
    public init(dataStream: inout DataStream) throws {
        try self.init(value: try dataStream.read(endianess: .littleEndian))
    }
    
    public init(value: UInt16) throws {
        self.value = value
        if self.value > 31680 {
            throw OfficeFileError.corrupted
        }
    }
}
