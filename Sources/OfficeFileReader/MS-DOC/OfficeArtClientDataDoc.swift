//
//  OfficeArtClientDataDoc.swift
//
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.169 OfficeArtClientData
/// The OfficeArtClientData structure is used by the OfficeArtSpContainer, as specified in [MSODRAW] section 2.2.14.
public struct OfficeArtClientDataDoc {
    public let rh: OfficeArtRecordHeader
    public let clientdata: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): An OfficeArtRecordHeader, as specified in [MS-ODRAW] section 2.2.1, that specifies information about the structure.
        self.rh = try OfficeArtRecordHeader(dataStream: &dataStream)
        guard self.rh.recLen == 0x0004 else {
            throw OfficeFileError.corrupted
        }
        
        /// clientdata (4 bytes): An integer that SHOULD<230> be ignored.
        self.clientdata = try dataStream.read(endianess: .littleEndian)
    }
}
