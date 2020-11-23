//
//  TcgSttbfCore.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.319 TcgSttbfCore
/// The TcgSttbfCore structure is an STTB structure whose strings are used by the Acd and Mcd structures. The cData field of this STTB structure is two bytes.
/// This is an extended STTB structure, which means that its cchData fields are 2 bytes in size. The extra data that is appended to each string of this STTB is
/// an unsigned 16-bit integer that specifies the number of references that other structures have to that string.
public struct TcgSttbfCore {
    public let sttb: STTB<String>
    
    public init(dataStream: inout DataStream) throws {
        self.sttb = try STTB(dataStream: &dataStream)
        /// The TcgSttbfCore structure is an STTB that has the following additional restrictions on its field values:
        /// fExtend (2 bytes): This value MUST be 0xFFFF.
        /// cbExtra (2 bytes): This value MUST be 0x2.
        if !self.sttb.fExtend {
            throw OfficeFileError.corrupted
        }
        if self.sttb.cbExtra != 0x2 {
            throw OfficeFileError.corrupted
        }
    }
}
