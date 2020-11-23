//
//  ShapeFlags10Atom.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-PPT] 2.7.6 ShapeFlags10Atom
/// Referenced by: OfficeArtClientData
/// An atom record that specifies shape-level Boolean flags. More flags are specified in the ShapeFlagsAtom record.
public struct ShapeFlags10Atom {
    public let rh: RecordHeader
    public let reserved1: UInt8
    public let fIsPhotoAlbumPicture: Bool
    public let reserved2: UInt8
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): rh (8 bytes): A RecordHeader structure (section 2.3.1) that specifies the header for this record. Sub-fields are further specified
        /// in the following table.
        /// Field Meaning
        /// rh.recVer MUST be 0x0.
        /// rh.recInstance MUST be 0x000.
        /// rh.recType MUST be RT_ShapeFlags10Atom.
        /// rh.recLen MUST be 0x00000001.
        self.rh = try RecordHeader(dataStream: &dataStream)
        guard self.rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recInstance == 0x000 else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recType == .shapeFlags10Atom else {
            throw OfficeFileError.corrupted
        }
        guard self.rh.recLen == 0x00000001 else {
            throw OfficeFileError.corrupted
        }
        
        let startPosition = dataStream.position
        
        var flags: BitFieldReader<UInt8> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - reserved1 (2 bits): MUST be zero and MUST be ignored.
        self.reserved1 = flags.readBits(count: 2)
        
        /// B - fIsPhotoAlbumPicture (1 bit): A bit that specifies whether a shape is a picture in a photo album specified by the PhotoAlbumInfo10Atom
        /// record. It MAY<96> be ignored.
        self.fIsPhotoAlbumPicture = flags.readBit()
        
        /// reserved2 (5 bits): MUST be zero and MUST be ignored.
        self.reserved2 = flags.readRemainingBits()
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
