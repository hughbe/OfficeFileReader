//
//  LPStshi.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.136 LPStshi
/// The LPStshi structure specifies general stylesheet information.
public struct LPStshi {
    public let cbStshi: UInt16
    public let stshi: STSHI
    
    public init(dataStream: inout DataStream) throws {
        /// cbStshi (2 bytes): An unsigned integer that specifies the size, in bytes, of stshi.
        self.cbStshi = try dataStream.read(endianess: .littleEndian)
        
        /// stshi (variable): A stshi that specifies general stylesheet information.
        let startPosition = dataStream.position
        self.stshi = try STSHI(dataStream: &dataStream)

        if dataStream.position - startPosition != self.cbStshi {
            throw OfficeFileError.corrupted
        }
    }
}
