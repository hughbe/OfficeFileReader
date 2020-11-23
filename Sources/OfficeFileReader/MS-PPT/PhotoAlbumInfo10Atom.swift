//
//  PhotoAlbumInfo10Atom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.4.9 PhotoAlbumInfo10Atom
/// Referenced by: PP10DocBinaryTagExtension
/// An atom record that specifies information about how to display a presentation as a photo album.
public struct PhotoAlbumInfo10Atom {
    public let rh: RecordHeader
    public let fUseBlackWhite: bool1
    public let fHasCaption: bool1
    public let layout: PhotoAlbumLayoutEnum
    public let unused: UInt8
    public let frameShape: PhotoAlbumFrameShapeEnum
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified in the
        /// following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_PhotoAlbumInfo10Atom (section 2.13.24).
        /// rh.recLen MUST be 0x00000006.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .photoAlbumInfo10Atom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000006 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position

        /// fUseBlackWhite (1 byte): A bool1 (section 2.2.2) that specifies a user preference for whether to display all pictures in grayscale graphics.
        self.fUseBlackWhite = try bool1(dataStream: &dataStream)
        
        /// fHasCaption (1 byte): A bool1 that specifies a user preference for whether a text caption exists beneath each picture in the album.
        self.fHasCaption = try bool1(dataStream: &dataStream)
        
        /// layout (1 byte): A PhotoAlbumLayoutEnum enumeration (section 2.13.20) that specifies a user preference for the layout of the photos
        /// in this presentation.
        let layoutRaw: UInt8 = try dataStream.read()
        guard let layout = PhotoAlbumLayoutEnum(rawValue: layoutRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.layout = layout
        
        /// unused (1 byte): Undefined and MUST be ignored.
        self.unused = try dataStream.read()
        
        /// frameShape (2 bytes): A PhotoAlbumFrameShapeEnum enumeration that specifies a user preference for the shape of the frame around
        /// each photo.
        let frameShapeRaw: UInt16 = try dataStream.read(endianess: .littleEndian)
        guard let frameShape = PhotoAlbumFrameShapeEnum(rawValue: frameShapeRaw) else {
            throw OfficeFileError.corrupted
        }
        
        self.frameShape = frameShape
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
