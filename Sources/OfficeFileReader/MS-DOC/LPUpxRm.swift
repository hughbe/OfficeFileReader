//
//  LPUpxRm.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.142 LPUpxRm
/// The LPUpxRm structure specifies revision-marking information.
public struct LPUpxRm {
    public let cbUpx: UInt16
    public let rm: UpxRm
    
    public init(dataStream: inout DataStream) throws {
        /// cbUpx (2 bytes): An unsigned 16-bit integer that specifies the size, in bytes, of RM. This value MUST be 0x0006.
        self.cbUpx = try dataStream.read(endianess: .littleEndian)
        if self.cbUpx != 0x0006 {
            throw OfficeFileError.corrupted
        }
        
        /// RM (6 bytes): An UpxRm that specifies revision-marking information.
        let startPosition = dataStream.position
        self.rm = try UpxRm(dataStream: &dataStream)
        
        if dataStream.position - startPosition != self.cbUpx {
            throw OfficeFileError.corrupted
        }
    }
}
