//
//  SttbFnm.swift
//
//
//  Created by Hugh Bellamy on 07/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.288 SttbFnm
/// The SttbFnm structure is an STTB structure in which the strings specify the file names of the external files that are referenced by this document.
/// Each file name contains the full path of the file, including the name and extension of the file. The extra data that is appended to each string of this
/// STTB is an FNIF which contains additional information about the path. fnpi.fnpd MUST be unique for all FNIF structures in this STTB structure
/// that share the same fnpi.fnpt. Because fnpi is unique for all FNIF structures in this STTB structure, FNPI structures can be used by other structures
/// to reference the file names in this STTB structure.
public struct SttbFnm {
    public let sttb: STTB<String>
    
    public init(dataStream: inout DataStream) throws {
        /// The SttbFnm structure is an STTB with the following additional restrictions on its field values:
        /// fExtend (2 bytes): This value MUST be 0xFFFF.
        /// cbExtra (2 bytes): This value MUST be 0x0008.
        self.sttb = try STTB(dataStream: &dataStream)
        if !self.sttb.fExtend {
            throw OfficeFileError.corrupted
        }
        if self.sttb.cbExtra != 0x0008 {
            throw OfficeFileError.corrupted
        }
    }
}
