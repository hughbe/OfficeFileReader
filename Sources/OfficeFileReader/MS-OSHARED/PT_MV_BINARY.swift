//
//  PT_MV_BINARY.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.8.16 PT_MV_BINARY
/// Referenced by: EnvRecipientPropertyBlob
/// A recipient property that consists of multiple byte arrays as specified in [MS-OXCDATA].
public struct PT_MV_BINARY {
    public let count: UInt32
    public let data: [[UInt8]]
    
    public init(dataStream: inout DataStream) throws {
        /// Count (4 bytes): An unsigned integer that specifies the number of elements in Data.
        self.count = try dataStream.read(endianess: .littleEndian)
        
        /// Data (variable): An array of PT_BINARY (section 2.3.8.14) as specified in [MS-OXCDATA].
        var data: [[UInt8]] = []
        for _ in 0..<self.count {
            /// PtypBinary 0x0102, %x02.01 Variable size; a COUNT field followed by that many bytes. PT_BINARY
            let count: UInt16 = try dataStream.read(endianess: .littleEndian)
            data.append(try dataStream.readBytes(count: Int(count)))
        }
        
        self.data = data
    }
}
