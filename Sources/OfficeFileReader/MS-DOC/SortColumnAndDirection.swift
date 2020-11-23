//
//  SortColumnAndDirection.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.252 SortColumnAndDirection
/// The SortColumnAndDirection structure specifies the sort order and the column by which the list of mail merge recipients is sorted.
public struct SortColumnAndDirection {
    public let iColumn: UInt32
    public let iDirection: Direction
    
    public init(dataStream: inout DataStream) throws {
        /// iColumn (4 bytes): An unsigned integer that specifies the zero-based index of the database column to which this filter applies. This
        /// value MUST be greater than or equal to zero and MUST be less than or equal to 254.
        self.iColumn = try dataStream.read(endianess: .littleEndian)
        if self.iColumn > 254 {
            throw OfficeFileError.corrupted
        }
        
        /// iDirection (4 bytes): An unsigned integer that specifies the sort order to be used when sorting the associated column. The value MUST
        /// be zero (ascending) or 1 (descending).
        let iDirectionRaw: UInt32 = try dataStream.read(endianess: .littleEndian)
        guard let iDirection = Direction(rawValue: iDirectionRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.iDirection = iDirection
    }
    
    /// iDirection (4 bytes): An unsigned integer that specifies the sort order to be used when sorting the associated column. The value MUST
    /// be zero (ascending) or 1 (descending).
    public enum Direction: UInt32 {
        case ascending = 0
        case descending = 1
    }
}
