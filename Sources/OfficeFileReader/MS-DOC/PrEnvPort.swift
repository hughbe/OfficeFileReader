//
//  PrEnvPort.swift
//
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.213 PrEnvPort
/// The PrEnvPort structure specifies print environment information in portrait mode, which is obtained from the printer as a binary block. This is unused and
/// MUST be ignored.
public struct PrEnvPort {
    public let data: [UInt8]
    
    public init(dataStream: inout DataStream, size: UInt32) throws {
        let startPosition = dataStream.position
        
        self.data = try dataStream.readBytes(count: Int(size))
        
        if dataStream.position - startPosition != size {
            throw OfficeFileError.corrupted
        }
    }
}
