//
//  CellRangeFitText.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.27 CellRangeFitText
/// The CellRangeFitText structure is an operand that is used by sprmTFitText. This operand specifies a set of cells in a table row, and whether their
/// contents stretch or compress to fill their widths.
public struct CellRangeFitText {
    public let itc: ItcFirstLim
    public let fFitText: Bool8
    
    public init(dataStream: inout DataStream) throws {
        /// itc (2 bytes): A ItcFirstLim structure that specifies a cell range in the table row.
        self.itc = try ItcFirstLim(dataStream: &dataStream)
        
        /// fFitText (1 byte): A Bool8. When set, the contents of each table cell only line wrap at the end of a paragraph, or at a line break character.
        /// Furthermore, the application SHOULD apply other properties as necessary to cause the contents of the first line in each cell to stretch
        /// or compress such that they exactly fill the width of the table cell.
        self.fFitText = try dataStream.read()    
    }
}
