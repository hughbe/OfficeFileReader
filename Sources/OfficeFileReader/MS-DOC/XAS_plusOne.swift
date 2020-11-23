//
//  XAS_nonNeg.swift
//
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.351 XAS_plusOne
/// The XAS_plusOne value is a 16-bit signed integer that specifies the horizontal distance, in twips, after the stored value is decremented by 1. This value
/// MUST be greater than or equal to -31679 and less than or equal to 31681.
public struct XAS_plusOne {
    public let value: Int16
    
    public init(dataStream: inout DataStream) throws {
        try self.init(value: try dataStream.read(endianess: .littleEndian))
    }
    
    public init(value: Int16) throws {
        self.value = value
        if self.value < -31679 || self.value > 31679 {
            throw OfficeFileError.corrupted
        }
    }
}
