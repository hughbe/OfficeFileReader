//
//  CellRangeTextFlow.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.29 CellRangeTextFlow
/// The CellRangeTextFlow structure specifies a range of cells in a table row, and the text flow model of the cell contents.
public struct CellRangeTextFlow {
    public let itc: ItcFirstLim
    public let tf: TextFlow
    
    public init(dataStream: inout DataStream) throws {
        /// itc (2 bytes): An ItcFirstLim that specifies a cell range in the table row.
        self.itc = try ItcFirstLim(dataStream: &dataStream)
        
        /// tf (2 bytes): A TextFlow that specifies how contents in each cell flow, and how text is rotated.
        let tfRaw: UInt16 = try dataStream.read(endianess: .littleEndian)
        guard let tf = TextFlow(rawValue: tfRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.tf = tf
    }
}

