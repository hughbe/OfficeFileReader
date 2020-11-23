//
//  NilBrc.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

public struct NilBrc {
    public let colorref: UInt32
    public let nilBrc: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// colorref (4 bytes): This field is unused and MUST be ignored.
        self.colorref = try dataStream.read(endianess: .littleEndian)
        
        /// nilBrc (4 bytes): This value MUST be 0xFFFFFFFF.
        self.nilBrc = try dataStream.read(endianess: .littleEndian)
        if self.nilBrc != 0xFFFFFFFF {
            throw OfficeFileError.corrupted
        }
    }
}
