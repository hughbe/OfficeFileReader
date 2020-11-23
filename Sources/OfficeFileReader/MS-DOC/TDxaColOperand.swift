//
//  TDxaColOperand.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.322 TDxaColOperand
/// The TDxaColOperand structure is used by the sprmTDxaCol value and specifies a range of table cells and the width of each cell.
public struct TDxaColOperand {
    public let itc: ItcFirstLim
    public let dxaCol: XAS_nonNeg
    
    public init(dataStream: inout DataStream) throws {
        /// itc (2 bytes): An ItcFirstLim structure that specifies which cells this column width applies to.
        self.itc = try ItcFirstLim(dataStream: &dataStream)
        
        /// dxaCol (2 bytes): An XAS_nonNeg value that specifies the width of each of the columns, measured in twips. The width of a column
        /// is the measurement from the midpoint of the cell spacing before it to the midpoint of the cell spacing after it. For the first and last
        /// columns in a row, the width additionally includes the remainder of the cell spacing out to the outer border of the table
        self.dxaCol = try XAS_nonNeg(dataStream: &dataStream)
    }
}
