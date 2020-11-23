//
//  SDxaColSpacingOperand.swift
//
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.241 SDxaColSpacingOperand
/// The SDxaColSpacingOperand structure is the operand to Sprm structures that control column size and spacing.
public struct SDxaColSpacingOperand {
    public let iCol: UInt8
    public let dxaCol: XAS_nonNeg
    
    public init(dataStream: inout DataStream) throws {
        /// iCol (1 byte): An unsigned integer that specifies the zero-based index of the column that is being referenced by the Sprm.
        /// This value MUST be less than or equal to 43.
        self.iCol = try dataStream.read()
        if self.iCol > 43 {
            throw OfficeFileError.corrupted
        }
        
        /// dxaCol (2 bytes): An XAS_nonNeg value that specifies the space after the column that is specified by iCol.
        self.dxaCol = try XAS_nonNeg(dataStream: &dataStream)
    }
}
