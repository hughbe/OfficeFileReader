//
//  FibRgCswNewData2000.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.5.12 FibRgCswNewData2000
/// The FibRgCswNewData2000 structure is a variable-sized portion of the Fib.
public struct FibRgCswNewData2000 {
    public let cQuickSavesNew: UInt16
    
    public init(dataStream: inout DataStream) throws {
        /// cQuickSavesNew (2 bytes): An unsigned integer that specifies the number of times that this document was incrementally saved
        /// since the last full save. This value MUST be between 0 and 0x000F, inclusively.
        self.cQuickSavesNew = try dataStream.read(endianess: .littleEndian)
        if self.cQuickSavesNew > 0x000F {
            throw OfficeFileError.corrupted
        }
    }
}
