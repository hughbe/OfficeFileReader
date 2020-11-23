//
//  OfficeArtWordDrawing.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.172 OfficeArtWordDrawing
/// The OfficeArtWordDrawing structure specifies information about the drawings in the document. The delay stream that is referenced in [MS-ODRAW] is
/// the WordDocument stream.
public struct OfficeArtWordDrawing {
    public let dgglbl: UInt8
    public let container: OfficeArtDgContainer
    
    public init(dataStream: inout DataStream) throws {
        /// dgglbl (1 byte): An unsigned integer that specifies where container is located. A value of 0x00 specifies that container is in the Main Document.
        /// A value of 0x01 specifies that container is in the Header Document.
        self.dgglbl = try dataStream.read()
        
        /// container (variable): An OfficeArtDgContainer, as specified in [MS-ODRAW] section 2.2.13, that specifies the information about the drawings.
        self.container = try OfficeArtDgContainer(dataStream: &dataStream)
    }
}
