//
//  TDefTableOperand.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.321 TDefTableOperand
/// The TDefTableOperand structure is the operand that is used by the sprmTDefTable value. It specifies the initial layout of the columns in the
/// current table row.
public struct TDefTableOperand {
    public let cb: UInt16
    public let numberOfColumns: UInt8
    public let rgdxaCenter: [XAS]
    public let rgTc80: [TC80]
    
    public init(dataStream: inout DataStream) throws {
        /// cb (2 bytes): An unsigned integer that specifies the number of bytes that are used by the remainder of this structure, incremented by 1.
        self.cb = try dataStream.read(endianess: .littleEndian)
        
        let startPosition = dataStream.position
        
        /// NumberOfColumns (1 byte): An integer that specifies the number of columns in this table. The number MUST be at least zero, and
        /// MUST NOT exceed 63.
        self.numberOfColumns = try dataStream.read()
        if self.numberOfColumns > 63 {
            throw OfficeFileError.corrupted
        }
        
        /// rgdxaCenter (variable): An array of XAS. There MUST be exactly one XAS value in this array for every column specified in
        /// NumberOfColumns, incremented by 1. The first entry specifies the horizontal position of the logical left edge of the table, as indented from
        /// the logical left page margin. The remaining entries specify the horizontal positions of the logical right edges of each cell progressing logical
        /// right across the row. More specifically, the positions for all edges between cells are the midpoints of the inter-cell spacing. The first and
        /// last entries specify the positions of the outer edges of the table, including all cell spacing. The values in the array MUST be in
        /// nondecreasing order.
        var rgdxaCenter: [XAS] = []
        rgdxaCenter.reserveCapacity(Int(self.numberOfColumns + 1))
        for _ in 0..<self.numberOfColumns + 1 {
            rgdxaCenter.append(try XAS(dataStream: &dataStream))
        }
        
        self.rgdxaCenter = rgdxaCenter
        
        /// rgTc80 (variable): An array of TC80 that specifies the default formatting for a cell in the table. Each TC80 in the array corresponds to the
        /// equivalent column in the table. If there are fewer TC80s than columns, the remaining columns are formatted with the default TC80
        /// formatting. If there are more TC80s than columns, the excess TC80s MUST be ignored.
        var rgTc80: [TC80] = []
        rgTc80.reserveCapacity(Int(self.numberOfColumns))
        while dataStream.position - startPosition < self.cb - 1 {
            rgTc80.append(try TC80(dataStream: &dataStream))
        }
        
        if rgTc80.count < self.numberOfColumns {
            for _ in rgTc80.count..<Int(self.numberOfColumns) {
                rgTc80.append(TC80())
            }
        }
        
        self.rgTc80 = rgTc80
        
        if dataStream.position - startPosition != self.cb - 1 {
            throw OfficeFileError.corrupted
        }
    }
}
