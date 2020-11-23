//
//  Dop2010.swift
//  
//
//  Created by Hugh Bellamy on 08/11/2020.
//

import DataStream

/// [MS-DOC] 2.7.9 Dop2010
/// The Dop2010 structure contains document and compatibility settings. These settings influence the appearance and behavior of the current document and
/// store document-level state.
public struct Dop2010 {
    public let dop2007: Dop2007
    public let docid: UInt32
    public let reserved: UInt32
    public let fDiscardImageData: Bool
    public let empty: UInt32
    public let iImageDPI: UInt32
    
    public init(dataStream: inout DataStream) throws {
        /// dop2007 (674 bytes): A Dop2007 structure (section 2.7.8) that specifies document and compatibility settings.
        self.dop2007 = try Dop2007(dataStream: &dataStream)
        
        /// docid (4 bytes): An unsigned integer that specifies an arbitrary identifier for the context of the paragraph identifiers in the document, as specified
        /// in [MS-DOCX] section 2.6.1.14 (docId). MUST be greater than 0 and less than 0x80000000
        let docid: UInt32 = try dataStream.read(endianess: .littleEndian)
        if docid > 0x80000000 {
            throw OfficeFileError.corrupted
        }
        
        self.docid = docid
        
        /// reserved (4 bytes): This value is undefined and MUST be ignored.
        self.reserved = try dataStream.read(endianess: .littleEndian)
        
        var flags: BitFieldReader<UInt32> = try dataStream.readBits(endianess: .littleEndian)
        
        /// A - fDiscardImageData (1 bit): Specifies whether the cropped-out areas of images are to be discarded when the document is saved as specified
        /// in [MS-DOCX] section 2.6.1.13 (discardImageEditingData).
        self.fDiscardImageData = flags.readBit()
        
        /// empty (31 bits): This value MUST be 0 and MUST be ignored.
        self.empty = flags.readRemainingBits()
        
        /// iImageDPI (4 bytes): An unsigned integer that specifies the resolution at which to save images in the document, as specified in [MS-DOCX]
        /// section 2.6.1.12 (defaultImageDpi).
        self.iImageDPI = try dataStream.read(endianess: .littleEndian)
    }
}
