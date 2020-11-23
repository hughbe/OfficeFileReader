//
//  PT_MV_STRING8.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.8.15 PT_MV_STRING8
/// Referenced by: EnvRecipientPropertyBlob
/// A recipient property that consists of multiple ANSI character set strings as specified in [MSOXCDATA].
public struct PT_MV_STRING8 {
    public let count: UInt32
    public let data: [String]
    
    public init(dataStream: inout DataStream) throws {
        /// Count (4 bytes): An unsigned integer that specifies the number of elements in Data.
        self.count = try dataStream.read(endianess: .littleEndian)
        
        /// Data (variable): An array of PT_STRING8 (section 2.3.8.12) as specified in [MS-OXCDATA].
        var data: [String] = []
        data.reserveCapacity(Int(self.count))
        for _ in 0..<self.count {
            /// PtypString8 0x001E, %z1E.00 Variable size; a string of multibyte characters in externally specified encoding with terminating null character
            /// (single 0 byte). PT_STRING8
            data.append(try dataStream.readAsciiString()!)
        }
        
        self.data = data
    }
}
