//
//  ItcFirstLim.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.123 ItcFirstLim
/// The ItcFirstLim structure specifies a range of cells in a table row. The range is inclusive of the first index, and exclusive of the second. The first cell in a
/// row is at index 0. The maximum number of cells in a row is 63.
public struct ItcFirstLim {
    public let itcFirst: Int8
    public let itcLim: Int8
    
    public init(dataStream: inout DataStream) throws {
        /// itcFirst (8 bits): An integer value that specifies the index of the first cell in a contiguous range. The cell at this index is inside the range. This
        /// value MUST be non-negative and MUST be less than the number of cells in the row.
        let itcFirst: Int8 = try dataStream.read(endianess: .littleEndian)
        if itcFirst < 0 || itcFirst > 63 {
            throw OfficeFileError.corrupted
        }
        
        self.itcFirst = itcFirst

        /// itcLim (8 bits): An integer value that specifies the index of the first cell beyond the contiguous range. The cell at this index is outside the range.
        /// This value MUST be greater than or equal to itcFirst and MUST be less than or equal to the number of cells in the row. When itcLim is equal
        /// to itcFirst, the range contains zero cells.
        let itcLim: Int8 = try dataStream.read(endianess: .littleEndian)
        if itcLim < itcFirst || itcLim > 63 {
            throw OfficeFileError.corrupted
        }
        
        self.itcLim = itcLim
    }
}
