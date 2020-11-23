//
//  YAS.swift
//  
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.355 YAS
/// The YAS value is a 16-bit signed integer that specifies vertical distance in twips. This value MUST be greater than or equal to -31680 and less than or
/// equal to 31680.
public struct YAS {
    public let value: Int16
    
    public init(dataStream: inout DataStream) throws {
        try self.init(value: try dataStream.read(endianess: .littleEndian))
    }
    
    public init(value: Int16) throws {
        self.value = value
        if self.value < -31680 || self.value > 31680 {
            throw OfficeFileError.corrupted
        }
    }
}
