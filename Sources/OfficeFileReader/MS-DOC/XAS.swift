//
//  XAS.swift
//
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.349 XAS
/// The XAS value is a 16-bit signed integer that specifies horizontal distance in twips. This value MUST be greater than or equal to -31680 and less than
/// or equal to 31680.
public struct XAS {
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
