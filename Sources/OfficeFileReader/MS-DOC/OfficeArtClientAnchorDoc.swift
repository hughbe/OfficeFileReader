//
//  OfficeArtClientAnchorDoc.swift
//
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.168 OfficeArtClientAnchor
/// The OfficeArtClientAnchor structure is used by OfficeArtSpContainer, as specified in [MS-ODRAW] section 2.2.14, that specifies the location of a drawing.
public struct OfficeArtClientAnchorDoc {
    public let rh: OfficeArtRecordHeader
    public let clientanchor: Int32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): An OfficeArtRecordHeader, as specified in [MS-ODRAW] section 2.2.1, that specifies information about the structure.
        self.rh = try OfficeArtRecordHeader(dataStream: &dataStream)
        guard self.rh.recLen == 0x0004 else {
            throw OfficeFileError.corrupted
        }
        
        /// clientanchor (4 bytes): A 4-byte integer that specifies a valid index into the aCP field of the corresponding PlcfSpa. The CP at this index is the
        /// location of the drawing. A value of -1 specifies an invalid value.
        self.clientanchor = try dataStream.read(endianess: .littleEndian)
    }
}
