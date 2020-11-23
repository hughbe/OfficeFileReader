//
//  URLMoniker.swift
//  
//
//  Created by Hugh Bellamy on 09/11/2020.
//

import DataStream
import WindowsDataTypes

/// [MS-OSHARED] 2.3.7.6 URLMoniker
/// Referenced by: HyperlinkMoniker
/// This structure specifies a URL moniker. For more information about URL monikers, see [MSDNURLM].
public struct URLMoniker {
    public let length: UInt32
    public let url: String
    public let serialGUID: GUID?
    public let serialVersion: UInt32?
    public let uriFlags: URICreateFlags?
    
    public init(dataStream: inout DataStream) throws {
        /// length (4 bytes): An unsigned integer that specifies the size of this structure in bytes, excluding the size of the length field.
        /// The value of this field MUST be either the byte size of the url field (including the terminating NULL character) or the byte size of the url
        /// field plus 24.
        /// If the value of this field is set to the byte size of the url field, then the serialGUID, serialVersion, and uriFlags fields MUST NOT be present.
        /// If the value of this field is set to the byte size of the url field plus 24, then the serialGUID, serialVersion, and uriFlags fields MUST be present.
        self.length = try dataStream.read(endianess: .littleEndian)
        
        let startPosition = dataStream.position
        
        /// url (variable): A null-terminated array of Unicode characters that specifies the URL. The number of characters in the array is determined
        /// by the position of the terminating NULL character.
        self.url = try dataStream.readUnicodeString(endianess: .littleEndian)!
        
        if dataStream.position - startPosition == self.length {
            self.serialGUID = nil
            self.serialVersion = nil
            self.uriFlags = nil
            return
        }
        
        /// serialGUID (16 bytes): An optional GUID as specified by [MS-DTYP] for this implementation of the URL moniker serialization. This field
        /// MUST equal {0xF4815879, 0x1D3B, 0x487F, 0xAF, 0x2C, 0x82, 0x5D, 0xC4, 0x85, 0x27, 0x63} if present.
        self.serialGUID = try GUID(dataStream: &dataStream)
        if self.serialGUID != GUID(0xF4815879, 0x1D3B, 0x487F, 0xAF, 0x2C, 0x82, 0x5D, 0xC4, 0x85, 0x27, 0x63) {
            throw OfficeFileError.corrupted
        }
        
        /// serialVersion (4 bytes): An optional unsigned integer that specifies the version number of this implementation of the URL moniker
        /// serialization. This field MUST equal 0 if present.
        self.serialVersion = try dataStream.read(endianess: .littleEndian)
        if self.serialVersion != 0 {
            throw OfficeFileError.corrupted
        }
        
        /// uriFlags (4 bytes): An optional URICreateFlags structure (section 2.3.7.7) that specifies creation flags for an [RFC3986] compliant URI.
        self.uriFlags = try URICreateFlags(dataStream: &dataStream)
    }
}
