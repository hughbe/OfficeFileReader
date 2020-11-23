//
//  TInsertOperand.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.324 TInsertOperand
/// The TInsertOperand structure is an operand that is used by the sprmTInsert value and specifies a range of default table cell definitions to add to
/// a table row.
public struct TInsertOperand {
    public let itcFirst: UInt8
    public let ctc: UInt8
    public let dxaCol: XAS_nonNeg
    
    public init(dataStream: inout DataStream) throws {
        /// itcFirst (1 byte): An unsigned integer that specifies the zero-based index of the first new table cell definition.
        self.itcFirst = try dataStream.read()
        
        /// ctc (1 byte): An unsigned integer that specifies the number of new table cells. This value MUST be greater than zero. Table rows MUST
        /// NOT have more than 63 cells after the insertion.
        self.ctc = try dataStream.read()
        if self.ctc > 63 {
            throw OfficeFileError.corrupted
        }
        
        /// dxaCol (2 bytes): An XAS_nonNeg value that specifies the width of each of the new cells. The total width of the table after inserting the
        /// new cells MUST NOT exceed 31680 twips.
        self.dxaCol = try XAS_nonNeg(dataStream: &dataStream)
    }
}
