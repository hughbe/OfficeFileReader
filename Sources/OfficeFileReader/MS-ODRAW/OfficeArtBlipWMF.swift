//
//  OfficeArtBlipWMF.swift
//
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-ODRAW] 2.2.25 OfficeArtBlipWMF
/// Referenced by: OfficeArtBlip
/// The OfficeArtBlipWMF record specifies BLIP file data for the Windows Metafile Format (WMF).
public struct OfficeArtBlipWMF {
    public let rh: OfficeArtRecordHeader
    public let rgbUid1: [UInt8]
    public let rgbUid2: [UInt8]?
    public let metafileHeader: OfficeArtMetafileHeader
    public let blipFileData: [UInt8]
    
    public init(dataStream: inout DataStream) throws {
        /// rh (8 bytes): An OfficeArtRecordHeader structure, as defined in section 2.2.1, that specifies the header for this record. The following table
        /// specifies the subfields.
        /// Field Meaning
        /// rh.recVer A value that MUST be 0x0.
        /// rh.recInstance A value of 0x216 to specify one Unique ID (UID), or a value of 0x217 to specify two UIDs.
        /// rh.recType A value that MUST be 0xF01B.
        /// rh.recLen An unsigned integer that specifies the number of bytes following the header. This value MUST be the size of the BLIPFileData field
        /// plus 50 if recInstance equals 0x216, or the size of BLIPFileData plus 66 if recInstance equals 0x217.
        let rh = try OfficeArtRecordHeader(dataStream: &dataStream)
        guard rh.recVer == 0x0 else {
            throw OfficeFileError.corrupted
        }
        guard rh.recInstance == 0x216 || rh.recInstance == 0x217 else {
            throw OfficeFileError.corrupted
        }
        guard rh.recType == 0xF01B else {
            throw OfficeFileError.corrupted
        }
        
        self.rh = rh
        
        let startPosition = dataStream.position
        
        /// rgbUid1 (16 bytes): An MD4 message digest, as specified in [RFC1320], that specifies the unique identifier of the uncompressed BLIPFileData.
        self.rgbUid1 = try dataStream.readBytes(count: 16)
        
        /// rgbUid2 (16 bytes): An MD4 message digest, as specified in [RFC1320], that specifies the unique identifier of the uncompressed BLIPFileData.
        /// This field only exists if recInstance equals 0x217. If this value is not 0, rgbUid1 MUST be ignored.
        if self.rh.recInstance == 0x217 {
            self.rgbUid2 = try dataStream.readBytes(count: 16)
        } else {
            self.rgbUid2 = nil
        }
        
        /// metafileHeader (34 bytes): An OfficeArtMetafileHeader record, as defined in section 2.2.31, that specifies how to process the metafile in
        /// BLIPFileData.
        self.metafileHeader = try OfficeArtMetafileHeader(dataStream: &dataStream)
        
        /// BLIPFileData (variable): A variable-length field that specifies the WMF data.
        self.blipFileData = try dataStream.readBytes(count: Int(self.metafileHeader.cbSave))
        
        guard dataStream.position - startPosition == self.rh.recLen else {
            throw OfficeFileError.corrupted
        }
    }
}
