//
//  FilterDataItem.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.87 FilterDataItem
/// The FilterDataItem structure contains data that is used to filter a list of mail merge recipients.
public struct FilterDataItem {
    public let cbItem: UInt32
    public let iColumn: UInt32
    public let iComparisonOperator: ComparisonOperator
    public let iCondition: Condition
    public let rgwchFilter: String
    
    public init(dataStream: inout DataStream) throws {
        /// cbItem (4 bytes): An unsigned integer that specifies the size, in bytes, of this FilterDataItem.
        self.cbItem = try dataStream.read(endianess: .littleEndian)
        
        /// iColumn (4 bytes): An unsigned integer that specifies the zero-based index of the database column to which this filter applies. This value
        /// MUST be greater than or equal to zero and MUST be less than or equal to 254.
        self.iColumn = try dataStream.read(endianess: .littleEndian)
        if self.iColumn > 254 {
            throw OfficeFileError.corrupted
        }
        
        /// iComparisonOperator (4 bytes): An unsigned integer that specifies the comparison operator to be used for the comparison. This MUST be
        /// one of the following values.
        let iComparisonOperatorRaw: UInt32 = try dataStream.read(endianess: .littleEndian)
        guard let iComparisonOperator = ComparisonOperator(rawValue: iComparisonOperatorRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.iComparisonOperator = iComparisonOperator
        
        /// iCondition (4 bytes): An unsigned integer that specifies how this comparison is combined with other comparisons in the filter. This value
        /// MUST be zero (logical AND) or 1 (logical OR).
        let iConditionRaw: UInt32 = try dataStream.read(endianess: .littleEndian)
        guard let iCondition = Condition(rawValue: iConditionRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.iCondition = iCondition
        
        /// rgwchFilter (variable): A Unicode string that specifies the value to be used as the basis for the comparison. The string is null-terminated
        /// and MUST contain no more than 212 characters.
        self.rgwchFilter = try dataStream.readUnicodeString(endianess: .littleEndian)!
        if self.rgwchFilter.count > 212 {
            throw OfficeFileError.corrupted
        }
    }
    
    /// iComparisonOperator (4 bytes): An unsigned integer that specifies the comparison operator to be used for the comparison. This MUST be
    /// one of the following values.
    public enum ComparisonOperator: UInt32 {
        /// 0x00000000 Equal.
        case equal = 0x00000000
        
        /// 0x00000001 Not equal.
        case notEqual = 0x00000001
        
        /// 0x00000002 Less than.
        case lessThan = 0x00000002
        
        /// 0x00000003 Greater than.
        case greaterThan = 0x00000003
        
        /// 0x00000004 Less than or equal.
        case lessThanOrEqual = 0x00000004
        
        /// 0x00000005 Greater than or equal.
        case greaterThanOrEqual = 0x00000005
        
        /// 0x00000006 Empty.
        case empty = 0x00000006
        
        /// 0x00000007 Not empty.
        case notEmpty = 0x00000007
    }
    
    /// iCondition (4 bytes): An unsigned integer that specifies how this comparison is combined with other comparisons in the filter. This value
    /// MUST be zero (logical AND) or 1 (logical OR).
    public enum Condition: UInt32 {
        case and = 0
        case or = 1
    }
}
