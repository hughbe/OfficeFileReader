//
//  OfficeArtMetafileHeader.swift
//  
//
//  Created by Hugh Bellamy on 12/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.31 OfficeArtMetafileHeader
/// Referenced by: OfficeArtBlipEMF, OfficeArtBlipPICT, OfficeArtBlipWMF
/// The OfficeArtMetafileHeader record specifies how to process a metafile.
public struct OfficeArtMetafileHeader {
    public let cbSize: UInt32
    public let rcBounds: RECT
    public let ptSize: POINT
    public let cbSave: UInt32
    public let compression: UInt8
    public let filter: UInt8
    
    public init(dataStream: inout DataStream) throws {
        /// cbSize (4 bytes): An unsigned integer that specifies the uncompressed size, in bytes, of the metafile.
        self.cbSize = try dataStream.read(endianess: .littleEndian)
        
        /// rcBounds (16 bytes): A RECT structure, as defined in section 2.2.56, that specifies the clipping region of the metafile.
        self.rcBounds = try RECT(dataStream: &dataStream)
        
        /// ptSize (8 bytes): A POINT structure, as defined in section 2.2.55, that specifies the size, in English Metric Units (EMUs), in which to render the
        /// metafile.
        self.ptSize = try POINT(dataStream: &dataStream)
        
        /// cbSave (4 bytes): An unsigned integer that specifies the compressed size, in bytes, of the metafile.
        self.cbSave = try dataStream.read(endianess: .littleEndian)
        
        /// compression (1 byte): An unsigned integer that specifies the compression method that was used. A value of 0x00 specifies the DEFLATE
        /// compression method, as specified in [RFC1950]. A value of 0xFE specifies no compression.
        self.compression = try dataStream.read()
        
        /// filter (1 byte): An unsigned integer that MUST be 0xFE.
        self.filter = try dataStream.read()
        if self.filter != 0xFE {
            throw OfficeFileError.corrupted
        }
    }
}
