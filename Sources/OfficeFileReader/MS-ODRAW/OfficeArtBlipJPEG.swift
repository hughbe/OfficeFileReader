//
//  OfficeArtBlipJPEG.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.27 OfficeArtBlipJPEG
/// Referenced by: OfficeArtBlip
/// The OfficeArtBlipJPEG record specifies BLIP file data for the Joint Photographic Experts Group (JPEG) format.
public struct OfficeArtBlipJPEG {
    public let rh: OfficeArtRecordHeader
    public let rgbUid1: [UInt8]
    public let rgbUid2: [UInt8]?
    public let tag: UInt8
    public let blipFileData: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): An OfficeArtRecordHeader structure, as defined in section 2.2.1, that specifies the header for this record. The following table
        /// specifies the subfields.
        /// Field Meaning
        /// rh.recVer A value that MUST be 0x0.
        /// rh.recInstance A value that is specified in the following table.
        /// rh.recType A value that MUST be 0xF01D.
        /// rh.recLen An unsigned integer that specifies the number of bytes following the header. This value MUST be the size of BLIPFileData plus 17 if
        /// recInstance equals either 0x46A or 0x6E2, or the size of BLIPFileData plus 33 if recInstance equals either 0x46B or 0x6E3.
        /// Value of recInstance Meaning Number of unique identifiers
        /// 0x46A JPEG in RGB color space 1
        /// 0x46B JPEG in RGB color space 2
        /// 0x6E2 JPEG in CMYK color space 1
        /// 0x6E3 JPEG in CMYK color space 2
        let rh = try OfficeArtRecordHeader(dataStream: &dataStream)
        guard rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard rh.recInstance == 0x46A || rh.recInstance == 0x6E2 || rh.recInstance == 0x46B || rh.recInstance == 0x6E3 else {
            throw OfficeFileError.corrupted
        }
        guard rh.recType == 0xF01D else {
            throw OfficeFileError.corrupted
        }
        
        self.rh = rh
        
        let startPosition = dataStream.position
        
        /// rgbUid1 (16 bytes): An MD4 message digest, as specified in [RFC1320], that specifies the unique identifier of the uncompressed BLIPFileData.
        self.rgbUid1 = try dataStream.readBytes(count: 16)
        
        /// rgbUid2 (16 bytes): An MD4 message digest, as specified in [RFC1320], that specifies the unique identifier of the uncompressed BLIPFileData.
        /// This field only exists if recInstance equals either 0x46B or 0x6E3. If this value is specified, rgbUid1 MUST be ignored.
        if rh.recInstance == 0x46B || rh.recInstance == 0x6E3 {
            self.rgbUid2 = try dataStream.readBytes(count: 16)
        } else {
            self.rgbUid2 = nil
        }
        
        /// tag (1 byte): An unsigned integer that specifies an application-defined internal resource tag. This value MUST be 0xFF for external files.
        self.tag = try dataStream.read()
        
        /// BLIPFileData (variable): A variable-length field that specifies the JPEG data.
        let remainingCount = Int(self.rh.recLen) - (dataStream.position - startPosition)
        self.blipFileData = try dataStream.readBytes(count: remainingCount)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
