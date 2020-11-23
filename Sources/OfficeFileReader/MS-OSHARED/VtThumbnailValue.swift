//
//  VtThumbnailValue.swift
//  
//
//  Created by Hugh Bellamy on 11/11/2020.
//

import DataStream

/// [MS-OSHARED] 2.3.3.1.2 VtThumbnailValue
/// Referenced by: VtThumbnail
/// Specifies data for the thumbnail property. This type conforms to the ClipboardData type as specified in [MS-OLEPS] section 2.11, but this
/// section specifies additional detail applicable to this type.
public struct VtThumbnailValue {
    public let cb: UInt32
    public let cftag: UInt32
    public let formatId: UInt32?
    public let cfDataBytes: [UInt8]?
    
    public init(dataStream: inout DataStream) throws {
        /// cb (4 bytes): An unsigned integer that specifies the count of bytes of the remainder of the structure, not including any padding field bytes.
        self.cb = try dataStream.read(endianess: .littleEndian)
        
        /// cftag (4 bytes): An unsigned integer specifying the clipboard format of the data. MUST be 0x00000000, CF_WINDOWS (0xFFFFFFFF),
        /// or CF_MACINTOSH (0xFFFFFFFE). A value of 0x00000000 specifies that there is no image data associated with the property.
        let cftag: UInt32 = try dataStream.read(endianess: .littleEndian)
        if cftag != 0x00000000 && cftag != 0xFFFFFFFF && cftag != 0xFFFFFFFE {
            throw OfficeFileError.corrupted
        }
        
        self.cftag = cftag
        
        let startPosition = dataStream.position
        
        /// formatId (4 bytes): An unsigned integer specifying the format of the data stored in the cfDataBytes field. MUST NOT exist if the cftag
        /// field is 0x00000000. MUST exist if cftag is not 0x00000000. If it exists, it MUST be one of the following: CF_METAFILEPICT (0x00000003),
        /// CF_ENHMETAFILE (0x0000000E), or CF_JPEG (0x00000333).
        if self.cftag != 0x00000000 {
            let formatId: UInt32 = try dataStream.read(endianess: .littleEndian)
            if formatId != 0x00000003 && formatId != 0x0000000E && formatId != 0x00000333 {
                throw OfficeFileError.corrupted
            }
            
            self.formatId = formatId
        } else {
            self.formatId = nil
        }
        
        /// cfDataBytes (variable): An array of bytes containing the data for the thumbnail image. MUST NOT exist if the cftag field is 0x00000000.
        /// MUST exist if cftag is not 0x00000000. If it exists, MUST be (cb - 8) bytes in length. The format of the data is specified by formatId
        /// according to the following table.
        /// formatId Value Data format
        /// CF_METAFILEPICT (0x00000003) A METAFILEPICT structure as specified by [MS-WMF].
        /// CF_ENHMETAFILE (0x0000000E) Enhanced metafile image data as specified in [MS-EMF].
        /// CF_JPEG (0x00000333) Joint Photographic Experts Group (JPEG) image data.
        if self.cftag != 0x00000000 {
            self.cfDataBytes = try dataStream.readBytes(count: Int(self.cb - 8))
        } else {
            self.cfDataBytes = nil
        }
        
        if dataStream.position - startPosition != self.cb {
            throw OfficeFileError.corrupted
        }
        
        /// padding (variable): An array of bytes. The length of the array MUST be the smallest number of bytes required to pad the size of this
        /// structure to a multiple of 4 bytes. The padding SHOULD be 0x00 values, but MAY be undefined values, and MUST be ignored.
        let excessBytes = (dataStream.position - startPosition) % 4
        if excessBytes > 0 {
            let position = dataStream.position + (4 - excessBytes)
            if position > dataStream.count {
                throw OfficeFileError.corrupted
            }
            
            dataStream.position = position
        }
    }
}
