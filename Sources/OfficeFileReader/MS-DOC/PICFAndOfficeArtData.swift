//
//  PICFAndOfficeArtData.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-DOC] 2.9.192 PICFAndOfficeArtData
/// The PICFAndOfficeArtData structure specifies header information and binary data for a picture. These structures MUST be stored in the Data Stream
/// at locations that are specified by the sprmCPicLocation value. The range of text that is described by the Chpx structure which contains the
/// sprmCPicLocation value MUST contain the picture character (U+0001).
public struct PICFAndOfficeArtData {
    public let picf: PICF
    public let cchPicName: UInt8?
    public let stPicName: String?
    public let picture: OfficeArtInlineSpContainer
    
    public init(dataStream: inout DataStream) throws {
        /// picf (68 bytes): A PICF structure that specifies the type of the picture, as well as the picture size and border information.
        self.picf = try PICF(dataStream: &dataStream)
        
        /// cchPicName (1 byte): An optional unsigned integer that specifies the size of stPicName. This value MUST exist if and only if picf.mfpf.mm
        /// is MM_SHAPEFILE (0x0066).
        if self.picf.mfpf.mm == .shapeFile {
            self.cchPicName = try dataStream.read()
        } else {
            self.cchPicName = nil
        }
        
        /// stPicName (variable): An optional string of ANSI characters that specifies the full path and file name of the picture. This value MUST exist
        /// if and only if picf.mfpf.mm is MM_SHAPEFILE (0x0066). The length of the string is equal to cchPicName and is not null-terminated.
        if self.picf.mfpf.mm == .shapeFile {
            self.stPicName = try dataStream.readString(count: Int(self.cchPicName!), encoding: .ascii)!
        } else {
            self.stPicName = nil
        }
        
        /// picture (variable): An OfficeArtInlineSpContainer, as specified in [MS-ODRAW] section 2.2.15, that specifies the image.
        self.picture = try OfficeArtInlineSpContainer(dataStream: &dataStream)
    }
}
