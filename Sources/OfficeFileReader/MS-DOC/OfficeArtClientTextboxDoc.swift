//
//  OfficeArtClientTextboxDoc.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.170 OfficeArtClientTextbox
/// The OfficeArtClientTextbox structure used by OfficeArtSpContainer, as specified in [MS-ODRAW] section 2.2.14, that specifies the text identifier for a shape.
public struct OfficeArtClientTextboxDoc {
    public let rh: OfficeArtRecordHeader
    public let clienttextbox: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): An OfficeArtRecordHeader, as specified in [MS-ODRAW] section 2.2.1, that specifies information about the structure.
        self.rh = try OfficeArtRecordHeader(dataStream: &dataStream)
        guard self.rh.recLen == 0x0004 else {
            throw OfficeFileError.corrupted
        }
        
        /// clienttextbox (4 bytes): A 4-byte unsigned integer that specifies the text identifier of the shape, as specified in [MS-ODRAW] section 2.3.21.1.
        /// This value specifies the location of the text for the textbox in the following manner: Dividing the high 2 bytes by 0x10000 specifies a 1-based index
        /// into PlcfTxbxTxt of the FTXBXS structure where the text for this textbox is located. The low 2 bytes specify the zero-based index in the textbox
        /// chain that the textbox occupies.
        self.clienttextbox = try dataStream.read(endianess: .littleEndian)
    }
}
