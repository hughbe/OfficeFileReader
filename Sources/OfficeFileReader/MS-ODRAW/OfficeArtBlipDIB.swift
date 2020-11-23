//
//  OfficeArtBlipDIB.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.29 OfficeArtBlipDIB
/// Referenced by: OfficeArtBlip
/// The OfficeArtBlipDIB record specifies BLIP file data for the device-independent bitmap (DIB) format.
public struct OfficeArtBlipDIB {
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
        /// rh.recInstance A value of 0x7A8 to specify one UID, or a value of 0x7A9 to specify two UIDs.
        /// rh.recType A value that MUST be 0xF01F.
        /// rh.recLen An unsigned integer that specifies the number of bytes following the header. This value MUST be the size of BLIPFileData plus 17 if
        /// recInstance equals 0x7A8, or the size of BLIPFileData plus 33 if recInstance equals 0x7A9.
        let rh = try OfficeArtRecordHeader(dataStream: &dataStream)
        guard rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard rh.recInstance == 0x7A8 || rh.recInstance == 0x7A9 else {
            throw OfficeFileError.corrupted
        }
        guard rh.recType == 0xF01F else {
            throw OfficeFileError.corrupted
        }
        
        self.rh = rh
        
        let startPosition = dataStream.position
        
        /// rgbUid1 (16 bytes): An MD4 message digest, as specified in [RFC1320], that specifies the unique identifier of the uncompressed BLIPFileData.
        self.rgbUid1 = try dataStream.readBytes(count: 16)
        
        /// rgbUid2 (16 bytes): An MD4 message digest, as specified in [RFC1320], that specifies the unique identifier of the uncompressed BLIPFileData.
        /// This field only exists if recInstance equals 0x7A9. If this value exists, rgbUid1 MUST be ignored.
        if self.rh.recInstance == 0x7A9 {
            self.rgbUid2 = try dataStream.readBytes(count: 16)
        } else {
            self.rgbUid2 = nil
        }
        
        /// tag (1 byte): An unsigned integer that specifies an application-defined internal resource tag. This value MUST be 0xFF for external files.
        self.tag = try dataStream.read()
        
        /// BLIPFileData (variable): A variable-length field that specifies the DIB data. 
        let remainingCount = Int(self.rh.recLen) - (dataStream.position - startPosition)
        self.blipFileData = try dataStream.readBytes(count: remainingCount)
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
