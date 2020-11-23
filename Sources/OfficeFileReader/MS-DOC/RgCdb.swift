//
//  RgCdb.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.228 RgCdb
/// The RgCdb structure contains binary data for grammar checker cookies which are stored by grammar checkers that implement the NLCheck interface.
/// The data for a grammar checker cookie is implementation-specific to the grammar checker that created the grammar checker cookie.
public struct RgCdb {
    public let cbTotal: UInt32
    public let ccdb: UInt32
    public let rgdata: [CDB]
    
    public init(dataStream: inout DataStream) throws {
        let startPosition = dataStream.position
        
        /// cbTotal (4 bytes): An unsigned integer that specifies the size of this RgCdb, including cbTotal, in bytes.
        self.cbTotal = try dataStream.read(endianess: .littleEndian)
        
        /// ccdb (4 bytes): An unsigned integer that specifies the number of CDB entries in rgdata.
        self.ccdb = try dataStream.read(endianess: .littleEndian)
        
        /// rgdata (variable): An array of CDB. These entries are accessed by using the icdb field of FCKS
        var rgdata: [CDB] = []
        rgdata.reserveCapacity(Int(self.ccdb))
        for _ in 0..<self.ccdb {
            rgdata.append(try CDB(dataStream: &dataStream))
        }
        
        self.rgdata = rgdata

        if dataStream.position - startPosition != self.cbTotal {
            throw OfficeFileError.corrupted
        }
    }
}
