//
//  BrcCvOperand.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

public struct BrcCvOperand {
    public let cb: UInt8
    public let rgcv: [COLORREF]
    
    public init(dataStream: inout DataStream) throws {
        /// cb (1 byte): An unsigned integer value that specifies the size, in bytes, of rgcv. This value MUST be 4*n, where n is the number of cells in the
        /// table row.
        self.cb = try dataStream.read(endianess: .littleEndian)
        
        /// rgcv (variable): An array of COLORREF. Each COLORREF specifies the color of the border for the corresponding cell in the table row, starting
        /// from the logical, left-most cell. If any of the COLORREFs in this array have the following value, it specifies that there is no corresponding border.
        /// Member Value
        /// Red 0xFF
        /// Green 0xFF
        /// Blue 0xFF
        /// fAuto 0xFF
        let startPosition = dataStream.position
        var rgcv: [COLORREF] = []
        let count = self.cb / 4
        rgcv.reserveCapacity(Int(count))
        for _ in 0..<count {
            rgcv.append(try COLORREF(dataStream: &dataStream))
        }
        
        self.rgcv = rgcv
        
        if dataStream.position - startPosition != self.cb {
            throw OfficeFileError.corrupted
        }
    }
}
